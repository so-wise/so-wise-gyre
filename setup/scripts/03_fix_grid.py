import mitgcm_python
import MITgcmutils
from mitgcm_python.make_domain import *

# remove grid problems
remove_grid_problems('../topo_outputs/sowise_gyre_bathy_edited.nc',
                     '../topo_outputs/sowise_gyre_bathy_fixed.nc',
                     '../topo_outputs/dz_file.txt',hFacMin=0.1, hFacMinDr=20.)

# write to binary 
write_topo_files('../topo_outputs/sowise_gyre_bathy_fixed.nc', 
                 '../topo_outputs/bathy_gyre', 
                 '../topo_outputs/draft_gyre')

