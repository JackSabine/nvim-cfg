#!/bin/bash

# Bash unofficial strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

parent_abs_path=$(dirname "$(readlink -f "$0")")

ln -s ${parent_abs_path} ~/.config/nvim

