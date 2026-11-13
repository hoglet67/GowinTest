A minimal test case to illustrate incorrect synthesis in Gowin IDE 1.9.12.04.

This test case is for the Tang Nano 20K and it's very small.

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
