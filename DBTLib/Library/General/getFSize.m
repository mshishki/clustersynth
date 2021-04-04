function theFileSizeInBytes = getFSize( theFileName)

myFID = fopen( theFileName);
fseek( myFID, 0, 'eof');
theFileSizeInBytes = ftell( myFID);
fclose( myFID);

end %getFSize

