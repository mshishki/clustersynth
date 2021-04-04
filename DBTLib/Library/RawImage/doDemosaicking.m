function theOutputImage = doDemosaicking( theSensorOutputImage, theDemosAlgo, theCFAMode)

%Falls nicht rggb CFA und nicht Matlab-Demosaicking -> nach rggb
%konvertieren
if exist( 'theCFAMode') && ~strcmp( theCFAMode, 'rggb') && ~strcmp( theDemosAlgo, 'Matlab')
	theSensorOutputImage = convert2rggb( theSensorOutputImage);
elseif ~exist( 'theCFAMode')
	theCFAMode = 'rggb';
end

switch theDemosAlgo
    case 'Fast'
        theOutputImage = doFastDemosaic( theSensorOutputImage);
    case 'fast'
        theOutputImage = doFastDemosaic( theSensorOutputImage);
    case 'Bilinear'
        theOutputImage = doBilinearDemosaic( theSensorOutputImage);
    case 'TI' %TI US6975354 modifiziert 
        theOutputImage = doTIDemosaic( theSensorOutputImage);
    case 'POCS' %projections onto convex sets 
		theRGBImage = doBilinearDemosaic( theSensorOutputImage);
        theOutputImage = doPOCSDemosaic( theRGBImage);
	case 'Matlab'
		theOutputImage = demosaic( im2uint16( theSensorOutputImage), theCFAMode);
	otherwise %nothing to do
        theOutputImage = theSensorOutputImage;
end

end %doDemosaicking

function theRawWBImageRGGB = convert2rggb( theRawWBImage, theCFAPattern)

switch theCFAPattern
	case 'grbg'
		theRawWBImageRGGB = theRawWBImage( 1:end, 2:end-1);
	case 'rggb'
		theRawWBImageRGGB = theRawWBImage;
	case 'gbrg'
		theRawWBImageRGGB = theRawWBImage( 2:end-1, 1:end);
	case 'bggr'
		theRawWBImageRGGB = theRawWBImage( 2:end-1, 2:end-1);
	otherwise
		theRawWBImageRGGB = theRawWBImage;
end

end %convert2rggb


% function theOutputImage = doBilinearDemosaic( theSensorOutputImage)
% %%%%% Get the color channels
% R = double( theSensorOutputImage(:,:,1)); %figure; imshow(R);
% G = double( theSensorOutputImage(:,:,2)); %figure; imshow(G);
% B = double( theSensorOutputImage(:,:,3)); %figure; imshow(B);
% 
% %%%%% Size of the image
% [height,width] = size(G);
% 
% %%%%% Downsample according to the BAYER pattern
% %
% % R G
% % G B
% %
% Rd = R( 1:2:end, 1:2:end);
% Bd = B( 2:2:end, 2:2:end);
% 
% %%%%% COMMENTS
% % The implementation can be easily modified to have G sample at the upper left corner. (Does not affect much...)
% 
% % G channel is sampled and interpolated below 
% % G channel is sampled and interpolated with the ``edge-sensitive interpolator''
% Gdu = G;
% G_bilinear = G;
% for j=4:2:height-4, % Interpolate G over B samples (excluding borders)
%    for i=4:2:width-4,
%       
%       %Gdu(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i)+Gdu(j,i-1)+Gdu(j+1,i+1) )/4;
%       G_bilinear(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i)+Gdu(j,i-1)+Gdu(j,i+1) )/4;
% 
%       deltaH = abs( Gdu(j,i-1)-Gdu(j,i+1) ) + abs( 2*B(j,i)-B(j,i-2)-B(j,i+2) );
% 		deltaV = abs( Gdu(j-1,i)-Gdu(j+1,i) ) + abs( 2*B(j,i)-B(j-2,i)-B(j+2,i) );
%       if deltaV>deltaH,
%          Gdu(j,i) = ( Gdu(j,i-1)+Gdu(j,i+1) )/2 + ( 2*B(j,i)-B(j,i-2)-B(j,i+2) )/4;
%       elseif deltaH>deltaV,
%          Gdu(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i) )/2 + ( 2*B(j,i)-B(j-2,i)-B(j+2,i) )/4;
%       else
%          Gdu(j,i) = (Gdu(j-1,i-1)+Gdu(j+1,i+1)+Gdu(j-1,i+1)+Gdu(j+1,i-1))/4 + ( 2*B(j,i)-B(j,i-2)-B(j,i+2) + 2*B(j,i)-B(j-2,i)-B(j+2,i))/8;
%       end;
%       
%    end;
% end;
% for j=3:2:height-3, % Interpolate G over R samples (excluding borders)
%    for i=3:2:width-3,
%       
%       %Gdu(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i)+Gdu(j,i-1)+Gdu(j+1,i+1) )/4;
%       G_bilinear(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i)+Gdu(j,i-1)+Gdu(j+1,i+1) )/4;
%       
%       deltaH = abs( Gdu(j,i-1)-Gdu(j,i+1) ) + abs( 2*R(j,i)-R(j,i-2)-R(j,i+2) );
% 		deltaV = abs( Gdu(j-1,i)-Gdu(j+1,i) ) + abs( 2*R(j,i)-R(j-2,i)-R(j+2,i) );
%       if deltaV>deltaH,
%          Gdu(j,i) = ( Gdu(j,i-1)+Gdu(j,i+1) )/2 + ( 2*R(j,i)-R(j,i-2)-R(j,i+2) )/4;
%       elseif deltaH>deltaV,
%          Gdu(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i) )/2 + ( 2*R(j,i)-R(j-2,i)-R(j+2,i) )/4;
%       else
%          Gdu(j,i) = (Gdu(j-1,i-1)+Gdu(j+1,i+1)+Gdu(j-1,i+1)+Gdu(j+1,i-1))/4 + ( 2*R(j,i)-R(j,i-2)-R(j,i+2) + 2*R(j,i)-R(j-2,i)-R(j+2,i))/8;
%       end;
% 
%    end;
% end;
% 
% GduTemp = Gdu;
% 
% %%%%% Bilinear interpolation
% Rd2 = interp2(Rd,'linear');
% Bd2 = interp2(Bd,'linear');
% 
% %%%%% Make sure that they have the same sizes...
% Rdu = R; Rdu(1:height-1, 1:width-1) = Rd2; %figure; imshow(uint8(Rdu)); 
% Bdu = B; Bdu(2:height, 2:width) = Bd2; %figure; imshow(uint8(Bdu));
% 
% %%%%% Output bilinearly interpolated image
% out_bilinear(:,:,1)=Rdu;
% out_bilinear(:,:,2)=G_bilinear;
% out_bilinear(:,:,3)=Bdu;
% theOutputImage = out_bilinear;
% 
% 
% 
% end %doBilinearDemoaic
% 
% 
% 
