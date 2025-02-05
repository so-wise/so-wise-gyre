# prepare run

# will need to make sure that ERA5 is linked
# --- this only needs to be done once
#ln -s ../../../../../ERA5/bin/ ../ERA5

# executable
ln -s ../build/mitgcmuv .

# namelist files
ln -s ../input/* .

# bathymetry, grid files
ln -s ../setup/topo_outputs/bathy_gyre .
ln -s ../setup/topo_outputs/delR .
ln -s ../setup/topo_outputs/delY .
ln -s ../setup/topo_outputs/draft_gyre .

# initial conditions
ln -s ../input_files/*.ini .

# pressure load file
ln -s ../input_files/pload_gyre .

# boundary conditions
ln -s ../input_files/*OBCS* .

# some helpful scripts
ln -s ../scripts/run.test.slurm .
ln -s ../scripts/cleanup.sh .
