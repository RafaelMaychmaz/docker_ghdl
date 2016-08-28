library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture a_archi1 of a_entity is
begin

  proc_add : process(clk)
  begin
    if rising_edge(clk) then
      dout_enable <= din_enable;
      if din_enable = '1' then
        dout_value <= din_value + 1;
      end if;
    end if;
  end process proc_add;

end a_archi1;
