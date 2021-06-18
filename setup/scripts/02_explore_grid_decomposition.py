#
# explore different grid decomposition options
#

# from mitgcm_python:
#Nx = 700 which has the factors [1, 2, 4, 5, 7, 10, 14, 20, 25, 28, 35, 50, 70, 100, 140, 175, 350, 700]
#Ny = 520 which has the factors [1, 2, 4, 5, 8, 10, 13, 20, 26, 40, 52, 65, 104, 130, 260, 520]

Nx = 700; 
Ny = 520;

# print to screen
print('--------------' + ' Number of grid cells in x and y directions')
print('-----------------' + ' Nx =' + str(Nx) + ', ' + 'Ny = ' + str(Ny))

# size of each tile
sNx = 20;
sNy = 20;

# print to screen
print('--------------' + ' Size of each tile (can be changed)')
print('-----------------' + ' sNx =' + str(sNx) + ', ' + 'sNy = ' + str(sNy))

# number of tiles
nSx = Nx/sNx;
nSy = Ny/sNy;

# print to screen
print('--------------' + ' Number of tiles in x and y directions')
print('-----------------' + ' nSx =' + str(nSx) + ', ' + 'nSy = ' + str(nSy))
