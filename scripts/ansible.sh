#!/bin/sh
script_dir=$(dirname "$0")
. "$script_dir/python.sh"
pip install ansible-lint
