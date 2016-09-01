# Docker: GHDL with GCC backend

### Table of Contents
**[Goal](#goal)**  
**[Demo](#demo)**  
**[Example](#example)**

## Goal

Provide a full build of GHDL with GCC backend using docker.

## Demo

### Build (facultative)

Build GHDL with GCC as backend using Docker
```bash
sudo docker build -t="docker_ghdl" .
```

### Get the image

Execute the following to get the image:
```bash
sudo docker pull rafaelcatrou/docker_ghdl_backend_gcc
```

### Run

```bash
sudo docker run --rm -t -i rafaelcatrou/docker_ghdl_backend_gcc /bin/zsh
```

## Example

Start the image, then
```bash
cd /root/tools/ghdl_check1/ghdl.bash
./ghdl.bash
```

If all is fine the output shall be:
<pre>
GHDL 0.34dev (20151126) [Dunoon edition]
 Compiled with GNAT Version: GPL 2016 (20160515-49)
 GCC back-end code generator
Written by Tristan Gingold.

Copyright (C) 2003 - 2015 Tristan Gingold.
GHDL is free software, covered by the GNU General Public License.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Compile : analysis of a design file
Build executable
Call the executable program
a_testbench.vhd:104:9:@85ns:(report note): (A) dout2_value = 4
a_testbench.vhd:107:9:@85ns:(report note): (B) dout2_value = 6
a_testbench.vhd:104:9:@105ns:(report note): (A) dout2_value = 5
a_testbench.vhd:107:9:@105ns:(report note): (B) dout2_value = 9
a_testbench.vhd:104:9:@125ns:(report note): (A) dout2_value = 6
a_testbench.vhd:107:9:@125ns:(report note): (B) dout2_value = 12
a_testbench.vhd:104:9:@145ns:(report note): (A) dout2_value = 7
a_testbench.vhd:107:9:@145ns:(report note): (B) dout2_value = 15
a_testbench.vhd:115:5:@1us:(report note): End of simulation
simulation finished @1us with status 0
</pre>