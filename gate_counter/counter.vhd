library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity bin_counter is
   port(
     clk : in std_logic;
     reset : in std_logic;
      inc, dec   : in  std_logic;
      q        : out std_logic_vector(7 downto 0)
   );
end bin_counter;

architecture arch of bin_counter is
signal q_reg  : unsigned(7 downto 0);
signal q_next : unsigned(7 downto 0);
begin
process(clk, reset)
   begin
      if reset = '1' then
         q_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         q_reg <= q_next;
      end if;
   end process;
   -- register
   process(inc,dec)
   begin
    if inc = '1' then
          if q_reg(3 downto 0) = "1001" then
            q_next <= q_reg + 7;
          else
            q_next <= q_reg + 1;
          end if;
    elsif dec = '1' and q_reg /= "0000000" then
          if q_reg(3 downto 0) = "0000" then
                q_next <= q_reg - 7;
              else
                q_next <= q_reg - 1;
              end if;
         
    else
        q_next <= q_reg;
    end if;      
   end process;
   q <= std_logic_vector(q_reg(7 downto 0));
end arch;