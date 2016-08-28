library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity b is
  port(
    clk         : in  std_logic;
    din_enable  : in  std_logic;
    din_value   : in  unsigned(15 downto 0);
    dout_enable : out std_logic;
    dout_value  : out unsigned(15 downto 0)
    );
end b;



architecture b_archi1 of b is
begin

  proc_add : process(clk)
  begin
    if rising_edge(clk) then
      dout_enable <= din_enable;
      if din_enable = '1' then
        dout_value <= resize(din_value * 2,dout_value'length);
      end if;
    end if;
  end process proc_add;

end b_archi1;



architecture b_archi2 of b is
begin

  proc_add : process(clk)
  begin
    if rising_edge(clk) then
      dout_enable <= din_enable;
      if din_enable = '1' then
        dout_value <= resize(din_value * 3,dout_value'length);
      end if;
    end if;
  end process proc_add;

end b_archi2;
