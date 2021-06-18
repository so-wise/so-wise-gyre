#
# explore different grid decomposition options
#

# from mitgcm_python:
#Nx = 700 which has the factors [1, 2, 4, 5, 7, 10, 14, 20, 25, 28, 35, 50, 70, 100, 140, 175, 350, 700]
#Ny = 520 which has the factors [1, 2, 4, 5, 8, 10, 13, 20, 26, 40, 52, 65, 104, 130, 260, 520]

Nx = 700 
Ny = 520

# print to screen
print('---')
print('--------------' + ' Number of grid cells in x and y directions')
print('-----------------' + ' Nx = ' + str(Nx) + ', ' + 'Ny = ' + str(Ny))

# number of grid cells in each tile
#sNx = 20
#sNy = 20
sNx = 50
sNy = 65

# print to screen
print('--------------' + ' Size of each tile (can be changed)')
print('-----------------' + ' sNx = ' + str(sNx) + ', ' + 'sNy = ' + str(sNy))

# number of processes to use in x and y (assumes one process per tile)
nPx = Nx/sNx
nPy = Ny/sNy

# print to screen
print('--------------' + ' Number of processes in x and y (assumes one process per tile)')
print('-----------------' + ' nPx = ' + str(nPx) + ', ' + 'nPy = ' + str(nPy))

# how many processes will this require?
print('----- This will require ' + str(nPx*nPy) + ' processes in MITgcm')
print('---')
