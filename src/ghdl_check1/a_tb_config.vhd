library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library lib;

configuration test of a_testbench is
  for bench
    for a_instance_1 : a_entity
      use entity lib.a_entity(a_archi1);
    end for;
    for a_instance_2 : a_entity
      use entity lib.a_entity(a_archi2);
    end for;
  end for;
end configuration test;
