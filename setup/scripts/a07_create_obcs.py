# add one directory above to path
import sys
sys.path.append("..")

# import modules
import mitgcm_python
import MITgcmutils
from mitgcm_python.ics_obcs import *

# set locations
grid_path = '/data/expose/so-wise/so-wise-gyre/grid/'
input_path = '/data/oceans_input/raw_input_data/SOSE_monthly_climatology/'
output_dir = '/data/expose/so-wise/so-wise-gyre/setup/boundary_conditions/'

# Eastern boundary conditions
make_obcs('E', grid_path, input_path, output_dir, source='SOSE', use_seaice=True, nc_out=output_dir+'obcs_e.nc', prec=64)
make_obcs('N', grid_path, input_path, output_dir, source='SOSE', use_seaice=True, nc_out=output_dir+'obcs_n.nc', prec=64)
make_obcs('W', grid_path, input_path, output_dir, source='SOSE', use_seaice=True, nc_out=output_dir+'obcs_w.nc', prec=64)


