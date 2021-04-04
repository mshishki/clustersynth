function theInfoString = getImSizeInfo( theImageObject)

myImageClass = getImObjClass( theImageObject);
[myY, myX, myImageChannelNumber] = size( theImageObject.Data.ImageData);
theInfoString = [ '<', num2str( myY), 'x', num2str( myX), 'x', num2str( myImageChannelNumber), ' ', myImageClass, '>'];
