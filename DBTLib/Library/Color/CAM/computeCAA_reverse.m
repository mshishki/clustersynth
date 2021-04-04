function theRGB_a = computeCAA_reverse( theCAA, theRGB_a_W, theCAParams)

c = theCAParams.c;
N_c = theCAParams.N_c;
F_L = theCAParams.F_L;
n = theCAParams.n;
N_bb = theCAParams.N_bb;
N_cb = theCAParams.N_cb;
z = theCAParams.z;
M_Aab = theCAParams.M_Aab;
hi = theCAParams.hi;
ei = theCAParams.ei;
Hi = theCAParams.Hi;

% theCAA.J = myJ;
% theCAA.Q = myQ;
% theCAA.h = myh_;
% theCAA.H = myH;
% theCAA.C = myC;
% theCAA.M = myM;
% theCAA.s = mys;

myJ = theCAA.J;
myC = theCAA.C;
myh = theCAA.h;

myA_W=( 2*theRGB_a_W( 1) + theRGB_a_W( 2) + theRGB_a_W( 3)/20 - 0.305) * N_bb; 
myA = myA_W * ( myJ/100).^(1/(c*z));
   
myt=(myC ./ ((myJ/100).^0.5 * ( 1.64 - 0.29^n)^0.73)).^(1/0.9);
myet=(cos( myh*pi/180+2) + 3.8) / 4;
myp1 = ( 50000/13)*N_c*N_cb .* myet ./ myt;
myp2 = myA / N_bb + 0.305;
myp3 = 21/20;

myCos_h = cos( myh*pi/180);
mySin_h = sin( myh*pi/180);
myp4 = myp1./mySin_h;
myp5 = myp1./myCos_h;

%Selection of |sin(h)| > |cos(h)|
myIndexSinCos = abs( mySin_h) >= abs( myCos_h);
myIndexCosSin = abs( mySin_h) < abs( myCos_h);

mya = myJ;
mya( :, :) = 0;
myb = mya;

myb( myIndexSinCos) = (myp2( myIndexSinCos) * (2+myp3) * (460/1403)) ./ ...
    ( myp4( myIndexSinCos) + (2+myp3)*(220/1403) * ...
    (myCos_h(myIndexSinCos)./mySin_h(myIndexSinCos)) - (27/1403) + myp3*(6300/1403));
mya( myIndexSinCos) = myb( myIndexSinCos).* myCos_h( myIndexSinCos) ./ mySin_h( myIndexSinCos);

mya(myIndexCosSin) = (myp2( myIndexCosSin) * (2+myp3) * (460/1403)) ./ ...
    ( myp5( myIndexCosSin) + (2+myp3)*(220/1403) - ...
    ((27/1403)-myp3*(6300/1403)) * (mySin_h(myIndexCosSin)./myCos_h(myIndexCosSin)));
myb( myIndexCosSin) = mya( myIndexCosSin) .* mySin_h( myIndexCosSin) ./ myCos_h( myIndexCosSin);

myAab = [ myp2; mya; myb];
theRGB_a = inv( M_Aab) * myAab;

		
