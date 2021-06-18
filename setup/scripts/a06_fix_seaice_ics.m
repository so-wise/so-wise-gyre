% 
% fix_seaice_ics.m : fix problem with sea ice ICs
% - this is to address a bug in the mitgcm_python output
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
floc = '../initial_conditions/v0.50_n100/';
fout = '../initial_conditions/v0.51_n100/';
fname = [floc 'sose_ics.nc'];
ploc = floc; 
gloc = '../../grid/';

% load grid
hFacC = rdmds([gloc 'hFacC']);

% read NetCDF files
X=ncread(fname,'X'); Y=ncread(fname,'Y'); Z=ncread(fname,'Z');
SIarea=ncread(fname,'SIarea'); SIheff=ncread(fname,'SIarea');
% create 2D grids for plotting
[x,y]=meshgrid(X,Y); [yy,zz]=meshgrid(Y,Z);
x=x'; y=y'; yy=yy'; zz=zz'; 

% masking
SIarea(hFacC(:,:,1)==0.0)=NaN; SIheff(hFacC(:,:,1)==0.0)=NaN;

% read binary bathymetry and draft files
fid=fopen('../topo_outputs/bathy_gyre','r','ieee-be');
bathy=fread(fid,'float64');
fclose(fid); 
fid=fopen('../topo_outputs/draft_gyre','r','ieee-be');
draft=fread(fid,'float64');
fclose(fid);

% read bathymetry SI files to check
% -- plot manually to confirm
% -- yep, the issue shows up in the binary files too
fid=fopen([floc 'SIarea_BSOSE.ini'],'r','ieee-be');
SIarea_bin=fread(fid,'float64');
SIarea_bin=reshape(SIarea_bin,[length(X) length(Y)]);
fclose(fid);

fid=fopen([floc 'SIheff_BSOSE.ini'],'r','ieee-be');
SIheff_bin=fread(fid,'float64');
SIheff_bin=reshape(SIarea_bin,[length(X) length(Y)]);
fclose(fid);

% reshape
bathy = reshape(bathy,[length(X) length(Y)]);
draft = reshape(draft,[length(X) length(Y)]);
imask = zeros(size(draft));
imask(draft<0.0) = 1.0; 

% apply mask
SIarea(imask==1.0) = 0.0;
SIheff(imask==1.0) = 0.0;

%% Make some plots

% sea ice 
figure('color','w')
pcolor(x,y,SIarea)
shading flat,colorbar
title('Sea ice area (m/m) [fixed]');
if saveFigs
    saveas(gcf,[ploc 'SIarea_fixed.jpg'],'jpg')
end

% sea ice thickness 
figure('color','w')
pcolor(x,y,SIheff)
shading flat,colorbar
title('Sea ice thickness (m) [fixed]');
if saveFigs
    saveas(gcf,[ploc 'SIheff_fixed.jpg'],'jpg')
end

%% Write out corected ICs

fid=fopen([fout 'SIarea_BSOSE.ini'],'w','ieee-be');
A=reshape(SIarea,[length(X)*length(Y) 1]);
fwrite(fid,A);
fclose(fid);

fid=fopen([fout 'SIheff_BSOSE.ini'],'w','ieee-be');
A=reshape(SIarea,[length(X)*length(Y) 1]);
fwrite(fid,A);
fclose(fid);
