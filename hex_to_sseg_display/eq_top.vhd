----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2023 09:32:41
-- Design Name: 
-- Module Name: eq_top2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity eq_top2 is
    Port ( 
           sseg : out STD_LOGIC_VECTOR (7 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           clk: in  std_logic
           );
end eq_top2;

architecture Behavioral of eq_top2 is
signal led3, led2, led1, led0 :  std_logic_vector(7 downto 0);
signal led4, led5, led6, led7 :  std_logic_vector(7 downto 0);
signal res1, res2, res3, res4 :  std_logic_vector(3 downto 0);
signal sum1, sum2, sum3, sum4 :  unsigned(3 downto 0);
begin
    sum1 <= unsigned(sw(3 downto 0)) + 1;
    sum2 <= unsigned(sw(7 downto 4)) + 1;
    sum3 <= unsigned(sw(11 downto 8)) + 1;
    sum4 <= unsigned(sw(15 downto 12)) + 1;
    
    res1 <= std_logic_vector(sum1(3 downto 0));
    res2 <= std_logic_vector(sum2(3 downto 0));
    res3 <= std_logic_vector(sum3(3 downto 0));
    res4 <= std_logic_vector(sum4(3 downto 0));
    
    display1: entity work.hex_to_sseg(arch)
        port map(
            hex => sw(3 downto 0),
            sseg => led0,
            dp => '1' 
        );
        
    display2: entity work.hex_to_sseg(arch)
         port map(
               hex => sw(7 downto 4),
               sseg => led1,
               dp => '1' 
          );
          
     display3: entity work.hex_to_sseg(arch)
            port map(
                hex => sw(11 downto 8),
                sseg => led2,
                dp => '1' 
             );
     display4: entity work.hex_to_sseg(arch)
            port map(
                 hex => sw(15 downto 12),
                 sseg => led3,
                 dp => '1' 
             );
             
             
     display5: entity work.hex_to_sseg(arch)
                     port map(
                         hex => res1,
                         sseg => led4,
                         dp => '1' 
                     );
                     
             display6: entity work.hex_to_sseg(arch)
                      port map(
                            hex => res2,
                            sseg => led5,
                            dp => '1' 
                       );
                       
                  display7: entity work.hex_to_sseg(arch)
                         port map(
                             hex => res3,
                             sseg => led6,
                             dp => '1' 
                          );
                  display8: entity work.hex_to_sseg(arch)
                         port map(
                              hex => res4,
                              sseg => led7,
                              dp => '1' 
                          );

     mux: entity work.led_mux8(arch)
            port map(
              clk => clk,
              reset => '0',
              in0 => led0,
              in1 => led1,
              in2 => led2,
              in3 => led3,
              in4 => led4,
              in5 => led5,
              in6 => led6,
              in7 => led7,
              an => an,
              sseg => sseg  
            );
end Behavioral;


