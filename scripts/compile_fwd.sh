#!/bin/bash

# Tested with these modules on ARCHER2
#  1) cce/11.0.4        4) libfabric/1.11.0.4.71    7) xpmem/2.2.40-7.0.1.0_2.7__g1d7a24d.shasta  10) PrgEnv-cray/8.0.0  13) load-epcc-module
#  2) craype/2.7.6      5) craype-network-ofi       8) cray-mpich/8.1.4                           11) bolt/0.7
#  3) craype-x86-rome   6) perftools-base/21.02.0   9) cray-libsci/21.04.1.1                      12) epcc-setup-env

# select the compiling environment
module load cce/11.0.4 craype/2.7.6 craype-x86-rome libfabric/1.11.0.4.71 craype-network-ofi perftools-base/21.02.0
module load xpmem/2.2.40-7.0.1.0_2.7__g1d7a24d.shasta cray-mpich/8.1.4 cray-libsci/21.04.1.1 PrgEnv-cray/8.0.0 bolt/0.7
module load epcc-setup-env load-epcc-module
#module load cray-netcdf-hdf5parallel
#module load cray-hdf5-parallel

# set the following environment variables
export MITGCM_ROOTDIR=../../../../MITgcm
export PATH=$MITGCM_ROOTDIR/tools:$PATH
#export MITGCM_OPT=$MITGCM_ROOTDIR/tools/build_options/dev_linux_amd64_gnu_archer2
export MITGCM_OPT=$MITGCM_ROOTDIR/tools/build_options/linux_ia64_cray_archer2

# make the make file
../../../tools/genmake2 -mpi -mods ../code/ -optfile $MITGCM_OPT
make depend
make

