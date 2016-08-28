#!/bin/bash

ghdl --version

echo "Compile : analysis of a design file"
ghdl -a --work=lib --std=08 -g -fprofile-arcs -ftest-coverage a_entity.vhd
ghdl -a --work=lib --std=08 -g -fprofile-arcs -ftest-coverage a_archi1.vhd
ghdl -a --work=lib --std=08 -g -fprofile-arcs -ftest-coverage a_archi2.vhd

ghdl -a --work=lib --std=08 -g -fprofile-arcs -ftest-coverage b.vhd
ghdl -a --work=lib --std=08 -g -fprofile-arcs -ftest-coverage b_config.vhd

ghdl -a --work=lib --std=08 -g -fprofile-arcs -ftest-coverage a_testbench.vhd
ghdl -a --work=lib --std=08 -g -fprofile-arcs -ftest-coverage a_tb_config.vhd

echo "Build executable"
ghdl -e --work=lib --std=08 -Wl,-lgcov -Wl,--coverage test

echo "Call the executable program"
ghdl -r --work=lib --std=08 test


