function theXYZfrom2XYZto = getBradfordCAT( theXYZ_W_from, theXYZ_W_to)
%Use the linearized Bradford adaptation matrix.

Mb = [	0.8951,  0.2664, -0.1614; ...
		-0.7502,  1.7135,  0.0367; ...
		0.0389, -0.0685,  1.0296];

w1 = Mb * theXYZ_W_from( :);
w2 = Mb * theXYZ_W_to( :);

%Negative white coordinates are kind of meaningless.
w1 = max( w1, 0);
w2 = max( w2, 0);

%Limit scaling to something reasonable.
a = w2 ./ w1;
a = min( a, 10);
a = max( a, 0.1);

A = diag( a);

theXYZfrom2XYZto = inv( Mb) * A * Mb;
	

% XYZ Scaling  1.0       0.0       0.0      0.0       1.0       0.0      0.0       0.0       1.0     
% Bradford  0.8951   -0.7502    0.0389   0.2664    1.7135   -0.0685  -0.1614    0.0367    1.0296  
% Von Kries  0.40024  -0.22630   0.00000  0.70760   1.16532   0.00000 -0.08081   0.04570   0.91822  
