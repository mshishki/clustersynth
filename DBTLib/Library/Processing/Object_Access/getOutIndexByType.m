function  theOutputIndexList = getOutIndexByType( theTaskList, theOutDataType)
Index = 0;
theOutputIndexList = [];

NumTasks = size( theTaskList, 2);
NumTypes = size( theOutDataType, 2);

for i=1:NumTasks
    Algo = theTaskList( i).Algo;
    NumOutputs = size( Algo.Data.Output.Output, 2);
    
    for j=1:NumOutputs
        Index = Index + 1;
        Type = Algo.Data.Output.Output( j).Output.Type;
%         Type = Algo.Data.Output.Output( j).Type;
        for k=1:NumTypes
            if ~isempty( strfind( Type, cell2mat( theOutDataType( k))))
                theOutputIndexList = append( theOutputIndexList, Index);
            end
        end
    end
end


