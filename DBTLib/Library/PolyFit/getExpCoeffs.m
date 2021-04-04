function theExpCoeffs = getExpCoeffs( theDims, theOrderVector)

myDimVector = zeros( 1, theDims, 'uint32');
myOrderNumber = max( theOrderVector) + 1;
myOrderDim = size( theOrderVector, 2);
myDimVector( :) = int32( myOrderNumber);
myDimVector( theDims+1) = theDims;

myExpArray = zeros( myDimVector, 'double');

firstTime = 1;

if theDims == 1
    for i=1:myOrderNumber
		myExpArray( i, :) = [ i-1];

		for z=1:myOrderDim
			if( sum( myExpArray( i, :)) == theOrderVector( z))
				if( firstTime)
					myResultVector = [i-1];
					firstTime = 0;
				else 
					myResultVector = [ myResultVector; i-1];
				end
			end
		end
    end
end

if theDims == 2
    for i=1:myOrderNumber
        for j=1:myOrderNumber
            myExpArray( i, j, :) = [ i-1, j-1];
            
            for z=1:myOrderDim
                if( sum( myExpArray( i, j, :)) == theOrderVector( z))
                    if( firstTime)
                        myResultVector = [i-1, j-1];
                        firstTime = 0;
                    else 
                        myResultVector = [ myResultVector; i-1, j-1];
                    end
                end
            end
        end
    end
end

if theDims == 3
    for i=1:myOrderNumber
        for j=1:myOrderNumber
            for k=1: myOrderNumber
                myExpArray( i, j, k, :) = [ i-1, j-1, k-1];

                for z=1:myOrderDim
                    if( sum( myExpArray( i, j, k, :)) == theOrderVector( z))
                        if( firstTime)
                            myResultVector = [i-1, j-1, k-1];
                            firstTime = 0;
                        else 
                            myResultVector = [ myResultVector; i-1, j-1, k-1];
                        end
                    end
                end
            end
        end
    end
end

theExpCoeffs = fliplr( myResultVector);