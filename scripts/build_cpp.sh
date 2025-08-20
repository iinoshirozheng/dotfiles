#!/bin/bash

# Build script for C++ projects
set -euo pipefail

mkdir -p build && cd build
cmake ..
make
