# gnu compilation environment
module restore PrgEnv-gnu

# load relevant modules
module load cray-netcdf-hdf5parallel
module load cray-hdf5-parallel

# set environment variables
export MITGCM_ROOTDIR=../../../../MITgcm/
export PATH=$MITGCM_ROOTDIR/tools:$PATH
export MITGCM_OPT=$MITGCM_ROOTDIR/tools/build_options/linux_amd64_gfortran_archer2

# make the make file
../../../tools/genmake2 -mpi -mods ../code/ -optfile $MITGCM_OPT

# make the executable
make depend
make adtaf
make adall
