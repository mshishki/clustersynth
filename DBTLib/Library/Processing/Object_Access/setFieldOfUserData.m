function setFieldOfUserData( theObjectHandle, theFieldName, theFieldValue)
myUserData = get( theObjectHandle, 'UserData');

myUserData = setfield( myUserData, theFieldName, theFieldValue);

set( theObjectHandle, 'UserData', myUserData);
