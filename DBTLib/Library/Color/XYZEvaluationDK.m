function XYZEvaluationDK( theXYZIst, theXYZSoll, theRGB2XYZMatrix)

myChromaticityChartFigure = getChromaticitiesDiagram( 'XYZ Evaluation');
DrawSpectralCurve( myChromaticityChartFigure);

if( exist( 'theRGB2XYZMatrix') && ~isempty( theRGB2XYZMatrix))
	DrawRGBTriangle( myChromaticityChartFigure, theRGB2XYZMatrix, 'm');
end
showXYDifferences( theXYZIst, theXYZSoll, myChromaticityChartFigure)

