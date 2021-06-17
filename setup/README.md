# so-wise-setup
Repository for setting up SO-WISE model configurations

## Setup for the SO-WISE (gyre) congifuration

![image](https://user-images.githubusercontent.com/11757453/112142689-d2238880-8bce-11eb-98d0-98d1e9db2e45.png)

This page describes the creation of the domain and forcing files used in the SO-WISE gyre configuration. It is a record for transparency and reproducibility. 

We can base the initial configuration around B-SOSE and two setups from Kaitlin Naughten. 

FRIS999 setup: [https://github.com/knaughten/UaMITgcm/tree/master/example/FRIS_999](https://github.com/knaughten/UaMITgcm/tree/master/example/FRIS_999)

WFRIS999 setup: [https://github.com/knaughten/UaMITgcm/tree/master/example/WSFRIS_999](https://github.com/knaughten/UaMITgcm/tree/master/example/WSFRIS_999)

(Kaitlin's advice is to take the EXF configuration from FRIS999 and everything else from WFRIS999)

The steps below are based on those in Kaitlin Naughten's wiki associated with her python package: 

[https://github.com/knaughten/mitgcm_python/wiki/Creating-a-new-MITgcm-domain](https://github.com/knaughten/mitgcm_python/wiki/Creating-a-new-MITgcm-domain)

## Install mitgcm_python

The mitgcm_python package is a toolkit for constructing model setups in MITgcm. On BAS HPC, navigate to a suitable directory on the Expose drive. Next, cloned a fresh copy of MITgcm and mitgcm_python:

```
git clone https://github.com/mitgcm/mitgcm
git clone https://github.com/knaughten/mitgcm_python
```
If you're using tsch, use this command to set a required environment variable:

```
setenv PYTHONPATH (path_to_mitgcm)/MITgcm/utils/python/MITgcmutils
```

Note that this environment variable is only set for a single terminal session. One could add it to a startup script, if desired. At present, mitgcm_python is written in Python 2, so you have to switch modules. You also need to load NetCDF for I/O:

```
module swap python/conda3 python/conda-python-2.7.14
module load netcdf
```

Finally, start up ipython by entering `ipython` in the terminal and import the packages:

```
import mitgcm_python
import MITgcmutils
```

Importing packages gives python access to the code in the listed modules.

## Establish the grid and bathymetry

### Define lat-lon points
Next, define the grid using the 'latlon_points' function as follows. You will need to import some specific utilities:
```
from mitgcm_python.make_domain import *
```
For the SO-WISE (gyre) grid, we will try this initial configuration:
```
lon, lat = latlon_points(-85, 90, -84.2, -30, 0.25, 'topo_outputs/delY')
```
Which produces the following:
```
Northern boundary moved to -29.9313968126
Writing delY

Changes to make to input/data:
xgOrigin=275
ygOrigin=-84.2
dxSpacing=0.25
delYfile='delY' (and copy this file into input/)

Nx = 700 which has the factors [1, 2, 4, 5, 7, 10, 14, 20, 25, 28, 35, 50, 70, 100, 140, 175, 350, 700]
Ny = 558 which has the factors [1, 2, 3, 6, 9, 18, 31, 62, 93, 186, 279, 558]
If you are happy with this, proceed with interp_bedmap2. At some point, choose your tile size based on the factors and update code/SIZE.h.
Otherwise, tweak the boundaries and try again.
```
We typically want tiles in the 15-30 grid cell range, which suggests we use some combination of these:
```
Nx = {20, 25, 28}
Ny = {18, 31},
```
which puts the number of cores between 360 and 868. On ARCHER2, there are 128 cores per node, and 16 cores per NUMA region. Advice is forthcoming on how to best distribute processes on ARCHER2 (see the eCSE project led by Emma Boland at BAS).

### Interpolate BEDMAP2 and GEBCO bathymetry
Next, we'll create the bathymetry file using the `interp_bedmap2` tool. For now, we won't include the optional bathymetry corrections or grounded icebergs. These can be added later if needed. First, create a bathymetric input directory and link to the required files:
```
mkdir topo_inputs
cd topo_inputs
ln -s /data/oceans_input/raw_input_data/bedmap2/bedmap2_bin/* .
ln -s /data/oceans_input/raw_input_data/GEBCO/GEBCO_2014_2D.nc .
cd ..
mkdir topo_outputs
mv delY topo_outputs
```
Next, in python, set some variables and call `interp_bedmap2`:
```
topo_dir='topo_inputs'
nc_outfile='topo_outputs/sowise_gyre_bathy.nc'
interp_bedmap2(lon, lat, topo_dir, nc_outfile)
```
This will make a combined BEDMAP2/GEBCO bathymetry file. Here is some of the output from this function:
```
The results have been written into topo_outputs/sowise_gyre_bathy.nc
Take a look at this file and make whatever edits you would like to the mask (eg removing everything west of the peninsula; you can use edit_mask if you like). Then set your vertical layer thicknesses in a plain-text file, one value per line (make sure they clear the deepest bathymetry of 7933.9877905 m), and run remove_grid_problems
```
We shouldn't need to clear any deeper than 6000 m. We don't need to represent the entirety of the South Sandwich Trench.

### Edit land mask
We can make some manual edits to the mask at this point. For simplicity, we can fill out everything  north of 45°S west of 70°W. This part of the Pacific Ocean can be ignored for this application (although pay attention to it later; it may cause some problems down the line). In the file `make_domain.py`, I added the following key:
```
    elif key == 'SO-WISE-GYRE':
        # SO-WISE (gyre configuration)
        # Block out everything west of South America [xmin, xmax, ymin, ymax]
        omask = mask_box(omask, lon_2d, lat_2d, xmin=-85.0, xmax=-70.0, ymin=-50, ymax=-30)
        # Fill everything deeper than 6000 m
        bathy[bathy<-6000] = -6000
```
This key has been incorporated into the main `mitgcm_python` repository. The following comment produces the edited mask:
```
edit_mask('topo_outputs/sowise_gyre_bathy.nc', 'topo_outputs/sowise_gyre_bathy_edited.nc', key='SO-WISE-GYRE')
```
The edited mask is stored in `topo_outputs` for future reference. 

### Choose vertical layer thickness
At present, this is done outside the `mitgcm_python` repository. Some Matlab code has been included in this `so-wise-gyre/setup` repository for defining the vertical grid. The key feature of this grid is the gradual increasing of vertical thickness, as to limit the production of suprious numerical waves that can be generated by large, rapid changes in resolution. In the example code below, the growth in cell thickness is limited by a factor of 1.031, which is an experimentally-determined factor that produces the required total depth, given the selected number of vertical levels. The code `setup/define_delR` can be used to explore different vertical grids. For example:
```
% set parameters
Nz = 100;            % number of depth levels
delR_top = 10.0;     % thickness of uppermost cell
ddz_dk = 1.03;      % rate of change of cell thickness

%% Define vertical levels

% build vertical grid using gradual increase
delR_gradual(1) = delR_top; 
for n=2:Nz
    delR_gradual(n) = ddz_dk*delR_gradual(n-1); %#ok<*SAGROW>
end

delR_gradual = round(delR_gradual,1);

```
Note that the sum of these thickness values must exceed the deepest value of the bathymetry. 

Note that 100 vertical levels is a big number. That's quite a lot, but we do need lots of levels to capture what's going on under the ice shelf cavities. We will have to try it out to see if `Nz=100` meets our needs. 

### Filling, digging, and zapping grid problems
Next, let's run this command to take care of some ocean/ice grid issues:
```
remove_grid_problems(nc_infile, nc_outfile, dz_file, hFacMin=hFacMin, hFacMinDr=hFacMinDr)
```
Specifically, run the following command with explicit paths:
```
remove_grid_problems('topo_outputs/sowise_gyre_bathy_edited.nc','topo_outputs/sowise_gyre_bathy_fixed.nc','topo_outputs/dz_file.txt',hFacMin=0.1, hFacMinDr=20.)
```
The script fills and zaps various grid cells; here is the output:
```
Filling isolated bottom cells
...8799 cells to fill
Digging subglacial lakes
...3949 cells to dig
Digging based on field to west
...1500 cells to dig
Digging based on field to east
...1320 cells to dig
Digging based on field to south
...1090 cells to dig
Digging based on field to north
...510 cells to dig
Zapping thin ice shelf draft
...1 cells to zap
```
### Write to binary
Now that the bathymetry is ready, write out the binary files that include bathymetry and draft. 
```
write_topo_files(nc_file, bathy_file, draft_file)
```
Specifically,
```
write_topo_files('topo_outputs/sowise_gyre_bathy_fixed.nc', 'topo_outputs/bathy_gyre', 'topo_outputs/draft_gyre')
```
These outputs will be stored as part of this repository, and they will be updated as the configuration(s) of SO-WISE are updated. 

## Create initial setup in MITgcm
First, cloned the MITgcm repository into an `MITgcm_sowise_dev` directory on ARCHER2. Ideally, we would like to keep this state estimate machinery working with the latest version of MITgcm for future development purposes. That being said, I'll note the time of initial cloning, which is 10 February 2021. The steps below detail how to replicate the efforts so far. The SO-WISE development repository will sit under an MITgcm repository. The "experiments" diretory is not tracked as part of the MITgcm repository. It will be kept separate. 
```
git clone https://github.com/MITgcm/MITgcm.git
cd MITgcm
mkdir experiments
cd experiments
```
Next, we'll create the repository under "experiments". It will be separate from the MITgcm repository. The next steps include commands necessary to make contributions back to the so-wise-gyre repository on GitHub. The `clone` command creates a copy of the repository locally. The `remote add upstream` command adds the GitHub repository as the upstream for comparison. The `fetch` command ensures that the local copy is up-to-date. Finally, the `checkout` command creates a new branch. 
```
git clone https://github.com/so-wise/so-wise-gyre
git remote add upstream https://github.com/so-wise/so-wise-gyre
git fetch upstream
git checkout -b «YOUR_NEWBRANCH_NAME» 
```
In this example case, we'll call the new branch `add-codemods`. Once the edits, adds, and git commits are all done, we can push the changes back to GitHub:
```
git push -u origin «YOUR_NEWBRANCH_NAME»
```
### Compile and run model

Once you have copied over the ARCHER2 build options file, follow these steps:
```
cd so-wise-gyre/build/

# select the compiling environment
module restore PrgEnv-gnu
module load cray-netcdf-hdf5parallel
module load cray-hdf5-parallel

# set the following environment variables
export MITGCM_ROOTDIR=../../../../MITgcm
export PATH=$MITGCM_ROOTDIR/tools:$PATH
export MITGCM_OPT=$MITGCM_ROOTDIR/tools/build_options/dev_linux_amd64_gnu_archer2

# make the make file
../../../tools/genmake2 -mpi -mods ../code/ -optfile $MITGCM_OPT
make depend
make
```
To run the model, navigate into the run directory, use the `prepare_run` script, and submit to the job scheduler. 

NOTE: In order to get the grid files, I had to turn most of the packages off. Of course, this produces a lot of warnings, but that's totally fine. I produced the grid files and have saved them on BAS HPC in the `so-wise-gyre` directory. I've also run the function `check_final_grid(grid_path)` on the MITgcm grid files, which returned "everything looks good!" So the grid passes the checks in that function. For now, I have _turned off `EXCH2_`. I'm okay with this strategy, although I should ask MM about possible drawbacks here. Presumably we don't _have_ to use EXCH2 for a state estimate these days? Hopefully not. 

## Interpolate initial conditions

As a start, I will use SOSE initial conditions. For now, let's stick with Kaitlin's procedure of initialising from the SOSE climatology. We obviously might want to initialize from something more specific in the future, but this is a good first step. I've run this command:

```
from mitgcm_python.ics_obcs import *
sose_ics(grid_path='../grid/', sose_dir='/data/oceans_input/raw_input_data/SOSE_monthly_climatology/', nc_out='initial_conditions/sose_ics.nc', output_dir='initial_conditions/', constant_t=-1.9, constant_s=34.4, split=180)
```
## Create boundary conditions

```
# Eastern boundary conditions
make_obcs('E', grid_path, input_path, output_dir, source='SOSE', use_seaice=True, nc_out='obcs_e.nc', prec=64)
make_obcs('N', grid_path, input_path, output_dir, source='SOSE', use_seaice=True, nc_out='obcs_n.nc', prec=64)
make_obcs('W', grid_path, input_path, output_dir, source='SOSE', use_seaice=True, nc_out='obcs_w.nc', prec=64)
```


