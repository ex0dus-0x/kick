# kick

Penetration testing tool for deauthenticating hosts off of LANs. 

## intro

__kick__ is a penetration testing tool that enables an attacker to deauthenticate users off of their local area network. It relieson sending malformed ARP packets, resulting in an ARP spoof attack.

## How to use
    
    ruby kick.rb -h
    Usage: ./kick [options]
        -i, --interface IFACE            Input network interface, otherwise defaults
        -a, --address ADDRESS            Input target address, otherwise prints host table
        -m, --mode MODE                  Input mode to start, web or cli
        -h, --help                       Show this message


You __must__ specify a mode to execute! kick supports `cli` and `web`
mode. You do not need to specify an address through `-address` when using `web` mode, but you can specify an interface through `-interface`

If you do not provide an interface through `--interface`, the default is according to your computer's network interface configuration. If you do not provide a target IP address, a host table will be displayed for your convenience and will ask for your selection.

Example Usage:
    
    # CLI mode: Deauths address 192.168.1.123 on wlan0 interface
    ./kick -m cli -i wlan0 -a 192.168.1.123
    
    # CLI mode: wlan0 interface, with host table for deauth options
    ./kick -m cli -i wlan0     

    # Web interface mode
    ./kick -m web

## install 

### quick

```
$ curl https://raw.githubusercontent.com/ex0dus-0x/kick/master/bin/install | sudo /bin/bash
```

### manual

```
$ git clone https://github.com/ex0dus-0x/kick && cd kick/
$ bundle install
$ ./kick
```
