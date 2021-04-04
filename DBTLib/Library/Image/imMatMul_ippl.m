function theOutImage = imMatMul_ippl( theInImage, theInMatrix)
%Usage: theOutImage = imMatMul_ippl( theInImage, theInMatrix);
%Description: computes OutPixVec = theInMatrix * InPixVec;

R = theInImage( :, :, 1);
G = theInImage( :, :, 2);
B = theInImage( :, :, 3);

ROut = imlincomb( theInMatrix( 1, 1), R, theInMatrix( 1, 2), G, theInMatrix( 1, 3), B);
GOut = imlincomb( theInMatrix( 2, 1), R, theInMatrix( 2, 2), G, theInMatrix( 2, 3), B);
BOut = imlincomb( theInMatrix( 3, 1), R, theInMatrix( 3, 2), G, theInMatrix( 3, 3), B);

theOutImage( :, :, 1) = ROut;
theOutImage( :, :, 2) = GOut;
theOutImage( :, :, 3) = BOut;
