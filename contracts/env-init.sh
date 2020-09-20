#!/usr/bin/env bash
set -ex

EOS_NODE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$EOS_NODE_DIR/push-action
