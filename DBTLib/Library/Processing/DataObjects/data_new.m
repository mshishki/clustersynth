function theDataObject = data_new( theDataObjectName)

%inheritance:
theDataObject = object_new( theDataObjectName);

theDataObject.Type = append( theDataObject.Type, '_data');
theDataObject.Data.Data = [];

theDataObject.FuncPtr.buildFigure = 0;

