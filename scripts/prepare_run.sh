# prepare run

# will need to make sure that ERA5 is linked
ln -s ../../../../../ERA5/grib/ ../ERA5

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

# boundary conditions
ln -s ../input_files/*OBCS* .

# some helpful scripts
ln -s ../scripts/run.test.slurm .
ln -s ../scripts/cleanup.sh .
