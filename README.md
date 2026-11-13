A minimal test case to illustrate incorrect synthesis in Gowin IDE 1.9.12.04.

This test case is for the Tang Nano 20K and it's very small: just two
modules (top and core). The complete example is checked into the
repository.

top:
```
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
```

core:
```
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
```

The presence of default values on core ports b0 and b1 cause the
signals connected to those ports to be ignored. The result is that
LEDs 3 and 4 have incorrect fixed values.

You can see this in the synthesis simulation output:
```
  OBUF led_3_obuf (
    .O(led[3]),
    .I(VCC)
);
  OBUF led_4_obuf (
    .O(led[4]),
    .I(GND)
);
```

Removing the default values from these ports in core.vhd fixes the issue.

The example works as expected in Gowin EDA 1.9.12.01.

Unable to test 1.9.12.02 and 1.9.12.03 as they are no longer available
for download.
