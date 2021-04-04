function theResizeControl = initResize()

theResizeControl.Mode = 'ROI'; %ROI oder Image
%theResizeControl.Mode = 'Image'; %ROI oder Image
LeftX = 501;
TopY = 501;
WidthY = 400;
WidthX = 600;
theResizeControl.CropRect = [ LeftX, TopY, WidthX, WidthY];
SizeY = 400; 
SizeX = 600;
theResizeControl.Size = [ SizeX, SizeY];
theResizeControl.Method = 'nearest';
