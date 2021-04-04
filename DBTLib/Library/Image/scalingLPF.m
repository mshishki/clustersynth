function theLPImage = scalingLPF( theImage, theLPPixelHeight)
%Usage: theTPImage = scalingLP( theImage, theLPPixelHeight);
% Low pass filtering of theImage
% Input: theLPPixelHeight: vertical Size of the scaled image representing
% the relative resolution of the LP image

inSize = bildgroesse( theImage);

kleinImage = verkleinerung( theImage, theLPPixelHeight);
groesse = size( kleinImage);
hoehe = groesse(1);
breite = groesse(2);
a = breite/hoehe;
b = theLPPixelHeight * a;
kleinImage = gleichgross( kleinImage, [theLPPixelHeight,b]);

grossImage = vergroesserung( kleinImage, inSize(1));
outSize2 = bildgroesse( grossImage);
factor = inSize(2)/outSize2(2);
theLPImage = gleichgross( grossImage, [inSize(1), inSize(2)]);
end

function outImage = kleinskalierung( theImage)
outImage = imresize (theImage,0.5,'bilinear');
end

function outImage = grossskalierung( theImage)
outImage = imresize (theImage,1.3,'bilinear');
end

function outSize = bildgroesse ( theImage)
outSize = size( theImage);
end

function outImage = verkleinerung( theImage, myEndValue)
    outImage = kleinskalierung( theImage);
    groesse = size(outImage);
    hoehe = groesse(1);
    if( hoehe > 2 * myEndValue)
        outImage = verkleinerung( outImage, myEndValue);
    end
    
end

function outImage = vergroesserung( theImage, breiteOriginal)
    outImage = grossskalierung( theImage);
    groesseNew = size(outImage);
    breiteNew = groesseNew(2);
    if( breiteNew < breiteOriginal/2)
    outImage = vergroesserung( outImage, breiteOriginal);
    end
    
end

function outImage = gleichgross( theImage, theXYFactors)
    outImage = imresize( theImage, theXYFactors, 'bilinear');
end
