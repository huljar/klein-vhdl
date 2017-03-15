--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:12:43 03/13/2017
-- Design Name:   
-- Module Name:   /home/julian/Projekt/Xilinx Projects/klein-vhdl/sim/klein-64_tb.vhd
-- Project Name:  klein-vhdl
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: klein_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE work.util.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY klein80_tb IS
END klein80_tb;
 
ARCHITECTURE behavior OF klein80_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT klein_top
    GENERIC(
         k : key_enum
        );
    PORT(
         plaintext : IN  std_logic_vector(63 downto 0);
         key : IN  std_logic_vector(key_bits(k)-1 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         ciphertext : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal plaintext : std_logic_vector(63 downto 0) := (others => '0');
   signal key : std_logic_vector(79 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal ciphertext : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: klein_top GENERIC MAP (
          k => K_80
        ) PORT MAP (
          plaintext => plaintext,
          key => key,
          clk => clk,
          reset => reset,
          ciphertext => ciphertext
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
      variable ct: line;
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- Test the test vectors specified in the KLEIN paper.
      -- first test vector
      reset <= '1';
      plaintext <= x"FFFFFFFFFFFFFFFF";
      key <= x"00000000000000000000";
      wait for 10 ns;
      reset <= '0';
      wait for 170 ns;
      hwrite(ct, ciphertext);
      report "Ciphertext is " & ct.all & " (expected value: 6677E20D1A53A431)";
      deallocate(ct);
      
      -- second test vector
      reset <= '1';
      plaintext <= x"0000000000000000";
      key <= x"FFFFFFFFFFFFFFFFFFFF";
      wait for 10 ns;
      reset <= '0';
      wait for 170 ns;
      hwrite(ct, ciphertext);
      report "Ciphertext is " & ct.all & " (expected value: 82247502273DCC5F)";
      deallocate(ct);
      
      -- third test vector
      reset <= '1';
      plaintext <= x"FFFFFFFFFFFFFFFF";
      key <= x"1234567890ABCDEF1234";
      wait for 10 ns;
      reset <= '0';
      wait for 170 ns;
      hwrite(ct, ciphertext);
      report "Ciphertext is " & ct.all & " (expected value: 3F210F67CB23687A)";
      deallocate(ct);
      
      -- fourth test vector
      reset <= '1';
      plaintext <= x"1234567890ABCDEF";
      key <= x"00000000000000000000";
      wait for 10 ns;
      reset <= '0';
      wait for 170 ns;
      hwrite(ct, ciphertext);
      report "Ciphertext is " & ct.all & " (expected value: BA5239E93E784366)";
      deallocate(ct);

      wait;
   end process;

END;
