function theImageObject = dataImage_new( theImageData, theImageTypeName, theImageFileName)
% data:image:
% :Type
% :Data.ImageData
% :Data.Filename
% :FuncPtr.buildFigure( theImageObject, theTaskHandle)
% :FuncPtr.buildDisplayImage( theImageData, theDisplayControl)

if ~exist( 'theImageFileName')
    theImageFileName = '';
end

theImageObject = data_new( 'Image');
if( exist( 'theImageTypeName'))
    if( strcmp( theImageTypeName, '') == 0)
        theImageObject.Type = append( theImageObject.Type, [ '_Image_', theImageTypeName, '_']);
    else
        theImageObject.Type = append( theImageObject.Type, [ '_Image_']);
    end
end
%theImageObject = setProperty( theImageObject, 'Type', append( getProperty( theImageObject, 'Type'), theImageTypeName));

theImageObject.Data.ImageData = theImageData;
if exist( 'theImageFileName') 
    theImageObject.Data.FileName = theImageFileName;
else
    theImageObject.Data.FileName = [];
end

theImageObject.FuncPtr.buildFigure = @dataImage_buildFigure;
theImageObject.FuncPtr.buildDisplayImage = @buildDisplayImageRGB;

%Bildeigenschaften an Bildtyp adaptieren, z.B. eine spezielle
%Displayroutine
if( exist( 'theImageTypeName'))
    theImageObject = adjustImageType( theImageObject, theImageObject.Type);%theImageTypeName);
end



function theImageFigure = dataImage_buildFigure( theImageObject, theDisplayControl, theFigure)

%Display Image: Gammakorrektur berechnen 
myDisplayImage = theImageObject.FuncPtr.buildDisplayImage( theImageObject.Data.ImageData, theImageObject.Type, theDisplayControl);

%Bilddaten mit 2 Kanälen anpassen
myNumChannels = size( myDisplayImage, 3);
if( myNumChannels < 3)
    if( theDisplayControl.Fill3Channels)
        for i=myNumChannels+1:3
            myDisplayImage( :, :, i) = myDisplayImage( :, :, myNumChannels);
        end
    else
        for i=myNumChannels+1:3
            myDisplayImage( :, :, i) = 0;
        end
    end
end
    

%Bisherige Figur verwenden
if( exist( 'theFigure') && theFigure~=0)
    theImageFigure = figure( theFigure);
	warning off Images:initSize:adjustingMag;
	imshow( myDisplayImage);
	warning on Images:initSize:adjustingMag;
	
	%Titel setzen
    myFigureName = [ theImageObject.Data.FileName, ' ', getImSizeInfo( theImageObject)];
    set( theImageFigure, 'Name', myFigureName);
	
	%ImageObject an die Figure übergeben
	myUserData.ImageData = theImageObject;
	set( theImageFigure, 'UserData', myUserData);
else
    %Figure öffnen
%     theImageFigure = imtool( myDisplayImage, 'ImageObjectLeica', theImageObject, 'ImageName', theImageObject.Data.FileName);
% %         [ myImageHandle, myAxesHandles, myFigureHandle] = imhandles( theImageFigure);
% %         setFieldOfUserData( myImageHandle, 'OriginalImage', theImageObject);
% %     %Figure öffnen
    myFigureName = [ theImageObject.Data.FileName, ' ', getImSizeInfo( theImageObject)];
    theImageFigure = imdisplay( myDisplayImage, myFigureName);
    
	%ImageObject an die Figure übergeben
	myUserData.ImageData = theImageObject;
	set( theImageFigure, 'UserData', myUserData);
	
end



