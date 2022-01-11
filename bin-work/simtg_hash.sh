#!/bin/bash
echo -ne "simtg:$1" | sha1sum | cut -c -8
