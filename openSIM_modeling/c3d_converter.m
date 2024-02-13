%% Load OpenSim libs
import org.opensim.modeling.*
 
%% Get the path to a C3D file
[filename, path] = uigetfile('*.c3d');
c3dpath = fullfile(path,filename);
 
%% Construct an opensimC3D object with input c3d path
% Constructor takes full path to c3d file and an integer for forceplate
% representation in output forces file (0 = electrical center, 1 = COP).
c3d = osimC3D(c3dpath,useCenterOfPressureAsMomentsPoint);
 
%% Get some stats...
% Get the number of marker trajectories
nTrajectories = c3d.getNumTrajectories();
% Get the marker data rate
rMakers = c3d.getRate_marker();
% Get the number of forces
nForces = c3d.getNumForces();
% Get the force data rate
rForces = c3d.getRate_force();
 
% Get Start and end time
t0 = c3d.getStartTime();
tn = c3d.getEndTime();
 
%% Rotate the data
c3d.rotateData('x',-90)
 
%% Get the c3d in different forms
% Get OpenSim tables
markerTable = c3d.getTable_markers();
forceTable = c3d.getTable_forces();
% Get as Matlab Structures
[markerStruct forceStruct] = c3d.getAsStructs();
 
%% Convert COP (mm to m) and Moments (Nmm to Nm)
if convertLengthUnits
    c3d.convertMillimeters2Meters();
end
 
%% Write the marker and force data to file
% Define output file names
basename = strtok(filename,'.');
markersFilename = strcat(basename,'_markers.trc');
 
switch useCenterOfPressureAsMomentsPoint
    case 0
        forcesFilename = strcat(basename,'_forces_EC.mot');
    case 1
        forcesFilename = strcat(basename,'_forces_COP.mot');
end
 
% Write marker data to trc file.
c3d.writeTRC(markersFilename);
 
% Write force data to mot file.
c3d.writeMOT(forcesFilename);