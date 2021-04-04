function theDeltaE = getDeltaE2( theLabIst, theLabSoll)

myDiff = theLabIst - theLabSoll;
 
[zeilen, spalten] = size( myDiff);
theDeltaE = zeros( zeilen, 1, 'double');
 
for i=1:zeilen
     theDeltaE( i, 1) = norm( myDiff( i, :));
end
 
