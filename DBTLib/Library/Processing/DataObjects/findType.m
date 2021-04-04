function theType = findType( theName)

Separator = length( theName);
while theName( Separator) ~= '_'
	Separator = Separator - 1;
end
theType = theName( Separator+1 : end);
