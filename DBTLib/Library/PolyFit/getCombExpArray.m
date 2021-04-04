function theCombExpArray = getCombExpArray( theDim, thePolyOrder, theStaticOnOff)
switch theStaticOnOff
	case 'noStatic'
		switch thePolyOrder
			case 1
				theCombExpArray = getExpCoeffs( theDim, [1]);
			case 2
				theCombExpArray = getExpCoeffs( theDim, [1, 2]);
			case 3
				theCombExpArray = getExpCoeffs( theDim, [1, 2, 3]);
			case 4
				theCombExpArray = getExpCoeffs( theDim, [1, 2, 3, 4]);
			case 5
				theCombExpArray = getExpCoeffs( theDim, [1, 2, 3, 4, 5]); 
		end
	case 'Static'
		switch thePolyOrder
			case 1
				theCombExpArray = getExpCoeffs( theDim, [0, 1]);
			case 2
				theCombExpArray = getExpCoeffs( theDim, [0, 1, 2]);
			case 3
				theCombExpArray = getExpCoeffs( theDim, [0, 1, 2, 3]);
			case 4
				theCombExpArray = getExpCoeffs( theDim, [0, 1, 2, 3, 4]);
			case 5
				theCombExpArray = getExpCoeffs( theDim, [0, 1, 2, 3, 4, 5]); 
		end
end
		
