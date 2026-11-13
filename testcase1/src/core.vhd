library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity core is
    port (
        clock       : in    std_logic;
        a0          : in    std_logic;
        a1          : in    std_logic;
        ax          : in    std_logic;
        b0          : in    std_logic := '0';
        b1          : in    std_logic := '1';
        bx          : in    std_logic;
        led         : out   std_logic_vector(5 downto 0)
        );
end entity;

architecture rtl of core is

begin

    process(clock)
    begin
        if rising_edge(clock) then
            led <= "111111" xor (bx & b1 & b0 & ax & a1 & a0);
        end if;
    end process;

end architecture;
