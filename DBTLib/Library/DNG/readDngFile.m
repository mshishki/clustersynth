function [ dng_image, meta_info] = readDngFile( dng_filepath,correctionmode )
%READDNGFILE This function is designed by Rob Sumner, Department of
%Electrical Engineering, UC Santa Cruz.
%   For details see:Rob Sumner, Prcessing RAW Images in MATLAB, 2014

    warning off MATLAB:imagesci:Tiff:libraryWarning
	warning off MATLAB:tifflib:TIFFReadDirectory:libraryWarning
    t=Tiff(dng_filepath,'r');
    offsets=getTag(t,'SubIFD');
    setSubDirectory(t,offsets(1));
    raw=read(t);
    close(t);
    meta_info=imfinfo(dng_filepath);
    
    if ~strcmp( correctionmode,'raw')
		x_origin=meta_info.SubIFDs{1}.DefaultCropOrigin(2);
		%x_origin=meta_info.SubIFDs{1}.ActiveArea(2)+1;
		width=meta_info.SubIFDs{1}.DefaultCropSize(1);
		y_origin=meta_info.SubIFDs{1}.DefaultCropOrigin(1);
		%y_origin=meta_info.SubIFDs{1}.ActiveArea(1)+1;
		height=meta_info.SubIFDs{1}.DefaultCropSize(2);
		raw=double(raw(y_origin:y_origin+height-1,x_origin:x_origin+width-1));
		
		%Linearisierung
		black=meta_info.SubIFDs{1}.BlackLevel(1);%evtl. schwarz für jeden Kanal!
		saturation=meta_info.SubIFDs{1}.WhiteLevel;
		lin_bayer=(raw-black)/(saturation-black);
		lin_bayer=max(0,min(lin_bayer,1));

		%Whitebalance
		wb_multipliers=(meta_info.AsShotNeutral).^-1;
		wb_multipliers=wb_multipliers/wb_multipliers(2);
		wbmask=whitebalanceMask(size(lin_bayer,1),size(lin_bayer,2),...
								wb_multipliers(1),wb_multipliers(3));
		bal_bayer=lin_bayer.*wbmask;

		%Demosaicing
		temp=uint16(bal_bayer/max(bal_bayer(:))*2^16);
		lin_rgb=double(demosaic(temp,'rggb'))/2^16;

		%Color Space Conversion
		XYZ2CAM=reshape(meta_info.ColorMatrix2,3,3)';
		sRGB2XYZ=[0.4124564 0.3575761 0.1804375;...
				  0.2126729 0.7151522 0.0721750;...
				  0.0193339 0.1191920 0.9503041];

		sRGB2CAM=XYZ2CAM*sRGB2XYZ;
		sRGB2CAM=sRGB2CAM./repmat(sum(sRGB2CAM,2),1,3);%normalize rows to 1
		CAM2sRGB=sRGB2CAM^-1;
		lin_srgb=apply_cmatrix(lin_rgb,CAM2sRGB);
		lin_srgb=max(0,min(lin_srgb,1));%always keep image clipped b/w 0-1

		%Brightnes and Gamma Correction
		grayim=rgb2gray(lin_srgb);
		grayscale=0.25/mean(grayim(:));
		bright_srgb=min(1,lin_srgb*grayscale);
		nl_srgb=srgbGamma(bright_srgb);
	end
	
    %Output
    if(strcmp(correctionmode,'raw'))
        dng_image=raw;
    elseif(strcmp(correctionmode,'lin'))
        dng_image=lin_bayer;
    elseif(strcmp(correctionmode,'wbl'))
        dng_image=bal_bayer;
    elseif(strcmp(correctionmode,'dmo'))
        dng_image=lin_rgb;
    elseif(strcmp(correctionmode,'srgb'))
        dng_image=lin_srgb;
    elseif(strcmp(correctionmode,'brightAndGamma'))
        dng_image=nl_srgb;
    else
        error('wrong inpur argument for correction mode')
    end

end

function [ colorMask ] = whitebalanceMask( m,n,r_scale,b_scale )

colorMask=ones(m,n);

colorMask(1:2:end,1:2:end)=r_scale;
colorMask(2:2:end,2:2:end)=b_scale;
    
end

function corrected = apply_cmatrix(im,cmatrix)
% CORRECTED = apply_cmatrix(IM,CMATRIX)
% Applies CMATRIX to RGB input IM. Finds appropriate weighting of the old
% color planes to form the new color lanes, equivalent to but much more
% efficient than applying a matrix transformation to each pixel.

if (size(im,3)~=3)
    error('Apply cmatrix to RGB image only.')
end

r=cmatrix(1,1)*im(:,:,1)+cmatrix(1,2)*im(:,:,2)+cmatrix(1,3)*im(:,:,3);
g=cmatrix(2,1)*im(:,:,1)+cmatrix(2,2)*im(:,:,2)+cmatrix(2,3)*im(:,:,3);
b=cmatrix(3,1)*im(:,:,1)+cmatrix(3,2)*im(:,:,2)+cmatrix(3,3)*im(:,:,3);

corrected = cat(3,r,g,b);
end

function out = srgbGamma(in)
% OUT = srgbGamma(in)
%
% Applies (inverse) sRGB gamma correction to an RGB image.
% Assumes input values are scaled between 0 and 1, return similar range.

in(in>1)=1;
in(in<0)=0;

out=zeros(size(in));
nl=in>0.0031308;
out(nl)=1.055*(in(nl).^(1/2.4))-0.055;
out(~nl)=12.92*in(~nl);

end