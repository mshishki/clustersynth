function theInvLUT = invertLUT( theLUT)
% usage:                    myInvLUT = invertLUT( myLUT)
% Beschreibung:             Invertiert die Tabellenfunktion theLUT und
%                           liefert die inverse LUT zurück. theLUT muß
%                           monoton steigend verlaufen und nur positive
%                           uint-Funktionswerte sind erlaubt.

mySize = size( theLUT);

myInSize = uint32( max( size( theLUT)));
myOutSize = uint32( max( max( theLUT)));

if( mySize( 1, 1) == myInSize)
	%In Zeilenvektor transponieren
	theLUT = theLUT';
end

myLUT = [ theLUT; (1:myInSize)];

%Löschen und umorganisieren
myActX = myInSize;
myActY = theLUT( 1, myActX);
for i=myInSize-1:-1:1
    if ( theLUT( 1, i) == myActY)
        myLUT( :, i) = [];
        myLUT( 2, i) = (i + myActX)/2;
    else
        myActY = theLUT( 1, i);
        myActX = i;
    end %if
end %for

%Inverse Tabelle:
myInvLUT = [ repmat( double( myLUT( 2, 1)), 1,  double( myLUT( 1, 1))), interp1( double( myLUT( 1, :)), double( myLUT( 2, :)), double( ( myLUT(1,1) : myOutSize) ), 'linear')];

% if( mySize( 1, 1) == myInSize)
% 	%Dimensionen beachten
% 	theInvLUT = uint16( myInvLUT');
% else
    theInvLUT = uint16( myInvLUT);
% end %if

end %invertLUT()

