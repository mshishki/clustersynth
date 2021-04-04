function theDisplayModel = getDisplayModel( theXYZ_Black, theXYZ_White, theRGB2XYZMatrix, theLutR, theLutG, theLutB)

theDisplayModel.Forward.BlackPoint = theXYZ_Black;
theDisplayModel.Forward.WhitePoint = theXYZ_White;
theDisplayModel.Forward.RGB2XYZMatrix = theRGB2XYZMatrix;
theDisplayModel.Forward.Lut.R = forcemonotone( theLutR);
theDisplayModel.Forward.Lut.G = forcemonotone( theLutG);
theDisplayModel.Forward.Lut.B = forcemonotone( theLutB);

theDisplayModel.Backward = invertDisplayModel( theDisplayModel.Forward);

[ theDisplayModel.Forward.Lut.R, ...
	theDisplayModel.Forward.Lut.G, ...
	theDisplayModel.Forward.Lut.B] = extend( theDisplayModel.Forward.Lut.R, ...
												theDisplayModel.Forward.Lut.G, ...
												theDisplayModel.Forward.Lut.B);
				

function theMonotoneLut = forcemonotone( the1DLut)
for i=1:(numel( the1DLut)-1)
	%Abschneiden, falls nicht streng monoton oder Größer 1
	if ( the1DLut( i+1) <= the1DLut( i)) || ( the1DLut( i+1) > 1.0)
		theMonotoneLut = the1DLut( 1:i);
		return;
	end
end

theMonotoneLut = the1DLut;

	
function [ theExtLutR, theExtLutG, theExtLutB] = extend( theLutR, theLutG, theLutB)
%theLutX auf gleiche Längen bringen
myLutSize = max( [ numel( theLutR), numel( theLutG), numel( theLutB)]);

%R-Kanal
for i=( numel( theLutR)+1):myLutSize
	theLutR( i) = theLutR( i-1);
end

%G-Kanal
for i=( numel( theLutG)+1):myLutSize
	theLutG( i) = theLutG( i-1);
end

%B-Kanal
for i=( numel( theLutB)+1):myLutSize
	theLutB( i) = theLutB( i-1);
end

%Datenübernahme
theExtLutR = theLutR;
theExtLutG = theLutG;
theExtLutB = theLutB;
