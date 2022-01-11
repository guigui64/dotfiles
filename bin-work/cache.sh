#!/bin/bash

set -u

prefix="${SIMANT_CACHE:-$HOME/tmp/SIMANT_CACHE}"
scanned_dirs=("/tools/simtg/" "/models/" "/projects/")
separator=":"
deps=""
rsync_out_opt="--info=progress2"
dry_run=false

help() {
    echo "Usage: $(basename "$0") [-h|--help] [--prefix=PREFIX] [--separator=\":\"] [--mute-rsync] [--dry-run] DEPS [DEPS [...]]"
    echo "Where DEPS in a list of paths to cache, separated by the specified separator"
}

for opt in "$@"; do
    case $opt in
        -h|--help)
            help
            exit 0
            ;;
        --prefix=*)
            prefix="${opt#--prefix=}"
            echo "[option] prefix set to $prefix"
            ;;
        --separator=*)
            separator="${opt#--separator=}"
            echo "[option] separator set to \"$separator\""
            ;;
        --mute-rsync)
            rsync_out_opt=""
            ;;
        --dry-run)
            dry_run=true
            echo "[option] doing a dry run"
            ;;
        -*)
            echo "ERROR: Unrecognized option $opt"
            help
            exit 1
            ;;
        *)
            deps="$deps$separator$opt"
            ;;
    esac
done

if [ -z "$deps" ] ; then
    echo "No deps to cache !"
    exit 0
fi

cache() {
    dep=$1
    concerned=false
    path=""
    for scanned_dir in "${scanned_dirs[@]}" ; do
        if [[ "$dep" == "$scanned_dir"* ]] ; then
            concerned=true
            if [[ "$scanned_dir" == "/projects/" ]] ; then
                path=$prefix/${dep#/projects/[^/]*/}
            else
                path=$prefix/${dep#$scanned_dir}
            fi
            break
        fi
    done
    if ! $concerned ; then
        echo "[skip] $dep not concerned"
        return
    fi
    if [ -d "$path" ] ; then
        echo "[skip] $dep already cached in $path"
        return
    fi
    echo "Caching dependency $dep..."
    if $dry_run ; then
        echo mkdir -p "$path"
        echo rsync $rsync_out_opt -az "$dep/" "$path"
    else
        mkdir -p "$path"
        rsync $rsync_out_opt -az "$dep/" "$path"
    fi
}

main() {
    IFS=$separator read -r -a depsArray <<< "$deps"
    for dep in "${depsArray[@]}" ; do
        [ -z "$dep" ] && continue
        cache "$dep"
    done
}

main
