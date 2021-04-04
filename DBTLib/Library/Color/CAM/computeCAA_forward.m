function theCAA = computeCAA_forward( theRGB_a, theRGB_a_W, theCAParams)

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

myAab = M_Aab * theRGB_a;
myAab( 1, :) = (myAab( 1, :) - 0.305)*N_bb;
myAab_W = M_Aab * theRGB_a_W;
myAab_W( 1, :) = (myAab_W( 1, :) - 0.305)*N_bb;

myJ = 100* (myAab( 1, :) ./ myAab_W( 1, :)).^(c*z);
myQ = 4.0/c* (myJ/100).^0.5 .* ( myAab_W( 1, :)+4.0) * F_L^0.25;

% myIndex = find( myAab( 2, :) == 0);
% myAab( myIndex) = 0.0000000000001;
% myh = atan( myAab( 3, :) ./ myAab( 2, :)) * 180 / pi;
myh = atan2( myAab( 3, :), myAab( 2, :)) * 180 / pi;

myh_ = myh;
myIndex = find( myh<=hi(1));
myh_( myIndex) = myh( myIndex) + 360;

%mySizeY = size( myRGB_a, 2);
myH = myh_;
myH( :) = -1;
for i=4:-1:1
	myIndex = find( myh_ > hi( i));
	if isempty( myIndex)==0
			for j=1:size( myIndex, 2)
				if myH( myIndex( j)) == -1
					myH( myIndex( j)) = Hi( i) + 100 * ((myh_(myIndex( j))-hi( i))/ei( i)) / (((myh_(myIndex( j))-hi( i))/ei( i)) + ((hi( i+1)-myh_(myIndex( j)))/ei( i+1)));
				end
			end
	end
end

e_t = (cos( myh_*pi/180 + 2) + 3.8) /4;
mye = e_t * 50000*N_c*N_cb/13;

myt = (mye .* (myAab( 2, :).^2 + myAab( 3, :).^2).^0.5) ./ ( theRGB_a( 1, :) + theRGB_a( 2, :) + theRGB_a( 3, :)*21/20);
myC = myt.^0.9 .* (myJ/100).^0.5 * (1.64 - 0.29^n)^0.73;
myM = myC*F_L^0.25;
mys = 100 * (myM ./ myQ).^0.5;
		
theCAA.J = myJ;
theCAA.Q = myQ;
theCAA.h = myh_;
theCAA.H = myH;
theCAA.C = myC;
theCAA.M = myM;
theCAA.s = mys;
