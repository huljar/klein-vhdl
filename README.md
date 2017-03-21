# KLEIN block cipher - VHDL implementation

This is an implementation of the KLEIN lightweight block cipher
as described in [this paper](https://link.springer.com/chapter/10.1007/978-3-642-25286-0_1).
It encrypts individual blocks of 64 bit length with either a
64, 80, or 96 bit key.

## Implementation

The key size to use is specified via an *enum*, which is passed
as generic parameter `k` to the *klein_top* top level module.

## License
The code is licensed under the terms of the MIT license. For more
information, please see the [LICENSE.md](LICENSE.md) file.
