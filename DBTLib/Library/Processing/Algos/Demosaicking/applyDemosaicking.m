function theOutputImage = applyDemosaicking( theSensorOutputImage, theDemosaickingAlgoName)

switch theDemosaickingAlgoName.AlgoType
    case 'fast'
        theOutputImage = doFastDemosaic( theSensorOutputImage);
    case 'bilinear'
        theOutputImage = doBilinearDemosaic( theSensorOutputImage);
    case 'POCS' %projections onto convex sets 
        theOutputImage = doPOCSDemosaic( theSensorOutputImage);
    case 'TI' %TI US6975354 modifiziert, own CFA interpolation method 
        theOutputImage = doTIDemosaic( theSensorOutputImage);
    case 'none' %nothing to do
        theOutputImage = theSensorOutputImage;
end

end %applyDemosaicking



