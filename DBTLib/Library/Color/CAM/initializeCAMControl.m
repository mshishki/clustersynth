function theCAMControl = initializeCAMControl( theIllumination, theXYZ_W, theL_A, theLrel_surround, theFIllDiscount, theY_b)

theCAMControl.XYZ_W = theXYZ_W;

myM_CAT02 = [ 0.7328, 0.4296, -0.1624; -0.7036, 1.6975, 0.0061; 0.0030, 0.0136, 0.9834];
myM_HPE = [ 0.38971, 0.68898, -0.07868; -0.22981, 1.18340, 0.04641; 0.0000, 0.0000, 1.0000];
 
myY_W = theXYZ_W( 2);

if exist( 'theY_b')==0
	%Background soll 20% des Bildweiﬂ entsprechen:
	myY_b = myY_W * 0.2;
else
	myY_b = theY_b;
end

switch theLrel_surround
	case 'average'
		c = 0.69;
		N_c = 1;
		F = 1;
	case 'dim'
		c = 0.59;
		N_c = 0.9;
		F = 0.9;
	case 'dark'
		c = 0.525;
		N_c = 0.8;
		F = 0.8;
end

if theFIllDiscount == 1
	D = 1;
else
	D = F*( 1 - exp( -( theL_A+42)/92)/3.6);
	D = min( 1, max( 0, D));
end

myRGB_W = myM_CAT02 * theXYZ_W;
D_RGB = myRGB_W.^(-1) *myY_W*D + 1-D;

k = 1/( 5*theL_A + 1);
F_L = 0.2 * k^4 * 5 * theL_A + 0.1 * (1 - k^4)^2 * (5*theL_A)^(1/3);
n = myY_b / myY_W;
N_bb = 0.725 * n^(-0.2);
N_cb = N_bb;
z = 1.48 + n^0.5;

myM_Aab = [ 2, 1, 1/20; 1, -12/11, 1/11; 1/9, 1/9, -2/9];

hi = [ 20.14, 90, 164.25, 237.53, 380.14];
ei = [ 0.8, 0.7, 1, 1.2, 0.8];
Hi = [ 0, 100, 200, 300, 400];


theCAMControl.RGBParams.M_CAT02 = myM_CAT02;
theCAMControl.RGBParams.M_HPE = myM_HPE;
theCAMControl.RGBParams.D_RGB = D_RGB;
theCAMControl.RGBParams.F_L = F_L;

theCAMControl.CAParams.c = c;
theCAMControl.CAParams.N_c = N_c;
theCAMControl.CAParams.F_L = F_L;
theCAMControl.CAParams.n = n;
theCAMControl.CAParams.N_bb = N_bb;
theCAMControl.CAParams.N_cb = N_cb;
theCAMControl.CAParams.z = z;
theCAMControl.CAParams.M_Aab = myM_Aab;
theCAMControl.CAParams.hi = hi;
theCAMControl.CAParams.ei = ei;
theCAMControl.CAParams.Hi = Hi;
