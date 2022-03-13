#!/bin/bash
set -x

for dot in */; do
    stow -D -t "$HOME" $dot
done
