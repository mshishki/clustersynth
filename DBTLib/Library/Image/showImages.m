function showImages( theAdobeRGBLin, theDispProfileList, theControl)						
	for i=1:length( theDispProfileList)
		myProfile = cell2mat( theDispProfileList( i));
		myDispImage = imColorTransform(	theAdobeRGBLin, ...
										theControl.Algo.CM.Profiles.AdobeRGBLinear, ...
										myProfile);
		[ Path, ProfName, Ext, Vsn] = fileparts( myProfile);
		imdisplay( myDispImage, [ 'AdobeRGB -> ', ProfName]);
	end
