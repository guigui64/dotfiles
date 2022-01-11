#! /usr/bin/env python
import argparse
import json
import os
import re
import shlex
import shutil
import subprocess
import tempfile
from collections import OrderedDict
from distutils.util import strtobool


def execute(cmd, cwd=".", stdout=None, stderr=None, dry=False):
    if dry:
        print(">>", cmd)
        return
    command = shlex.split(cmd)
    p = subprocess.Popen(
        command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=cwd
    )
    (out, err) = p.communicate()
    if p.returncode != 0:
        if err:
            print(err)
        print(out)
        # import pdb
        # pdb.set_trace()
        raise Exception


def update_version(file, version, product, dry=False):
    if dry:
        print(">> # edit version in versions file with version", version)
        return
    extension = os.path.splitext(file)[1]
    if extension == ".json":
        with open(file) as f:
            versions = json.load(f, object_pairs_hook=OrderedDict)
            versions["version"] = version
        with open(file, "w") as f:
            json.dump(versions, f, indent="\t")
    elif extension == ".properties":
        with open(file) as f:
            content = f.read()
        content = re.sub(
            re.escape(product) + r"\.version=.*", product + ".version=" + version, content
        )
        with open(file, "w") as f:
            f.write(content)
    else:
        raise Exception("Unknown version file extension " + extension)


def tag(product, version, options):
    try:
        temp_dir = tempfile.mkdtemp()
        print("Working in temporary folder {}".format(temp_dir))

        print("Clone git@%s:%s/%s.git" % (options.repository, options.group, product))
        cmd = "git clone git@%s:%s/%s.git" % (
            options.repository,
            options.group,
            product,
        )
        execute(cmd, cwd=temp_dir, dry=options.dry_run)

        print("Checkout develop")
        cwd = os.path.join(temp_dir, product)
        cmd = "git checkout develop"
        execute(cmd, cwd=cwd, dry=options.dry_run)

        print("Create local release branch")
        cmd = "git checkout -b release_%s" % (version)
        execute(cmd, cwd=cwd, dry=options.dry_run)

        print("Patching version in %s to %s" % (options.version_file, version))
        update_version(
            os.path.join(cwd, options.version_file),
            version,
            product,
            dry=options.dry_run,
        )

        print("Commit changes")
        cmd = 'git commit -m "Update version" %s' % (options.version_file)
        execute(cmd, cwd=cwd, dry=options.dry_run)

        print("Merge release branch in master")
        cmd = "git checkout master"
        execute(cmd, cwd=cwd, dry=options.dry_run)

        comment = "Version " + version
        if options.delivery_issue_message is not None:
            comment += "\n\n" + options.delivery_issue_message
        cmd = 'git merge --no-ff -X theirs release_%s -m "%s"' % (version, comment,)
        execute(cmd, cwd=cwd, dry=options.dry_run)

        print("Tag master")
        tag_name = (product + "_" + version) if options.name_in_tag else version
        cmd = "git tag -a -m 'Version %s' %s" % (version, tag_name,)
        execute(cmd, cwd=cwd, dry=options.dry_run)

        do_push = False
        if options.noconfirm or options.dry_run:
            do_push = True
        else:
            while True:
                try:
                    do_push = strtobool(
                        input("Do you really want to push the tag to origin ? (y/n) ")
                    )
                except ValueError:
                    pass
                else:
                    break

        if do_push:
            cmd = "git push origin master --tags"
            execute(cmd, cwd=cwd, dry=options.dry_run)
            print("Done")
        else:
            print("Operation cancelled")

        return 0
    except Exception as e:
        print("Error :")
        print(str(e))
        return -1
    finally:
        shutil.rmtree(temp_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Tag a product version automatically")
    parser.add_argument("product", help="Product name")
    parser.add_argument("version", help="Product version")

    parser.add_argument(
        "-r",
        "--repository",
        help="Gitlab repositiory for the product",
        default="simforge.tls.fr.astrium.corp",
    )
    parser.add_argument(
        "-g", "--group", help="Gitlab groupname for the product", default="simtg"
    )

    parser.add_argument(
        "-f",
        "--version-file",
        help="Path to version file to edit",
        default="ant/versions.json",
    )

    parser.add_argument(
        "--noconfirm",
        help="Skip confirmation prompt before pushing to origin",
        action="store_true",
        default=False,
    )

    parser.add_argument(
        "--name-in-tag", help="Prefix tag with product name", action="store_true"
    )

    parser.add_argument(
        "--dry-run",
        help="Print the command that should be executed instead of executing them",
        action="store_true",
    )

    parser.add_argument(
        "-i",
        "--delivery-issue-message",
        help="Details of the delivery issue commit message",
    )

    results = parser.parse_args()

    tag(results.product, results.version, results)
