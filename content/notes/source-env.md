+++
title = "Easily Source .env files"
date = "2022-02-09T17:11:01-06:00"

[taxonomies]
tags = ["sh", "shell", "dotfiles", "env", "alias", "tooling"]
+++

Quick sh function to easily source .env files. By default sources `.env`, but also lets you pass another file to source

```sh
# Allow easy sourcing of .env files
sourceenv () {
	# Enable export all
	set -a

	if [ -z "$1" ]; then
		echo "Sourcing .env by default"
		if [ -f .env ]; then
			source .env
		else
			echo "No .env exists"
		fi
	else
		source "$1"
	fi

	set +a
}
```
