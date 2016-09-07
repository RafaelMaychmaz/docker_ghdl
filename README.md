# Docker: GHDL with GCC backend

### Table of Contents
**[Goal](#goal)**  
**[Demo](#demo)**  
**[Example](#example)**

## Goal

Provide a full build of [GHDL](https://github.com/tgingold/ghdl) with GCC backend using [Docker](https://www.docker.com/).

## Demo

### Get the image

Having [Docker](https://www.docker.com/) installed is a prerequisite (see [installation instructions](https://docs.docker.com/engine/installation/) to install it).

The following command will pull a container with:
+ Ubuntu 16.04 (from parent container)
+ GNAT Ada 2016 (from parent container)
+ GHDL v0.34 with GCC backend
```bash
sudo docker pull rafaelcatrou/docker_ghdl:v1.2
```

### Run

```bash
sudo docker run --rm -t -i rafaelcatrou/docker_ghdl:v1.2 /bin/bash
```

## Example

An example is provided in the docker container. It can be run by the following command:
```bash
cd /root/tools/ghdl_check1/ghdl.bash
./ghdl.bash
```

Below is its expected output:
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
