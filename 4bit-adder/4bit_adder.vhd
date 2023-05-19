use IEEE.STD_LOGIC_1164.ALL;

entity fbit_adder is
    Port(
        x0: in std_logic_vector(3 downto 0);
        x1: in std_logic_vector(3 downto 0);
        co: out std_logic;
        ci: in std_logic;
        s: out std_logic_vector(3 downto 0);
    );
end fbit_adder;

architecture fbit of fbit_adder is
    signal co1, co2, co3: std_logic;

begin
    somador1: entity work.somador_completo(soma)
        port map(
            ci => ci,
            a => x0(0),
            b => x1(0),
            s => s(0),
            co => co1
        );

    somador2: entity work.somador_completo(soma)
        port map(
            ci => co1,
            a => x0(1),
            b => x1(1),
            s => s(1),
            co => co2
        );

    somador3: entity work.somador_completo(soma)
        port map(
            ci => co2,
            a => x0(2),
            b => x1(2),
            s => s(2),
            co => co3
        );

    somador4: entity work.somador_completo(soma)
        port map(
            ci => co3,
            a => x0(3),
            b => x1(3),
            s => s(3),
            co => co
        );
end fbit