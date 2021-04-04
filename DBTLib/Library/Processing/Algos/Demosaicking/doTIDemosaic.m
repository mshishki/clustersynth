function [output]=doTIDemosaic(input)
% Bilinear Interpolation of the missing pixels
% Bayer CFA
%       R G R G
%       G B G B
%       R G R G
%       G B G B
%
% The input can be on one or three channels
%
% Output = a complete RGB image on 3 channels

Epsilon = 0.00000000001;

im=double(input);
    
M = size(im, 1);
N = size(im, 2);
channel = size(size(im), 2);    % == 2 => one channel
                                % == 3 => three channel

red_mask = repmat([1 0; 0 0], M/2, N/2);
green_mask = repmat([0 1; 1 0], M/2, N/2);
blue_mask = repmat([0 0; 0 1], M/2, N/2);

if channel == 2
    R=im.*red_mask;
    G=im.*green_mask;
    B=im.*blue_mask;
elseif channel == 3
    R=im(:,:,1).*red_mask;
    G=im(:,:,2).*green_mask;
    B=im(:,:,3).*blue_mask;
end
    
% Interpolation for the green at the missing points
    G= G + imfilter(G, [0 1 0; 1 0 1; 0 1 0]/4);
    
% G-Hochpassanteil für den R-Kanal
    GR = G.*red_mask;
% Interpolation for the red at the missing points
% First, calculate the missing red pixels at the blue location
    GR1 = imfilter(GR,[1 0 1; 0 0 0; 1 0 1]/4);
% Second, calculate the missing red pixels at the green locations   
    GR2 = imfilter(GR+GR1,[0 1 0; 1 0 1; 0 1 0]/4);
    GRInterpol = GR + GR1 + GR2;
    clear GR1 GR2;
    GRHigh = (G - GRInterpol)./ max( GRInterpol, Epsilon);
    
% G-Hochpassanteil für den R-Kanal
    GB = G.*blue_mask;
% Interpolation for the blue at the missing points
% First, calculate the missing blue pixels at the red location
    GB1 = imfilter(GB,[1 0 1; 0 0 0; 1 0 1]/4);
% Second, calculate the missing blue pixels at the green locations
% by averaging the four neighouring blue pixels
    GB2 = imfilter(GB+GB1,[0 1 0; 1 0 1; 0 1 0]/4);
    GBInterpol = GB + GB1 + GB2;
    clear GB1 GB2;
    GBHigh = (G - GBInterpol)./ max( GBInterpol, Epsilon);
    
% Interpolation for the blue at the missing points
% First, calculate the missing blue pixels at the red location
    B1 = imfilter(B,[1 0 1; 0 0 0; 1 0 1]/4);
% Second, calculate the missing blue pixels at the green locations
% by averaging the four neighouring blue pixels
    B2 = imfilter(B+B1,[0 1 0; 1 0 1; 0 1 0]/4);
    B = B + B1 + B2;
    clear B1 B2;
% Interpolation for the red at the missing points
% First, calculate the missing red pixels at the blue location
    R1 = imfilter(R,[1 0 1; 0 0 0; 1 0 1]/4);
% Second, calculate the missing red pixels at the green locations   
    R2 = imfilter(R+R1,[0 1 0; 1 0 1; 0 1 0]/4);
    R = R + R1 + R2;
    clear R1 R2;
    
    R = R + GRHigh .* R;
    B = B + GBHigh .* B;
    

    output = zeros( M, N, 3, class( input));
    output(:,:,1)=R; output(:,:,2)=G; output(:,:,3)=B;

