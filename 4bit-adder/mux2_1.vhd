----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:03 09/30/2020 
-- Design Name: 
-- Module Name:    mux2_1_1bit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux2_1 is
    Port (
        x0: in std_logic_vector (3 downto 0),
        s: out std_logic_vector(3 downto 0),
        sub: in std_logic
    );
end mux2_1;

architecture cond_arch of mux2_1_1bit is
begin
   s <= x0 when sub = '0' else
	    not x0;
end cond_arch;

