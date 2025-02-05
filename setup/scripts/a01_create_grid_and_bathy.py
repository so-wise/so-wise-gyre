# add one directory above to path
import sys
sys.path.append("..")

# import modules
import mitgcm_python
import MITgcmutils
from mitgcm_python.make_domain import *

# create lon and lat
#lon, lat = latlon_points(-85, 90, -84.2, -30, 0.25, '../topo_outputs/delY')  # first try (too far north)
lon, lat = latlon_points(-85.0, 90.0, -84.2, -38.0, 0.25, '../topo_outputs/delY')

# ask user if they want to proceed
goAhead = str(raw_input("Proceed with interpolation and mask editing? [y/n]")).lower().strip()

if(goAhead=='y'):

  # interpolate bathymetry
  topo_dir='../topo_inputs'
  nc_outfile='../topo_outputs/sowise_gyre_bathy.nc'
  interp_bedmap2(lon, lat, topo_dir, nc_outfile)

  # edit land mask
  edit_mask('../topo_outputs/sowise_gyre_bathy.nc', '../topo_outputs/sowise_gyre_bathy_edited.nc', key='SO-WISE-GYRE')

else:

  print("Bathymetry not generated. Go back and edit lat/lon and try again.")

print("End")
