#!/usr/bin/env bash
zola build
rustup default stable
cargo install --git https://github.com/giodamelio/stork --branch hacked-toml-frontmatter
stork build --input public/stork.toml/index.html --output public/notes.st