library ieee;
use ieee.std_logic_1164.all;

entity somador_completo is
    Port(
        a, b, ci: in std_logic;
        co, s: out std_logic;
    );
end somador_completo;

architecture soma of somador_completo is
    begin

        co <= ((b and ci) or (a and ci) or (a and b));
        s <= a xor b xor ci;
    end soma;