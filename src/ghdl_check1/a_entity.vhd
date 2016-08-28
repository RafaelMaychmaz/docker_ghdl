library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity a_entity is
  port(
    clk         : in  std_logic;
    din_enable  : in  std_logic;
    din_value   : in  unsigned(15 downto 0);
    dout_enable : out std_logic;
    dout_value  : out unsigned(15 downto 0)
    );
end a_entity;




