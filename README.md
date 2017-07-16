# byebye
Deauthenticate users off of your local area network.

---

## How to use

Quite simple actually.

    Usage: ./byebye [options]
      -i, --interface IFACE            Input network interface, otherwise defaults
      -a, --address ADDRESS            Input target address, otherwise prints host table
      -h, --help                       Show this message

If you do not provide an interface through `--interface`, the default is `wlan0`. If you do not provide a target IP address, a host table will be displayed for your convenience and will ask for your selection.

# Installation

Make sure you have Ruby, `gem` and `bundler` all on your system.

    git clone https://github.com/ex0dus-0x/byebye
    cd /path/to/byebye
    bundle install
    ./byebye


### Example

    ./byebye -i wlan1 -a 192.168.1.5

### TODO:

* Write Sinatra web version support
* Reload terminal-table with "r" option
* Verbosity
    