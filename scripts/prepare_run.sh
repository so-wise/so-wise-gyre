# prepare run

# executable
ln -s ../build/mitgcmuv .

# namelist files
ln -s ../input/* .

# bathymetry, grid files
ln -s ../setup/topo_outputs/bathy_gyre .
ln -s ../setup/topo_outputs/delR .
ln -s ../setup/topo_outputs/delY .
ln -s ../setup/topo_outputs/draft_gyre .

# some helpful scripts
ln -s ../scripts/run.test.slurm .
ln -s ../scripts/cleanup.sh .
