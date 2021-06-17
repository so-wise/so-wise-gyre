# import modules
import mitgcm_python
import MITgcmutils
from mitgcm_python.make_domain import *

# create lon and lat
lon, lat = latlon_points(-85, 90, -84.2, -35, 0.25, '../topo_outputs/delY')

# interpolate bathymetry
topo_dir='../topo_inputs'
nc_outfile='../topo_outputs/sowise_gyre_bathy.nc'
interp_bedmap2(lon, lat, topo_dir, nc_outfile)

# edit land mask
edit_mask('../topo_outputs/sowise_gyre_bathy.nc', '../topo_outputs/sowise_gyre_bathy_edited.nc', key='SO-WISE-GYRE')

