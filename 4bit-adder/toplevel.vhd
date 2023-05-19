library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity toplevel is
    Port(
        sw: in std_logic_vector(8 downto 0);
        led: out std_logic_vector(4 downto 0);
    );
end toplevel;

architecture Behavioral of toplevel is
    signal mux_out: std_logic_vector(3 downto 0);
    signal adder_out: std_logic_vector(3 downto 0);

begin
    mux2_1: entity work.mux2_1(cond_arch)
        port map(
            x0 => sw(3 downto 0),
            sub => sw(8),
            s => mux_out
        );

    somador: entity work.fbit_adder(fbit)
        port map(
            x0 => mux_out,
            x1 => sw(7 downto 4),
            ci => sw(8),
            s => adder_out
        );

    led(3 downto 0) <= adder_out;
    led(4) <= ((mux_out(3) and sw(7) and not adder_out(3)) or (not mux_out(3) and not sw(7) and adder_out(3)));

end Behavioral;