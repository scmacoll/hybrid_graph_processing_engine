#!/bin/bash
# Bulk download Gleam dependencies

mkdir -p libs
cd libs

# Clone all known dependencies from GitHub
git clone https://github.com/gleam-lang/gleeunit.git || echo "gleeunit already exists"
git clone https://github.com/gleam-lang/gleam-otp.git || echo "gleam-otp already exists"
git clone https://github.com/gleam-lang/stdlib.git || echo "stdlib already exists"
git clone https://github.com/gleam-lang/erlang.git gleam_erlang || echo "gleam_erlang already exists"

echo "Dependencies downloaded to the 'libs' directory."
