# vim: filetype=bash

_shortpath() {
    echo "$1" | sed "s:$HOME:~:" | sed -r "s:(\w)[^/]+/:\1/:g"
}

_git_summary() {
    changes=$(git diff --shortstat | sed 's/^[^0-9]*\([0-9]*\)[^0-9]*\([0-9]*\)[^0-9]*\([0-9]*\)[^0-9]*/~\1+\2-\3/')
    [ -n $changes ] && changes=" $changes"
    status=$(git rev-parse --abbrev-ref HEAD)
    echo "$status$changes"
}

# Conversion functions
h2d(){
    echo "ibase=16; $*"|bc
}
d2h(){
    echo "obase=16; $*"|bc
}
