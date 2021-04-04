function theVarStr = getVarStr( theVarName, theVarNum)
%liefert String mit variablen Eingangsparametern zurück (für eval())
%Beispiel: new()
theVarStr = '';

for i=1:theVarNum
    %erste Indexebene loswerden -> { 1}:
    theVarStr = append( theVarStr, [ theVarName, '{ 1}{ ', num2str( i), '}']);
    if i<theVarNum
        %Trennzeichen Komma
        theVarStr = append( theVarStr, ', ');
    end 
end