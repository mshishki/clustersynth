function [ theCamRGB2PpRGBMatrix, thePpRGB2sRGBMatrix] = getACRMatrices( theXYZ2Cam, theASN)

PpRGB2PCS = [ 0.7977, 0.1352, 0.0313;...%Quelle: dng-SDK, dng_color_space.cpp
				  				 	 0.2880, 0.7119, 0.0001;...
				  				 	 0.0000, 0.0000, 0.8249];
sRGB2PCS = [ 0.4360747, 0.3850649, 0.1430804; ...
									0.2225045, 0.7168786, 0.0606169; ...
									0.0139322  0.0971045  0.7141733];


myCam2XYZ = inv( theXYZ2Cam);
myCamWB2XYZ = myCam2XYZ .* transpose( theASN(:)*ones(1, 3));
myXYZWhite = myCamWB2XYZ * [ 100; 100; 100];
myXYZ2PCS = getBradfordCAT( myXYZWhite, getXYZD50());


%1. Matrix
%Grauachse erhalten:
theCamRGB2PpRGBMatrix = force2neutral( inv( PpRGB2PCS) * myXYZ2PCS * myCamWB2XYZ);

%2. Matrix
if nargout > 1
	thePpRGB2sRGBMatrix = inv( sRGB2PCS) * PpRGB2PCS;
end

