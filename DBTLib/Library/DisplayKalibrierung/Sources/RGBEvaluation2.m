function theDeltaE = RGBEvaluation2( theRGBIst, theRGBSoll)
%Usage: theDeltaE = RGBEvaluation( theRGBIst, theRGBSoll);

myGamma = 1/2.2;
myOpt = ['-t1 -i ', '*sRGB', ' -o ', '*Lab'];
myLabIst = icctrans( theRGBIst.^myGamma, myOpt);
myLabSoll = icctrans( theRGBSoll.^myGamma, myOpt);

% grafische Auswertung Delta E
theDeltaE = LabEvaluationIE( myLabIst, myLabSoll);
