% 
% plot_ics.m : plot initial conditions
%

%% Initial setup

% clean up workspace
clear all
close all

% addpaths
addpath ~/matlabfiles/
addpath ~/matlabfiles/m_map/

% save figures?
saveFigs = 1;

%% Load data

% set paths
floc = '../initial_conditions/';
fname = [floc 'sose_ics.nc'];
ploc = floc; 
gloc = '../../grid/';

% load grid
hFacC = rdmds([gloc 'hFacC']);

% read NetCDF files
X=ncread(fname,'X'); Y=ncread(fname,'Y'); Z=ncread(fname,'Z');
THETA=ncread(fname,'THETA'); SALT=ncread(fname,'SALT');
SIarea=ncread(fname,'SIarea'); SIheff=ncread(fname,'SIarea');
% create 2D grids for plotting
[x,y]=meshgrid(X,Y); [yy,zz]=meshgrid(Y,Z);
x=x'; y=y'; yy=yy'; zz=zz'; 

% masking
THETA(hFacC==0.0)=NaN; SALT(hFacC==0.0)=NaN; 
SIarea(hFacC(:,:,1)==0.0)=NaN; SIheff(hFacC(:,:,1)==0.0)=NaN;

% read binary bathymetry and draft files
fid=fopen('../topo_outputs/bathy_gyre','r','ieee-be');
bathy=fread(fid,'float64');
fclose(fid); 
fid=fopen('../topo_outputs/draft_gyre','r','ieee-be');
draft=fread(fid,'float64');
fclose(fid);

% reshape
bathy = reshape(bathy,[length(X) length(Y)]);
draft = reshape(draft,[length(X) length(Y)]);
imask = zeros(size(draft));
imask(draft<0.0) = 1.0; 

%% Make some initial plots

% theta SST
figure('color','w')
pcolor(x,y,THETA(:,:,1))
shading flat,colorbar
title('SST initial conditions (degC)')
if saveFigs
   saveas(gcf,[ploc 'sst_ics.jpg'],'jpg');
end 

% theta zonal mean
figure('color','w')
pcolor(yy,zz,squeeze(nanmean(THETA)))
shading flat,colorbar
title('THETA zonal mean (degC)')
if saveFigs
    saveas(gcf,[ploc 'theta_zonal.jpg'],'jpg');
end

% salt 
figure('color','w')
pcolor(x,y,SALT(:,:,1))
shading flat,colorbar
title('SSS initial conditions (psu)')
if saveFigs
   saveas(gcf,[ploc 'sss_ics.jpg'],'jpg');
end 

% salt zonal mean
figure('color','w')
pcolor(yy,zz,squeeze(nanmean(SALT)))
shading flat,colorbar
title('SALT zonal mean (psu)')
if saveFigs
    saveas(gcf,[ploc 'salt_zonal.jpg'],'jpg');
end

% sea ice 
figure('color','w')
pcolor(x,y,SIarea)
shading flat,colorbar
title('Sea ice area (m/m)');
if saveFigs
    saveas(gcf,[ploc 'SIarea.jpg'],'jpg')
end

% sea ice thickness 
figure('color','w')
pcolor(x,y,SIheff)
shading flat,colorbar
title('Sea ice thickness (m)');
if saveFigs
    saveas(gcf,[ploc 'SIheff.jpg'],'jpg')
end
