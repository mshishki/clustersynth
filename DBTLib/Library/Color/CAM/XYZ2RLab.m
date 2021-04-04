function Rlab = XYZ2RLab( T, Tos, Ls, D, mo)

% XYZ2RLAB computes the coordenates L,a,b in RLab space, the chroma C and the
% hue angles (in degrees) H.
%
% SYNTAX
% ----------------------------------------------------------------------------
% LABCH=xyz2rlab(XYZS,XYZW,YW,d,mo)
%
% XYZS = Relative tristimulus values of the samples.
%        For N colours, this is a Nx3 matrix.
%
% XYZW = Relative tristimulus values of the reference white.
%
% YW   = Luminance (cd/m2) of the reference white (1x1).
%
% d and mo are parameters reflecting the observation conditions:
%
% d=.....1 hard-copy, 
%   .....0 soft-copy, 
%   .....For other situations, give intermediate values between these two.
% mo = observation conditions
%     ...1/2.3 for average sourround
%     ...1/2.9 for dim surround, 
%     ...1/3.5 for dark surround.
%
% LABCH = [L a b C H(º)]. For N colours, this is a Nx3 matrix.
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% rlab2xyz.

M=[0.3897 0.6890 -0.0787;-0.2298 1.1834 0.0464; 0 0 1];
lmsn=M*Tos';
t=size(T);

	l=3*lmsn(1)/sum(lmsn);
	pl=(1+Ls^(1/3)+l)/(1+Ls^(1/3)+1/l);
	al=(pl+D*(1-pl))/lmsn(1);

	m=3*lmsn(2)/sum(lmsn);
	pm=(1+Ls^(1/3)+m)/(1+Ls^(1/3)+1/m);
	am=(pm+D*(1-pm))/lmsn(2);

	s=3*lmsn(3)/sum(lmsn);
	ps=(1+Ls^(1/3)+s)/(1+Ls^(1/3)+1/s);
	as=(ps+D*(1-ps))/lmsn(3);


% Para obtener los valores triestimulo de referencia, la terna
% de a define una matriz A, y a partir de ella se calculan los
% triestimulo bajo las condiciones de referencia

A=[al 0 0;0 am 0;0 0 as];
R=[1.9569 -1.1882 0.2313;0.3612 0.6388 0;0 0 1];
Tr=(R*A*M*T')';

% Calculo de las coordenadas
myM = [ 0, 100, 0; 430, -430, 0; 0, 170, -170];
Lab = Tr.^mo * myM;
C = (Lab( :, 2).^2+Lab( :, 3).^2).^0.5;
h = atan2( Lab( :, 3), Lab( :, 2))*180/pi;
% for i=1:t(1)
% 	L(i)=100*Tr(i,2)^mo;
% 	a(i)=430*(Tr(i,1)^mo-Tr(i,2)^mo);
% 	b(i)=170*(Tr(i,2)^mo-Tr(i,3)^mo);
% 	C(i)=sqrt(a(i)^2+b(i)^2);
% 	h(i)=atan2(b(i),a(i))*180/pi;
% end

Rlab=[Lab,C,h];

