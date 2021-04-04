function theImageFigure = imExplore( theImageObject, theDisplayImage)

%Figure öffnen
theImageFigure = imtool( theDisplayImage, 'ImageObjectLeica', theImageObject, ...
                                'ImageName', theImageObject.Data.FileName);
