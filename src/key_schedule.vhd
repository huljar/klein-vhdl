library ieee;
use ieee.std_logic_1164.all;
use work.util.all;

entity key_schedule is
    generic(k: key_enum);
    port(data_in:  in std_logic_vector(key_bits(k)-1 downto 0);
         rc:       in std_logic_vector(4 downto 0);
         data_out: out std_logic_vector(key_bits(k)-1 downto 0)
    );
end key_schedule;

architecture structural of key_schedule is
    signal rotated, swapped: std_logic_vector(key_bits(k)-1 downto 0);

    component sbox
        port(data_in:  in std_logic_vector(3 downto 0);
             data_out: out std_logic_vector(3 downto 0)
        );
    end component;
begin
    rotated <= data_in(key_bits(k)-9 downto key_bits(k)/2) & data_in(key_bits(k)-1 downto key_bits(k)-8) &
               data_in((key_bits(k)/2)-9 downto 0) & data_in((key_bits(k)/2)-1 downto (key_bits(k)/2)-8);

    swapped <= rotated((key_bits(k)/2)-1 downto 0) &
               (rotated(key_bits(k)-1 downto key_bits(k)/2) xor rotated((key_bits(k)/2)-1 downto 0));

    data_out(key_bits(k)-1 downto key_bits(k)-19) <= swapped(key_bits(k)-1 downto key_bits(k)-19);
    data_out(key_bits(k)-20 downto key_bits(k)-24) <= swapped(key_bits(k)-20 downto key_bits(k)-24) xor rc;
    GEN_SBOXES: for i in 0 to 3 generate
        SX: sbox port map(
            data_in => swapped((key_bits(k)/2)-9-(4*i) downto (key_bits(k)/2)-9-(4*i)-3),
            data_out => data_out((key_bits(k)/2)-9-(4*i) downto (key_bits(k)/2)-9-(4*i)-3)
        );
    end generate;
    data_out((key_bits(k)/2)-25 downto 0) <= swapped((key_bits(k)/2)-25 downto 0);
end architecture;
