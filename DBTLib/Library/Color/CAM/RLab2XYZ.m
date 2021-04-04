function T = RLab2XYZ( Rlab,Tod,Ld,D,md)

% RLAB2XYZ computes the tristimulus values from the lightness, chroma and hue
% in the Rlab space.
%
% SYNTAX
% ----------------------------------------------------------------------------
% XYZ=rlab2xyz(LCH,XYZw,Yw,d,mo)
%
% LCH  = [L C H(º)] of the colours. For N colours, this is a Nx3 matrix.
%
% XYZw = Relative tristimulus values of the reference white.
%
% Yw   = Luminance (cd/m2) of the reference white (1x1).
%
% d and mo are parameters reflecting the observation conditions:
%
% d =  .....1 hard-copy, 
%      .....0 soft-copy, 
%      .....For other situations, give intermediate values between these two.
%
% mo = observation conditions
%      ...1/2.3 for average sourround
%      ...1/2.9 for dim surround, 
%      ...1/3.5 for dark surround.
%
% XYZ = Relative tristimulus values of the samples.
%       For N colours, this is a Nx3 matrix.
%
%
% RELATED FUNCTIONS
% ----------------------------------------------------------------------------
% xyz2rlab.

M=[0.3897 0.6890 -0.0787;-0.2298 1.1834 0.0464; 0 0 1];
R=[1.9569 -1.1882 0.2313;0.3612 0.6388 0;0 0 1];

L=Rlab(:,1);
C=Rlab(:,2);
h=Rlab(:,3);
t=size(L);

% Para calcular los triestimulo en el campo de destino,
% primero calculamos los triestimulos de referencia con el entorno
% de las condiciones de observación finales.

a = C .* cos( h*pi/180);
b = C .* sin( h*pi/180);

myM = inv( [ 0, 100, 0; 430, -430, 0; 0, 170, -170]);
Trf = ([L, a, b] * myM).^(1/md);
% for i=1:t(1)
%  a(i)=C(i)*cos(h(i)*pi/180);
%  b(i)=C(i)*sin(h(i)*pi/180);
% 	Trf(i,2)=(L(i)/100)^(1/md);
% 	Trf(i,1)=((a(i)/430)+Trf(i,2)^md)^(1/md);
% 	Trf(i,3)=(Trf(i,2)^md-(b(i)/170))^(1/md);
% end

% Y ahora la nueva matriz A con estas nuevas condiciones

lmsn=M*Tod';
   l=3*lmsn(1)/sum(lmsn);
	pl=(1+Ld^(1/3)+l)/(1+Ld^(1/3)+1/l);
	al=(pl+D*(1-pl))/lmsn(1);

	m=3*lmsn(2)/sum(lmsn);
	pm=(1+Ld^(1/3)+m)/(1+Ld^(1/3)+1/m);
	am=(pm+D*(1-pm))/lmsn(2);

	s=3*lmsn(3)/sum(lmsn);
	ps=(1+Ld^(1/3)+s)/(1+Ld^(1/3)+1/s);
	as=(ps+D*(1-ps))/lmsn(3);

A=[al 0 0;0 am 0;0 0 as];
T=((inv(R*A*M))*Trf')';
