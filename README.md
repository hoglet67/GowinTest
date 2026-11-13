A minimal test case to illustrate incorrect synthesis in Gowin IDE 1.9.12.04.

This test case is for the Tang Nano 20K and it's very small:
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

The presence of a default value on core ports b0 and b1 case the
signals connected to those ports to be ignored.

The result is that LEDs 3 and 4 have incorrect fixed values.

You can see this in the synthesis simulation output:

  OBUF led_3_obuf (
    .O(led[3]),
    .I(VCC)
);
  OBUF led_4_obuf (
    .O(led[4]),
    .I(GND)
);

Removing the default values from these ports in core.vhd fixes the issue.
