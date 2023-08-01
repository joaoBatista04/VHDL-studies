----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 30.06.2023 10:07:18
-- Design Name:
-- Module Name: top_level - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( btn : in STD_LOGIC_VECTOR (1 downto 0);
           an : out std_logic_vector(7 downto 0);
           sseg : out std_logic_vector(7 downto 0);
           clk : in std_logic
           );
end top_level;

architecture Behavioral of top_level is
signal car_en, car_ex :  std_logic;
signal btn1, btn2 : std_logic;
signal num_atual : std_logic_vector(7 downto 0);
begin
    db_fsm : entity work.portao_fsm(arch)
        port map(
            clk => clk,
            a => btn1,
            b => btn2,
            car_enter => car_en,
            car_exit => car_ex
        );
      debounce_fsm1 : entity work.db_fsm(arch)
          port map(
            clk => clk,
            reset => '0',
            sw => btn(0),
            db => btn1
          );
         
      debounce_fsm2 : entity work.db_fsm(arch)
                    port map(
                      clk => clk,
                      reset => '0',
                      sw => btn(1),
                      db => btn2
                    );
      contador : entity work.bin_counter(arch)
        port map(
            clk => clk,
            reset => '0',
            inc => car_en,
            dec => car_ex,
            q => num_atual
        );
       
        mux_disp : entity work.disp_hex_mux(arch)
            port map(
                clk => clk,
                reset => '0',
                hex0 => num_atual(3 downto 0),
                hex1 => num_atual(7 downto 4),
                hex2 => "0000",
                hex3 => "0000",
                dp_in => "1111",
                an => an(3 downto 0),
                sseg => sseg                
            );

end Behavioral;