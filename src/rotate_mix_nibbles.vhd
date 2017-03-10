library ieee;
use ieee.std_logic_1164.all;

entity rotate_mix_nibbles is
    port(data_in:  in std_logic_vector(63 downto 0);
         data_out: out std_logic_vector(63 downto 0)
    );
end entity;

architecture structual of rotate_mix_nibbles is
    signal rotated: std_logic_vector(63 downto 0);
begin
    rotated <= data_in(47 downto 0) & data_in(63 downto 48);
    -- TODO: MixColumns step
    data_out <= rotated;
end architecture;
