library ieee;
use ieee.std_logic_1164.all;

package util is
    type key_enum is (K_64, K_80, K_96);
    type key_lookup is array(key_enum) of integer;
    constant key_bits: key_lookup := (
        K_64 => 64,
        K_80 => 80,
        K_96 => 96
    );
    type rc_lookup is array(key_enum) of std_logic_vector(4 downto 0);
    constant final_rc: rc_lookup := (
        K_64 => "01101",
        K_80 => "10001",
        K_96 => "10101"
    );
end package;
