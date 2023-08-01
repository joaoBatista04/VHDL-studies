library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity portao_fsm is
   port(
      clk   : in std_logic;
      a, b  : in std_logic;
      car_enter, car_exit : out std_logic
   );
end portao_fsm;

architecture arch of portao_fsm is
   constant N : integer := 49999999;
    signal enable : std_logic;
    signal reset  : std_logic;
    signal divide_clk : integer range 0 to N;
    type db_state_type is
         (start, entrando, meio1, fim_entrada, entrou, saindo, meio2, fim_saida, saiu);
   signal state_reg     : db_state_type;
   signal state_next    : db_state_type;
begin
   --*****************************************************************
   -- counter to generate 10 ms tick
   --*****************************************************************
 enable <= '1';
 reset <= '0';
   --*****************************************************************
   -- debouncing FSM
   --*****************************************************************
   -- state register
   process(clk,reset)
   begin
      if (reset='1') then
         state_reg <= start;
      elsif (clk'event and clk='1') then
         if enable='1' then
            state_reg <= state_next;
         end if;
      end if;
   end process;
   -- next-state/output logic
   process(state_reg,a, b)
   begin
      state_next <= state_reg; --default: back to same state
      case state_reg is
         when start =>
            if a='1' then
               state_next <= entrando;
            elsif b='1' then
                state_next <= saindo;
            end if;
         when entrando =>
            if a = '1' and b = '1' then
                state_next <= meio1;
            elsif a = '0' then
                state_next <= start;
            end if;
         when meio1 =>
            if a = '0' then
                state_next <= fim_entrada;
            elsif b = '0' then
                state_next <= entrando;
            end if;
         when fim_entrada =>
            if b = '0' then
               state_next <= entrou;
            elsif a = '1' then
               state_next <= meio1;
            end if;
         when entrou =>
            state_next <= start;
         when saindo =>
            if a = '1' and b = '1' then
               state_next <= meio2;
            elsif b = '0' then
               state_next <= start;
            end if;
         when meio2 =>
            if b = '0' then
               state_next <= fim_saida;
            elsif a = '0' then
               state_next <= saindo;
            end if;
         when fim_saida =>
            if a = '0' then
               state_next <= saiu;
             elsif b = '1' then
               state_next <= meio2;
            end if;
         when saiu =>
            state_next <= start;
      end case;
   end process;
   
   process(state_reg)
      begin
         case state_reg is
            when entrou =>
               car_enter <= '1';
               car_exit <= '0';
            when saiu =>
                car_enter <= '0';
                car_exit <= '1';
            when others =>
                car_enter <= '0';
                car_exit <= '0';
         end case;
      end process;
end arch;
