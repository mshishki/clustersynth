function theImageFigure = imExplore( theImageObject, theDisplayImage)

%Figure �ffnen
theImageFigure = imtool( theDisplayImage, 'ImageObjectLeica', theImageObject, ...
                                'ImageName', theImageObject.Data.FileName);
