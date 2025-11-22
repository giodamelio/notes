+++
title = "SSH Port Forwarding"
date = "2025-11-22T00:00:00-06:00"

[taxonomies]
tags = ["ssh", "port-forwarding", "tunneling", "networking", "cli"]
+++

SSH port forwarding allows you to tunnel network connections through SSH.

## Local Port Forwarding (Access Remote Service Locally)

Expose a remote port on your local machine:

    ssh -N -L 8080:localhost:80 user@remote-server

Now visiting `localhost:8080` on your machine connects to port 80 on the remote server.

### Flags:
- `-N` - Don't execute a remote command (just forward ports)
- `-L [local_port]:[destination_host]:[destination_port]` - Local port forwarding
  - `8080` - Local port to listen on
  - `localhost` - Destination host (from remote server's perspective)
  - `80` - Destination port

## Remote Port Forwarding (Expose Local Service Remotely)

Expose a local port on the remote server:

    ssh -N -R 9090:localhost:3000 user@remote-server

Now connections to port 9090 on the remote server are forwarded to port 3000 on your local machine.

### Flags:
- `-N` - Don't execute a remote command (just forward ports)
- `-R [remote_port]:[destination_host]:[destination_port]` - Remote port forwarding
  - `9090` - Remote port to listen on
  - `localhost` - Destination host (from your local machine's perspective)
  - `3000` - Destination port
