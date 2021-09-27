#!/usr/bin/env bash
zola build
curl -L https://github.com/giodamelio/stork/releases/download/v10000.0.0/stork-ubuntu-20-04 -o stork
chmod +x stork
./stork build --input public/stork.toml/index.html --output public/notes.st