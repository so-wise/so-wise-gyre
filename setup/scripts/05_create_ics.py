import mitgcm_python
import MITgcmutils

from mitgcm_python.ics_obcs import *
sose_ics(grid_path='../../grid/', 
         sose_dir='/data/oceans_input/raw_input_data/SOSE_monthly_climatology/', 
         nc_out='../initial_conditions/sose_ics.nc', 
         output_dir='../initial_conditions/', 
         constant_t=-1.9, constant_s=34.4, split=180)

