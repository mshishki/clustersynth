function thesrgblin = rgbcam2srgblin( theRaw, theBlack, theWhite, theAsShotNeutral, ...
									theBayerPattern, theFlareFactor, theBrightnessValue, ...
									theColorMatrix, theResizeFactor)
%theBrightnessValue: 
% 0->keine Normierung 
% <0 -> Normierung auf bright-fachen Max-Wert des Bildes
% sonst -> Normierung auf Mittelwert (Zielwert theBrightnessValue)

		%Linearisierung
		lin_bayer=(single( theRaw)-theBlack)/(theWhite-theBlack);
		lin_bayer=max(0,min(lin_bayer,1));
		
		%Whitebalance
		wb_multipliers=( theAsShotNeutral).^-1;
		wb_multipliers=wb_multipliers(:)/wb_multipliers(2);
		if ndims( theRaw) == 2%CFA
			bal_bayer=whitebalanceBayer(lin_bayer,wb_multipliers, theBayerPattern);
		else
			for i=1:3
				bal_bayer( :, :, i) = lin_bayer( :, :, i) * wb_multipliers( i);
			end
		end

		if ndims( theRaw) == 2%CFA
			%Demosaicing
			temp=im2uint16( bal_bayer);
			lin_rgb=imresize( im2single(demosaic(temp, theBayerPattern)), theResizeFactor);
		else%RGB
			lin_rgb = bal_bayer;
		end
		
		%Streulicht
		flare = [ mean2( lin_rgb( :, :, 1)), ...
						mean2( lin_rgb( :, :, 2)), ...
						mean2( lin_rgb( :, :, 3))]*theFlareFactor;
		lin_rgb( :, :, 1) = lin_rgb( :, :, 1) - flare( 1);
		lin_rgb( :, :, 2) = lin_rgb( :, :, 2) - flare( 2);
		lin_rgb( :, :, 3) = lin_rgb( :, :, 3) - flare( 3);

		%Color Space Conversion
		XYZ2CAM=reshape( theColorMatrix,3,3)';
		sRGB2XYZ=[0.4124564 0.3575761 0.1804375;...
				  0.2126729 0.7151522 0.0721750;...
				  0.0193339 0.1191920 0.9503041];

		sRGB2CAM=XYZ2CAM*sRGB2XYZ;
		sRGB2CAM=sRGB2CAM./repmat(sum(sRGB2CAM,2),1,3);%normalize rows to 1
		CAM2sRGB=sRGB2CAM^-1;
		lin_srgb=imMatMulSingle(lin_rgb,CAM2sRGB);
		lin_srgb=max(0,min(lin_srgb,1));%always keep image clipped b/w 0-1
	
		%Brightness Correction
		grayim=rgb2gray( lin_srgb);
		
		if abs( theBrightnessValue) < 1e-9 %falls 0
			grayscale = 1;
		elseif theBrightnessValue < 0
			grayscale = abs( theBrightnessValue) / max( grayim(:));
		else
			grayscale = theBrightnessValue / mean( grayim(:));
		end
		thesrgblin = min( 1, lin_srgb * grayscale);
