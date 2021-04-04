function theInvLUT = invertLUT_double( theLUT, theStep)
% usage:                    myInvLUT = invertLUT( myLUT)
% Beschreibung:             Invertiert die Tabellenfunktion theLUT und
%                           liefert die inverse LUT zurück. theLUT muß
%                           monoton steigend verlaufen und nur positive
%                           uint-Funktionswerte sind erlaubt. Ein Offset
%                           wird auf den Ursprungspunkt der Umkehrfunktion
%                           gesetzt, d.h. positiver Offset führt zu
%                           kleinerer Tabelle, ein negativer Offset zu
%                           einer größeren.
% Beispiel: theACRModel.InvGradationCurve = (invertLUT_double( theACRModel.GradationCurve * (2^16-1)) - 1)/(2^16-1);

if ~exist( 'theStep')
	theStep = 1;
end
mySize = size( theLUT);

myInSize = max( size( theLUT));
myOutSize = max( max( theLUT));

if( mySize( 1, 1) == myInSize)
	%In Zeilenvektor transponieren
	theLUT = theLUT';
end

myLUT = [ theLUT; (1:myInSize)];
myLUTStep = myLUT( :, 1:theStep:end);
if( myLUT( 1, end)~=myLUTStep( 1, end))
	myLUTStep( :, end+1) = myLUT( :, end);
end

%Konstante Werte zwischendrin entfernen
myLastValue = myLUTStep( 1, myInSize);
for i=myInSize-1:-1:1
	if myLUTStep( 1, i) >= myLastValue
		%Eintrag löschen
		myLUTStep( :, i) = [];
	else
		myLastValue = myLUTStep( 1, i);
	end
end

%Inverse Tabelle:
myInvLUT = interp1( double( myLUTStep( 1, :)), double( myLUTStep( 2, :)), double( ( round( myLUTStep(1,1)) : round( myOutSize)) ), 'spline');
%myInvLUT = interp1( double( myLUTStep( 1, :)), double( myLUTStep( 2, :)), double( ( round( myLUTStep(1,1)) : round( myOutSize)) ), 'linear');

theInvLUT = myInvLUT;

end %invertLUT()

