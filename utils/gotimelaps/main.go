package main

import (
	"fmt"
	"os"
	"time"
)

func usage() {
	fmt.Println("usage: gotimelaps DURATION")
	fmt.Println("where DURATION is any representation of a duration with its unit next to the number")
	fmt.Println("Example: gotimelaps 135s will print 2m15s")
}

func main() {
	if len(os.Args) != 2 {
		fmt.Println("Wrong number of arguments: expected 1 argument")
		usage()
		os.Exit(1)
	}
	if os.Args[1] == "-h" || os.Args[1] == "--help" {
		usage()
		os.Exit(0)
	}
	duration, err := time.ParseDuration(os.Args[1])
	if err != nil {
		panic(err)
	}
	fmt.Print(duration.String())
}
