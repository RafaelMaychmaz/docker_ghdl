library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library std;
use std.env.all;

library lib;
use lib.all;

entity a_testbench is
end entity a_testbench;

architecture bench of a_testbench is

  -- Component to test
  component a_entity is
    port (
      clk         : in  std_logic;
      din_enable  : in  std_logic;
      din_value   : in  unsigned(15 downto 0);
      dout_enable : out std_logic;
      dout_value  : out unsigned(15 downto 0)
      );
  end component a_entity;

  signal clk : std_logic;

  signal din_enable : std_logic;
  signal din_value  : unsigned(15 downto 0);

  signal dout1_enable : std_logic;
  signal dout1_value  : unsigned(15 downto 0);

  signal a_dout2_enable : std_logic;
  signal a_dout2_value  : unsigned(15 downto 0);

  signal b_dout2_enable : std_logic;
  signal b_dout2_value  : unsigned(15 downto 0);

  -- bench tools
  constant CLOCK_HALF_PERIOD : time := 5 ns;
  
begin

  a_instance_1 : a_entity
    port map (
      clk         => clk,
      din_enable  => din_enable,
      din_value   => din_value,
      dout_enable => dout1_enable,
      dout_value  => dout1_value
      );

  a_instance_2 : a_entity
    port map (
      clk         => clk,
      din_enable  => dout1_enable,
      din_value   => dout1_value,
      dout_enable => a_dout2_enable,
      dout_value  => a_dout2_value
      );

  --b_instance_1 : entity lib.b(b_archi2)
  b_instance_1 : configuration lib.b_config
    port map (
      clk         => clk,
      din_enable  => dout1_enable,
      din_value   => dout1_value,
      dout_enable => b_dout2_enable,
      dout_value  => b_dout2_value
      );

  proc_clk : process
  begin
    clk <= '0';
    wait for CLOCK_HALF_PERIOD;
    clk <= '1';
    wait for CLOCK_HALF_PERIOD;
  end process proc_clk;

  proc_upstream : process
  begin
    din_enable <= '0';
    din_value  <= (others => '0');
    for i in 0 to 5 loop
      wait until rising_edge(clk);
    end loop;
    -- feed
    for i in 0 to 3 loop
      din_enable <= '1';
      din_value  <= din_value +1;
      wait until rising_edge(clk);
      din_enable <= '0';
      wait until rising_edge(clk);
    end loop;
    wait;
  end process proc_upstream;

  proc_downstream : process(clk)
  begin
    if rising_edge(clk) then
      if a_dout2_enable = '1' then
        report string'("(A) dout2_value = ") & integer'image(to_integer(a_dout2_value));
      end if;
      if b_dout2_enable = '1' then
        report string'("(B) dout2_value = ") & integer'image(to_integer(b_dout2_value));
      end if;
    end if;
  end process proc_downstream;

  proc_end_of_simulation : process
  begin
    wait for 1 us;
    report "End of simulation";
    finish(0);
    wait;
  end process proc_end_of_simulation;

end bench;

