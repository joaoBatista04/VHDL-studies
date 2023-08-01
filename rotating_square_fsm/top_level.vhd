library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity db_fsm is
   port(
      clk   : in std_logic;
      sw    : in std_logic_vector(1 downto 0);
      an    : out std_logic_vector(7 downto 0);
      sseg  : out std_logic_vector(7 downto 0)
   );
end db_fsm;

architecture arch of db_fsm is
   constant N : integer := 49999999; 
    signal enable : std_logic;
    signal reset  : std_logic;
    signal divide_clk : integer range 0 to N;
    type db_state_type is 
         (s0,s1,s2,s3,s4,s5,s6,s7);
   signal state_reg     : db_state_type;
   signal state_next    : db_state_type;
begin
   --*****************************************************************
   -- counter to generate 10 ms tick
   --*****************************************************************
 enable <= '1' when divide_clk = N else '0';
 reset <= '0';
 PROCESS (clk)
           BEGIN
               IF (clk'EVENT AND clk='1') THEN
                   divide_clk <= divide_clk+1;
                   IF divide_clk = N THEN
                       divide_clk <= 0;
                   END IF;
               END IF;
END PROCESS;
   --*****************************************************************
   -- debouncing FSM
   --*****************************************************************
   -- state register
   process(clk,reset)
   begin
      if (reset='1') then
         state_reg <= s0;
      elsif (clk'event and clk='1') then
         if enable='1' then
            state_reg <= state_next;
         end if;
      end if;
   end process;
   -- next-state/output logic
   process(state_reg,sw)
   begin
      state_next <= state_reg; --default: back to same state
      case state_reg is
         when s0 =>
            if sw(0)='1' then
               if sw(1)='1' then
                   state_next <= s1;
               else
                   state_next <= s7;
               end if;
            end if;
         when s1 =>
            if sw(0)='1' then
               if sw(1)='1' then
                    state_next <= s2;
               else
                    state_next <= s0;
               end if;
            end if;
         when s2 =>
            if sw(0)='1' then
               if sw(1)='1' then
                  state_next <= s3;
               else
                  state_next <= s1;
               end if;
            end if;
         when s3 =>
            if sw(0)='1' then 
               if sw(1)='1' then
                  state_next <= s4;
               else
                  state_next <= s2;
               end if;
            end if;
         when s4 =>
            if sw(0)='1' then
                if sw(1)='1' then
                    state_next <= s5;
                 else
                    state_next <= s3;
                 end if;
            end if;
         when s5 =>
            if sw(0)='1' then
               if sw(1)='1' then
                   state_next <= s6;
               else
                   state_next <= s4;
               end if;
            end if;
         when s6 =>
            if sw(0)='1' then
               if sw(1)='1' then
                  state_next <= s7;
               else
                  state_next <= s5;
               end if;
            end if;
         when s7 =>
            if sw(0)='1' then
               if sw(1)='1' then
                  state_next <= s0;
               else
                  state_next <= s6;
               end if;
            end if;
      end case;
   end process;
   
   process(state_reg)
      begin
         case state_reg is
            when s0 =>
               an <= "11110111";
               sseg <= "10011100";
            when s1 =>
               an <= "11111011";
               sseg <= "10011100";
            when s2 =>
               an <= "11111101";
               sseg <= "10011100";
            when s3 =>
               an <= "11111110";
               sseg <= "10011100";
            when s4 =>
               an <= "11111110";
               sseg <= "10100011";
            when s5 =>
               an <= "11111101";
               sseg <= "10100011";
            when s6 =>
               an <= "11111011";
               sseg <= "10100011";
            when s7 =>
               an <= "11110111";
               sseg <= "10100011";
         end case;
      end process;
end arch;