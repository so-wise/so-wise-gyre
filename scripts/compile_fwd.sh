# gnu compilation environment
module restore PrgEnv-gnu

# set environment variables
export MITGCM_ROOTDIR=../../../../MITgcm/
export PATH=$MITGCM_ROOTDIR/tools:$PATH
export MITGCM_OPT=$MITGCM_ROOTDIR/tools/build_options/linux_amd64_gfortran_archer2

# make the make file
../../../tools/genmake2 -mpi -mods ../code/ -optfile $MITGCM_OPT

# make the executable
make depend
make
