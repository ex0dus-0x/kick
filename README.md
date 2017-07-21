# byebye
Deauthenticate users off of your local area network.

---

## How to use

    Usage: ./byebye [options]
        -i, --interface IFACE            Input network interface, otherwise defaults
        -a, --address ADDRESS            Input target address, otherwise prints host table
        -m, --mode MODE                  Input mode to start, web or cli
        -h, --help                       Show this message


You __must__ specify a mode to execute! byebye supports `cli` and `web`
mode. You do not need to specify an address through `-address` when using `web` mode, but you can specify an interface through `-interface`

If you do not provide an interface through `--interface`, the default is according to your computer's network interface configuration. If you do not provide a target IP address, a host table will be displayed for your convenience and will ask for your selection.

# Installation

Make sure you have Ruby, `gem` and `bundler` all on your system.

    git clone https://github.com/ex0dus-0x/byebye
    cd /path/to/byebye
    bundle install
    ./byebye

or, you may use the `install` executable in the `bin/` directory to clean-install many of the needed dependencies. A one-liner will be available soon.

### Example
    
    cli mode
    ./byebye -m cli -i wlan1 -a 192.168.1.5
    
    web mode
    ./byebye -m web -i eth1

### TODO:

* Reload terminal-table with "r" option
* Verbosity
* "Hail-Mary" style attack.
* Test web version a lil more.
* Make a installer one-liner