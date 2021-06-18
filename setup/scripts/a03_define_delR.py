#
# Define the SO-WISE vertical levels
#

# import modules
import numpy as np
import local_helpers as lh

# write to file?
writeToFile = True

# set parameters
Nz = 100;            # number of depth levels
delR_top = 10.0;     # thickness of uppermost cell
ddz_dk = 1.03;       # rate of change of cell thickness 

# initialize vector
delR_gradual = np.zeros(Nz)

# define vertical levels 
delR_gradual[0] = delR_top;
for n in range(0,delR_gradual.size):
  if n==0:
    delR_gradual[0] = delR_top
  else:
    delR_gradual[n] = ddz_dk*delR_gradual[n-1]; 

# round up
delR_gradual = np.round(delR_gradual,1);

# check total length
total_depth = np.sum(delR_gradual)
print('Total depth = ' + str(total_depth))

# write out to binary file
lh.write_binary(delR_gradual, '../topo_outputs/delR', prec=64, endian='big') 

# write out to text file
np.savetxt('../topo_outputs/dz_file.txt', delR_gradual, fmt="%s")
