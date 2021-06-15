%% Definte SO-WISE vertical levels
% Set 

%% Initial setup

% clean up workspace
clear 
close all

% write to file? (0 = no, 1 = yes)
writeToFile = 1; 

% set parameters
Nz = 120;            % number of depth levels
delR_top = 5.;     % thickness of uppermost cell
ddz_dk = 1.031;      % rate of change of cell thickness

%% Define vertical levels

% build vertical grid using gradual increase
delR_gradual(1) = delR_top; 
for n=2:Nz
    delR_gradual(n) = ddz_dk*delR_gradual(n-1); %#ok<*SAGROW>
end

delR_gradual = round(delR_gradual,1);

% print total length for check
format bank
disp(delR_gradual')
sum(delR_gradual)
disp('Note: max model grid depth must exceed max bathymetry value')

%% Write delR to plain text file and binary file

if writeToFile 
    % wriet to text file
    [fid,msg] = fopen('dz_file.txt','wt');
    assert(fid>=3,msg)
    fprintf(fid,'%3.1f\n',delR_gradual');
    fclose(fid);

    % write to 64 bit file
    fid = fopen('delR','w','ieee-be');
    fwrite(fid,delR_gradual','float64');
    fclose(fid);
end

%% An alternative from Ariane Verdy

% cell thickness, 100 levels
%DRF = [0 2 2 2 2 2 2.2 2.4 2.6 2.8 3.1 3.3 3.6 ...
% 4 4 4.5 5 5 5 5 5 5 5.5 5.5 5.5 5.5 5.5 ...
% 6 7 8 9 10 10 10 10 10 10 10 ...
% 11 12 13 14 15 16 17 18 19 20 ...
% 22 23 25 25 25 25 25 25 25 25 ...
% 27 28 30 30 30 35 35 40 45 50 50 ...
% 59 70 80 92 100 100 100 100 100 100 100 ...
% 110 120 130 140 150 160 170 180 ...
% 190 200 200 200 200 200 200 220 230 ...
% 250 250 250 250];

