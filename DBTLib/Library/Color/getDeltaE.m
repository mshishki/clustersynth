function theDeltaE = getDeltaE( theLab1, theLab2)

myDiff = theLab1 - theLab2;
 
[zeilen, spalten] = size( myDiff);
theDeltaE = zeros( zeilen, 1, 'double');
 
for i=1:zeilen
     theDeltaE( i, 1) = norm( myDiff( i, :));
end
 
