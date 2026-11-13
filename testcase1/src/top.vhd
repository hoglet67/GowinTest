library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity top is
    port (
        clock       : in    std_logic;
        btn1        : in    std_logic;
        btn2        : in    std_logic;
        led         : out   std_logic_vector(5 downto 0)
        );
end entity;

architecture rtl of top is

signal t01 : std_logic;
signal t10 : std_logic;
signal t11 : std_logic;

begin

    t01 <= not btn1 and     btn2;
    t10 <=     btn1 and not btn2;
    t11 <=     btn1 and     btn2;

    test : entity work.core
        port map (
            clock => clock,
            a0 => t01,
            a1 => t10,
            ax => t11,
            b0 => t01,
            b1 => t10,
            bx => t11,
            led => led
            );

end architecture;
