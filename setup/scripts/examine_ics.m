% examine initial conditions

%% Initial setup --

% clean up workspace
clear all
close all

% add paths
addpath ~/matlabfiles/
addpath ~/matlabfiles/m_map/

% names
fname = 'sose_ics.nc';

%% Load data --

Zl = ncread(fname,'Zl');
ZC = ncread(fname,'Z');
XC = ncread(fname,'X');
YC = ncread(fname,'Y');

% 2D x-y grid for plotting
[X,Y] = meshgrid(XC,YC);
X = X'; Y = Y';
% 2D y-z grid for sections
[YY,ZZ] = meshgrid(YC,ZC);
YY = YY'; ZZ = ZZ';

% get 3D data
T = ncread(fname,'THETA');
S = ncread(fname,'SALT');
S(S<20) = NaN;

% get 2D data
SIarea = ncread(fname,'SIarea');
SIheff = ncread(fname,'SIheff');

% zonal mean
Tx = squeeze(nanmean(T,1));
Sx = squeeze(nanmean(S,1));

%% Make plots

% T
figure('color','w','visible','off')
pcolor(X,Y,T(:,:,1))
shading flat
colorbar
title('Potential temperature (surface)')
saveas(gcf,'T_k001.jpg','jpg')

% T
figure('color','w','visible','off')
pcolor(X,Y,T(:,:,10))
shading flat
colorbar
title('Potential temperature (k=10)')
saveas(gcf,'T_k010.jpg','jpg')

% T
figure('color','w','visible','off')
pcolor(X,Y,T(:,:,50))
shading flat
colorbar
title('Potential temperature (k=50)')
saveas(gcf,'T_k050.jpg','jpg')

% S
figure('color','w','visible','off')
pcolor(X,Y,S(:,:,1))
shading flat
colorbar
title('Salinity (surface)')
saveas(gcf,'S_k001.jpg','jpg')

% S
figure('color','w','visible','off')
pcolor(X,Y,S(:,:,10))
shading flat
colorbar
title('Salinity (k=10)')
saveas(gcf,'S_k010.jpg','jpg')

% S
figure('color','w','visible','off')
pcolor(X,Y,S(:,:,50))
shading flat
colorbar
title('Salinity (k=50)')
saveas(gcf,'S_k050.jpg','jpg')

% zonal mean
figure('color','w','visible','off')
pcolor(YY,ZZ,Tx)
shading flat
colorbar
title('Zonal mean temperature (deg C)')
saveas(gcf,'T_zonal.jpg','jpg')

% zonal mean
figure('color','w','visible','off')
pcolor(YY,ZZ,Sx)
shading flat
colorbar
title('Zonal mean salinity (psu)')
saveas(gcf,'S_zonal.jpg','jpg')

% sea ice area
figure('color','w','visible','off')
pcolor(X,Y,SIarea)
shading flat
colorbar
title('Sea ice area')
saveas(gcf,'SIarea.jpg','jpg')

% sea ice thickness
figure('color','w','visible','off')
pcolor(X,Y,SIheff)
shading flat
colorbar
title('Sea ice thickness (m)')
saveas(gcf,'SIheff.jpg','jpg')
