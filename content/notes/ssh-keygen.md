+++
title = "SSH Key Generation"
date = "2021-12-11T15:06:59-06:00"

[taxonomies]
tags = ["ssh", "keygen", "crypto", "cli", "linux"]
+++

Generate a good SSH key. [Full `man` page](https://man7.org/linux/man-pages/man1/ssh-keygen.1.html).

## Generate an EDD25519 Key

    ssh-keygen -t ed25519 -f ./<key_name>
    
