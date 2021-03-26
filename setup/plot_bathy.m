%
% Plot the bathymetry 
%

%% Initial setup

% clean up workspace
clear 
close all

%% Read the bathymetry files

% set file location
fid = 'topo_outputs/sowise_gyre_bathy_fixed.nc';

% read in data
lat = ncread(fid, 'lat');
lon = ncread(fid, 'lon');
bathy = ncread(fid, 'bathy');
draft = ncread(fid, 'draft');
omask = ncread(fid, 'omask');
imask = ncread(fid, 'imask');

% colormap
% ----- change to the path of your colormap -----
load('~/Documents/MATLAB/colormaps/cividis.txt')

% make grid
[x,y] = meshgrid(lon,lat);

% NaN for land points
bathy(omask==0) = NaN;
draft(draft==0) = NaN;

%% Make some plots

figpos = [236 70 1092 700];

figure('color','w','position',figpos)
pcolor(x,y,omask')
shading flat
colorbar
title('Ocean mask');

figure('color','w','position',figpos)
pcolor(x,y,imask')
shading flat
colorbar
title('Ice mask');

figure('color','w','position',figpos)
pcolor(x,y,bathy')
shading flat
colorbar
xlabel('Longitude','fontsize',20)
ylabel('Latitude','fontsize',20)
title('Bathymetry [m]','fontsize',22);
colormap(cividis)
set(gca,'fontsize',20)
saveas(gcf,'topo_outputs/bathymetry.png','png')

figure('color','w','position',figpos)
pcolor(x,y,draft')
shading flat
colorbar
xlabel('Longitude','fontsize',20)
ylabel('Latitude','fontsize',20)
title('Ice draft [m]','fontsize',22);
colormap(flipud(cividis))
set(gca,'fontsize',20,'ylim',[-85 -65])
saveas(gcf,'topo_outputs/draft.png','png')