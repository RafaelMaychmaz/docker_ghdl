#!/bin/sh

# --------------------------------------------------------------------------------------------------
# LICENSE
# --------------------------------------------------------------------------------------------------
# ! # License #
# ! Copyright 2016 Rafael CATROU
# !
# ! Licensed under the Apache License, Version 2.0 (the "License");
# ! you may not use this file except in compliance with the License.
# ! You may obtain a copy of the License at
# !
# !     http://www.apache.org/licenses/LICENSE-2.0
# !
# ! Unless required by applicable law or agreed to in writing, software
# ! distributed under the License is distributed on an "AS IS" BASIS,
# ! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# ! See the License for the specific language governing permissions and
# ! limitations under the License.
# !
# --------------------------------------------------------------------------------------------------

echo "# -------------------------------------------------------------------------------------------"
echo "# Download GCC core"
echo "# -------------------------------------------------------------------------------------------"
DOWNLOAD_PATH=`pwd`
PREFIX_PATH=/root/tools/gcc

PREFIX_FINAL_GCC_PATH=/usr/local

MIRROR=http://www.netgull.com/gcc/releases

GCC_VERSION=gcc-4.9.4
GCC_ARCHIVE_FILE=${GCC_VERSION}.tar.gz

echo "Download ${GCC_VERSION} from ${MIRROR}"
wget ${MIRROR}/${GCC_VERSION}/${GCC_ARCHIVE_FILE}

echo "Extract archive ${GCC_ARCHIVE_FILE}"
tar zxvf ${GCC_ARCHIVE_FILE}
\rm ${GCC_ARCHIVE_FILE}

echo "# -------------------------------------------------------------------------------------------"
echo "# Download GCC dependencies"
echo "# -------------------------------------------------------------------------------------------"
cd ${DOWNLOAD_PATH}/${GCC_VERSION}
./contrib/download_prerequisites

echo "# -------------------------------------------------------------------------------------------"
echo "# Download GHDL"
echo "# -------------------------------------------------------------------------------------------"
cd ${DOWNLOAD_PATH}
git clone https://github.com/tgingold/ghdl.git

echo "# -------------------------------------------------------------------------------------------"
echo "# Configure GHDL + copy sources"
echo "# -------------------------------------------------------------------------------------------"
cd ${DOWNLOAD_PATH}/ghdl
# First configure ghdl, specify gcc source dir and prefix
./configure --with-gcc=${DOWNLOAD_PATH}/${GCC_VERSION} --prefix=${PREFIX_FINAL_GCC_PATH}
# Then invoke make to copy ghdl sources in the source dir:
make copy-sources

echo "# -------------------------------------------------------------------------------------------"
echo "# Build GCC -> GMP"
echo "# -------------------------------------------------------------------------------------------"
cd ${DOWNLOAD_PATH}/${GCC_VERSION}
# Get version of Tool
GMP_VERSION=`ls -d */ | grep 'gmp-.*' | sed 's#/$##'`
MPFR_VERSION=`ls -d */ | grep 'mpfr-.*' | sed 's#/$##'`
MPC_VERSION=`ls -d */ | grep 'mpc-.*' | sed 's#/$##'`

echo "GMP_VERSION=${GMP_VERSION}"
echo "MPFR_VERSION=${MPFR_VERSION}"
echo "MPC_VERSION=${MPC_VERSION}"

# To build gcc, you must first compile gmp, mpfr and mpc
mkdir gmp-objs
cd gmp-objs

../${GMP_VERSION}/configure \
   --disable-shared \
   --enable-static \
   --prefix=${PREFIX_PATH}

make
make check
make install



echo "# -------------------------------------------------------------------------------------------"
echo "# Build GCC -> MPFR"
echo "# -------------------------------------------------------------------------------------------"
cd ..; mkdir mpfr-objs; cd mpfr-objs

../${MPFR_VERSION}/configure \
   --disable-shared \
   --enable-static \
   --prefix=${PREFIX_PATH} \
   --with-gmp=${PREFIX_PATH}

make
make check
make install



echo "# -------------------------------------------------------------------------------------------"
echo "# Build GCC -> MPC"
echo "# -------------------------------------------------------------------------------------------"
cd ..; mkdir mpc-objs; cd mpc-objs

../${MPC_VERSION}/configure \
   --disable-shared \
   --enable-static \
   --prefix=${PREFIX_PATH} \
   --with-gmp=${PREFIX_PATH} \
   --with-mpfr=${PREFIX_PATH}

make
make check
make install


echo "# -------------------------------------------------------------------------------------------"
echo "# Build GCC -> Configure GCC"
echo "# -------------------------------------------------------------------------------------------"
cd ${DOWNLOAD_PATH}/${GCC_VERSION}

mkdir gcc-objs; cd gcc-objs

../configure \
    --prefix=${PREFIX_FINAL_GCC_PATH} \
    --enable-languages=c,vhdl \
    --disable-bootstrap \
    --with-gmp=${PREFIX_PATH} \
    --disable-lto \
    --disable-multilib \
    --disable-libssp \
    --disable-libgomp \
    --disable-libquadmath


make
make check
make install MAKEINFO=true

echo "# -------------------------------------------------------------------------------------------"
echo "# Build and install VHDL Librarie"
echo "# -------------------------------------------------------------------------------------------"
cd ${DOWNLOAD_PATH}/ghdl

echo "STEP MAKE GHDLLIB"
make ghdllib

echo "STEP MAKE INSTALL"
make install
