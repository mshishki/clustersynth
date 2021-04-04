function theFieldValue = getFieldOfUserData( theObjectHandle, theFieldName)
theFieldValue = [];

myNumObjects = length( theObjectHandle);
for i=1:myNumObjects
    myUserData = get( theObjectHandle( i), 'UserData');
    theFieldValue = getFieldFromName( myUserData, theFieldName);
    %Beim ersten gefundenen Eintrag diesen zurückliefern:
    if ~isempty( theFieldValue)
        return;
    end
end
