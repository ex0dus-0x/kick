# kick

__kick__ is a tiny security utility written in Ruby for deauthenticating users off of your current LAN.
It utilizes a rudimentary ARP-spoofing attack in order to stop users from connecting to a default gateway.

## Features

* __Small and portable__ - written in around ~300 lines of Ruby, and implements a smaller runtime executable.
* __Modes of operation__ - kick can operate independently on the CLI, or it can spin up a small web-based service.

## How to Use

It is recommended that __kick__ is used within a Linux-based system running a `root` user as default account (ie. Kali), since Packetfu requires priviledge to interface with wireless interfaces.

__kick__ uses the following dependencies:

* macaddr
* ipscanner
* packetfu
* sinatra
* colorize
* terminal-table

### Install

You can run this one-liner to quickly pull down the repository and install dependencies:

```
$ curl https://raw.githubusercontent.com/ex0dus-0x/kick/master/scripts/install | sudo /bin/bash
```

or build locally:

```
$ git clone https://github.com/ex0dus-0x/kick && cd kick/
$ bundle install
$ ./kick
```

### Usage

```
$ ruby kick.rb -h
Usage: ./kick [options]
    -i, --interface IFACE            Input network interface, otherwise defaults
    -a, --address ADDRESS            Input target address, otherwise prints host table
    -m, --mode MODE                  Input mode to start, web or cli
    -h, --help                       Show this message
```

You __must__ specify a mode to execute! kick supports `cli` and `web` mode. You do not need to specify an address through `-address` when using `web` mode, but you can specify an interface through `--interface`

If you do not provide an interface through `--interface`, the default is according to your computer's network interface configuration. If you do not provide a target IP address, a host table will be displayed for your convenience and will ask for your selection.

Example Usage:

```
# CLI mode: Deauths address 192.168.1.123 on wlan0 interface
./kick -m cli -i wlan0 -a 192.168.1.123

# CLI mode: wlan0 interface, with host table for deauth options
./kick -m cli -i wlan0

# Web interface mode
./kick -m web
```

## Contributing

I will NOT be supporting this tool anymore, but if any outstanding issues are found, please do make an [issue](https://github.com/ex0dus-0x/kick/issues) and I will try my best to resolve it!

## License

[MIT License](https://codemuch.tech/license.txt)
