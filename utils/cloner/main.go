package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

var defaultUser string = "guigui64"

const github string = "https://github.com"

func main() {
	args := os.Args[1:]
	check(args)

	var url string
	if strings.HasPrefix(args[0], "git@") {
		url = args[0]
	} else {
		paths := strings.Split(args[0], "/")
		if len(paths) == 1 {
			url = strings.Join([]string{github, defaultUser, paths[0]}, "/")
		} else if len(paths) == 2 {
			url = strings.Join([]string{github, paths[0], paths[1]}, "/")
		} else {
			url = args[0]
		}
	}
	fmt.Println("Cloning", url)
	cmd := exec.Command("git", "clone", url)
	execAndStream(cmd)
}

func execAndStream(cmd *exec.Cmd) {
	stderr, err := cmd.StderrPipe()
	if err != nil {
		panic(err)
	}
	err = cmd.Start()
	if err != nil {
		panic(err)
	}

	scanner := bufio.NewScanner(stderr)
	for scanner.Scan() {
		fmt.Println(scanner.Text())
	}
	cmd.Wait()
}

func check(args []string) {
	if len(args) == 0 {
		usage()
		os.Exit(1)
	}
	if args[0] == "--help" || args[0] == "-h" {
		usage()
		os.Exit(0)
	}
}

func loadEnv() {
	if user, found := os.LookupEnv("CLONER_DEFAULT_USER"); found {
		defaultUser = user
	}
}

func usage() {
	fmt.Printf("Usage: %s <path>\n", os.Args[0])
	fmt.Println("where <path> can be in the following forms:")
	fmt.Println(" * foo ==> this will try to clone https://github.com/defaultUser/foo (defaultUser is expanded from environment variable CLONER_DEFAULT_USER and defaults to guigui64)")
	fmt.Println(" * bar/foo ==> this will try to clone https://github.com/bar/foo")
	fmt.Println(" * https://gitlab.my.corp/bar/foo ==> this will try to clone https://gitlab.my.corp/bar/foo")
	fmt.Println(" * git@gitlab.my.corp:bar/foo ==> this will try to clone git@gitlab.my.corp:bar/foo")
}
