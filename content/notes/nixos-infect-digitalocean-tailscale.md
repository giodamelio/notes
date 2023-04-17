+++
title = "Simple Digital Ocean NixOS with Tailscale"
date = "2023-04-16T18:38:06-07:00"

[taxonomies]
tags = ["nixos", "nix", "digitalocean", "cloud-init", "tailscale"]
+++

Here is a simple cloud init config to create a new NixOS box on Digitalocean with [nix-infect](https://github.com/elitak/nixos-infect). Be sure to replace the authkey `tskey-auth-abcd` with a real one.

```nix
#cloud-config
write_files:
- path: /etc/nixos/host.nix
  permissions: '0644'
  content: |
    {pkgs, ...}:
    {
      environment.systemPackages = with pkgs; [ vim wget curl tailscale ];

      services.tailscale.enable = true;

      systemd.services.tailscale-autoconnect = {
        description = "Automatic connection to Tailscale";

        # Ensure Tailscale is running first
        after = [ "network-pre.target" "tailscale.service" ];
        wants = [ "network-pre.target" "tailscale.service" ];
        wantedBy = [ "multi-user.target" ];

        # Just run this once
        serviceConfig.Type = "oneshot";

        # Simple script to auth with Tailscale if it has not already been done
        script = with pkgs; ''
          # Tailscale can be sleepy
          sleep 2

          # If tailscaled is already active, do nothing
          status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
          if [ $status = "Running" ]; then
            exit 0
          fi

          # If not active, restart with an authkey
          ${tailscale}/bin/tailscale up -authkey tskey-auth-abcd
        '';
      };

    }
runcmd:
  - curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | PROVIDER=digitalocean NIXOS_IMPORT=./host.nix NIX_CHANNEL=nixos-22.11 bash 2>&1 | tee /tmp/infect.log
```
