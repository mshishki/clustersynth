function theOutImage = applyRGBLut( theInImage, theRGBLut)

theOutImage (:,:,1) = theRGBLut.r( theInImage( :, :, 1)+1);
theOutImage (:,:,2) = theRGBLut.g( theInImage( :, :, 2)+1);
theOutImage (:,:,3) = theRGBLut.b( theInImage( :, :, 3)+1);

end %applyRGBLut

