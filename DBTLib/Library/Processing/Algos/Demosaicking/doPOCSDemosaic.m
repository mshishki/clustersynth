%
% DEMOPOCS -> Demosaicing Using Alternating Projections
%		DEMOPOCS simulates the projections onto convex sets (POCS) based demosaicing algorithm. 
%		It takes a full-color image, samples it according to BAYER pattern, and applies the POCS algorithm
%
%		[out_pocs,out_bilinear] = demopocs(x) 
%		x 					-> Input image. (It has full R,G,B channels.)
%		out_pocs			-> Interpolated image using the POCS algorithm
%		out_bilinear	-> Interpolated using bilinear interpolation. (For comparison purposes.)
%

% For details, please refer to the paper:
%  	Color plane interpolation using alternating projections 
%		Gunturk, B.K.; Altunbasak, Y.; Mersereau, R.M. 
%		Image Processing, IEEE Transactions on , Volume: 11 Issue: 9 , Sept 2002 
%		Page(s): 997 -1013

% Bahadir K. Gunturk
% School of Electrical and Computer Engineering
% Georgia Institute of Technology
% Email: bahadir@ece.gatech.edu
% URL  : http://users.ece.gatech.edu/bahadir


function out_pocs = doPOCSDemosaic(x)

%%%%% Number of iterations
iterN = 5;

%%%%% Get the color channels
R = double(x(:,:,1)); %figure; imshow(R);
G = double(x(:,:,2)); %figure; imshow(G);
B = double(x(:,:,3)); %figure; imshow(B);

%%%%% Size of the image
[height,width] = size(G);

%%%%% Downsample according to the BAYER pattern
%
% R G
% G B
%
Rd = dyaddown(R,'m',1);
Bd = dyaddown(B,'m',2);

%%%%% COMMENTS
% The implementation can be easily modified to have G sample at the upper left corner. (Does not affect much...)

% G channel is sampled and interpolated below 
% G channel is sampled and interpolated with the ``edge-sensitive interpolator''
Gdu = G;
G_bilinear = G;
for j=4:2:height-4, % Interpolate G over B samples (excluding borders)
   for i=4:2:width-4,
      
      %Gdu(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i)+Gdu(j,i-1)+Gdu(j+1,i+1) )/4;
      G_bilinear(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i)+Gdu(j,i-1)+Gdu(j,i+1) )/4;

      deltaH = abs( Gdu(j,i-1)-Gdu(j,i+1) ) + abs( 2*B(j,i)-B(j,i-2)-B(j,i+2) );
		deltaV = abs( Gdu(j-1,i)-Gdu(j+1,i) ) + abs( 2*B(j,i)-B(j-2,i)-B(j+2,i) );
      if deltaV>deltaH,
         Gdu(j,i) = ( Gdu(j,i-1)+Gdu(j,i+1) )/2 + ( 2*B(j,i)-B(j,i-2)-B(j,i+2) )/4;
      elseif deltaH>deltaV,
         Gdu(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i) )/2 + ( 2*B(j,i)-B(j-2,i)-B(j+2,i) )/4;
      else
         Gdu(j,i) = (Gdu(j-1,i-1)+Gdu(j+1,i+1)+Gdu(j-1,i+1)+Gdu(j+1,i-1))/4 + ( 2*B(j,i)-B(j,i-2)-B(j,i+2) + 2*B(j,i)-B(j-2,i)-B(j+2,i))/8;
      end;
      
   end;
end;
for j=3:2:height-3, % Interpolate G over R samples (excluding borders)
   for i=3:2:width-3,
      
      %Gdu(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i)+Gdu(j,i-1)+Gdu(j+1,i+1) )/4;
      G_bilinear(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i)+Gdu(j,i-1)+Gdu(j+1,i+1) )/4;
      
      deltaH = abs( Gdu(j,i-1)-Gdu(j,i+1) ) + abs( 2*R(j,i)-R(j,i-2)-R(j,i+2) );
		deltaV = abs( Gdu(j-1,i)-Gdu(j+1,i) ) + abs( 2*R(j,i)-R(j-2,i)-R(j+2,i) );
      if deltaV>deltaH,
         Gdu(j,i) = ( Gdu(j,i-1)+Gdu(j,i+1) )/2 + ( 2*R(j,i)-R(j,i-2)-R(j,i+2) )/4;
      elseif deltaH>deltaV,
         Gdu(j,i) = ( Gdu(j-1,i)+Gdu(j+1,i) )/2 + ( 2*R(j,i)-R(j-2,i)-R(j+2,i) )/4;
      else
         Gdu(j,i) = (Gdu(j-1,i-1)+Gdu(j+1,i+1)+Gdu(j-1,i+1)+Gdu(j+1,i-1))/4 + ( 2*R(j,i)-R(j,i-2)-R(j,i+2) + 2*R(j,i)-R(j-2,i)-R(j+2,i))/8;
      end;

   end;
end;

GduTemp = Gdu;

%%%%% Bilinear interpolation
Rd2 = interp2(Rd,'linear');
Bd2 = interp2(Bd,'linear');

%%%%% Make sure that they have the same sizes...
Rdu = R; Rdu(1:height-1, 1:width-1) = Rd2; %figure; imshow(uint8(Rdu)); 
Bdu = B; Bdu(2:height, 2:width) = Bd2; %figure; imshow(uint8(Bdu));

%%%%% Output bilinearly interpolated image
out_bilinear(:,:,1)=Rdu;
out_bilinear(:,:,2)=G_bilinear;
out_bilinear(:,:,3)=Bdu;
%out_bilinear = uint8(out_bilinear);

%%%%% COMMENTS
% At this point Rdu and Bdu are bilinearly interpolated Red and Blue channels,
%	and Gdu is the interpolated Green channel using the edge-sensitive algorithm.

%%%%% Filters that will be used in subband decomposition 
h0 = [1 2 1]/4;
h1 = [1 -2 1]/4;
g0 = [-1 2 6 2 -1]/8;
g1 = [1 2 -6 2 1]/8;

%%%%% COMMENTS
% To try different wavelet filters from the MATLAB wavelet toolbox:
%[h0,h1,g0,g1] = wfilters(wname);
%
% To decompose the signal for another level, you can update the filters as follows
%hh0 = dyadup(h0,2);
%hh1 = dyadup(h1,2);
%gg0 = dyadup(g0,2);
%gg1 = dyadup(g1,2);


%%%%% Update Green channel
% Get the samples of Green channel on Red and Blue samples to form two small images. 
% 
Gd_R = dyaddown(Gdu,'m',1);
Gd_B = dyaddown(Gdu,'m',2);
%
% Update these small Green images using observed Red and Blue samples
[CA_Rr,CH_Rr,CV_Rr,CD_Rr] = rdwt2(Rd,h0,h1);
[CA_Gr,CH_Gr,CV_Gr,CD_Gr] = rdwt2(Gd_R,h0,h1); 
[CA_Bb,CH_Bb,CV_Bb,CD_Bb] = rdwt2(Bd,h0,h1);
[CA_Gb,CH_Gb,CV_Gb,CD_Gb] = rdwt2(Gd_B,h0,h1); 
%
Gd_R = ridwt2(CA_Gr, CH_Rr, CV_Rr, CD_Rr, g0,g1);
Gd_B = ridwt2(CA_Gb, CH_Bb, CV_Bb, CD_Bb, g0,g1);
%
Gdu(1:2:height,1:2:width)=Gd_R;  
Gdu(2:2:height,2:2:width)=Gd_B;
%

%%%%% Alternating projections algorithm starts here

for iter=1:iterN,
   %%%%% Decompose into subbands 
   [CA_Rdu,CH_Rdu,CV_Rdu,CD_Rdu] = rdwt2(Rdu,h0,h1);
   [CA_Gdu,CH_Gdu,CV_Gdu,CD_Gdu] = rdwt2(Gdu,h0,h1);
   [CA_Bdu,CH_Bdu,CV_Bdu,CD_Bdu] = rdwt2(Bdu,h0,h1);
   
   %%%%% Second-level decomposition 
   % To decompose the signal further, set the following to 1
   % DO NOT FORGET TO REMOVE THE COMMENT-OUTS ABOVE TO GET hh0, hh1, gg0, gg1
   DoSecond = 0;
   if DoSecond == 1,
      [CAA_Rdu, CHH_Rdu, CVV_Rdu, CDD_Rdu] = rdwt2(CA_Rdu,hh0,hh1);
      [CAA_Gdu, CHH_Gdu, CVV_Gdu, CDD_Gdu] = rdwt2(CA_Gdu,hh0,hh1);
      [CAA_Bdu, CHH_Bdu, CVV_Bdu, CDD_Bdu] = rdwt2(CA_Bdu,hh0,hh1);
      %
      CA_Rdu = ridwt2(CAA_Rdu, CHH_Gdu, CVV_Gdu, CDD_Gdu, gg0,gg1);
      CA_Gdu = ridwt2(CAA_Gdu, CHH_Gdu, CVV_Gdu, CDD_Gdu, gg0,gg1);
      CA_Bdu = ridwt2(CAA_Bdu, CHH_Gdu, CVV_Gdu, CDD_Gdu, gg0,gg1);
   end;
   %%%%% End of Second-level decomposition
   
   %%%%% DETAIL PROJECTION
   %%%%% Replace R and B high-freq channels with G high-freq channels
   % This implementation corresponds to setting the threshold to zero. (See the paper.)
   x_replace(:,:,1) = ridwt2(CA_Rdu, CH_Gdu, CV_Gdu, CD_Gdu, g0, g1);
   x_replace(:,:,2) = ridwt2(CA_Gdu, CH_Gdu, CV_Gdu, CD_Gdu, g0, g1);
   x_replace(:,:,3) = ridwt2(CA_Bdu, CH_Gdu, CV_Gdu, CD_Gdu, g0, g1);
   
   %%%%% OBSERVATION PROJECTION
   %%%%% Make sure that R and B channels obey the data 
   Rdu = x_replace(:,:,1);
   Rdu(1:2:height,1:2:width) = Rd2(1:2:height,1:2:width); 
   %
   Bdu = x_replace(:,:,3);
   Bdu(2:2:height,2:2:width) = Bd2(1:2:height,1:2:width); 
   
end;

%%%%% COMMENTS
% Convolution of the channels with the filters may create artifacts along the borders. 
% Here, I replace the borders with the bilinear and edge-sensitive data..
temp = double(out_bilinear(:,:,1));
temp(4:height-4,4:width-4) = Rdu(4:height-4,4:width-4);
Rdu = temp;
temp = GduTemp;
temp(4:height-4,4:width-4) = Gdu(4:height-4,4:width-4);
Gdu = temp;
temp = double(out_bilinear(:,:,3));
temp(4:height-4,4:width-4) = Bdu(4:height-4,4:width-4);
Bdu = temp;

%%%%% Output the image...
x_constrain(:,:,1) = Rdu;
x_constrain(:,:,2) = Gdu;
x_constrain(:,:,3) = Bdu;

%out_pocs = uint8(x_constrain);
out_pocs = x_constrain;

end

function theDSImage = dyaddown( InImage, x, y)
if y==1
    theDSImage = InImage( 1:2:end, 1:2:end);
elseif y==2
    theDSImage = InImage( 2:2:end, 2:2:end);
end
end

