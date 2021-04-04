function map = pxDecay(IMG, varargin)
% PIXELBLAST Corrupt the image by creating defect rectangular pixel regions
%   and return it with the corresponding mask

sz = size(IMG);

% Defaults
clusterSize = 3; % defect cluster are 3x3px each
windowSize = 30; % Search in the 30x30 neighborhood    

if numel(varargin) > 0 %rem(nargin, 1) ~= 0 
    for ii = 1:2:numel(varargin)
        if strcmp('WindowSize', varargin{ii})
            windowSize = varargin{ii+1};
        end
        if strcmp('ClusterSize', varargin{ii})
            %constant or varies at random
            clusterSize = varargin{ii+1};
        end
        if strcmp('NumDefects', varargin{ii})
            numDefects = varargin{ii+1};
        
        else
            % max no. of squares is based on dimensions of the IMG, clusterSize
            % and windowSize [to prevent problems during correlation in the first testing stage)] 
            nRect = rectPartition(sz(1), sz(2), clusterSize, clusterSize, windowSize);
            numDefects = randi(1, nRect); 
        end
    end
end

randpos = @(x) max(floor(9/2), randi([floor(9/2), x - windowSize], 'like', clusterSize));
%randposmax = @(x) min(randi(x), size(I,x)-windowSize);


sqoords = arrayfun(randpos, sz);
defect = @(x,y) poly2mask([x x+clusterSize x+clusterSize x],[y y y+clusterSize y+clusterSize], sz(1), sz(2));
%feval(@(x) x(:), arrayfun(randpos, sz));
map = defect(sqoords(2),sqoords(1));

if numDefects > 1
    
    for i = 2:numDefects
        sqoords = arrayfun(randpos, sz);
        while any(any(and(map, defect(sqoords(2),sqoords(1)))))
            sqoords = arrayfun(randpos, sz);

        end
        map = or(map, defect(sqoords(2),sqoords(1)));
    end
end

end