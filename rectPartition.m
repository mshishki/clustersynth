%% SPATIAL PARTITION
% Determine the largest acceptable no. of defect clusters in an image
% Bruteforce-y approximation w/ assumedly equidistant clusters just because

% https://www.youtube.com/watch?v=yCQN096CwWM
% https://gamedev.stackexchange.com/questions/6730/how-to-randomly-place-rectangle-inside-a-larger-bounding-rectangle-without-inter

function numRect = rectPartition(rw, rh, sw, sh, cs) 

maxPosX = 0;
maxDone = false;
maxPosY = 0;
numRect = 0;

if ((sw + cs)< rw && (sh + cs) < rh)
    posX = 0 + cs;
    posY = 0 + cs;
    while (posY + sh <= rh)
        if (posY + 2 * sh + cs > rh)
            if (posY + sw <= rh)
                swt = sw;
                sw = sh;
                sh = swt;
            end
        end
        while posX + sw + cs <= rw
            numRect = numRect + 1;
            posX = round(posX + sw + cs);
            maxPosY = posY;
        end
        if (~maxDone)
            maxPosX = posX;
            maxDone = true;
        end
        posX = 0 + cs;
        posY = round(posY + sh + cs);
    end
    
    if (maxPosX + sw <= rw)
        posY = 0 + cs;
        
        if (sw > sh)
            sht = sw;
            sw = sh;
            sh = sht;
        end
        
        while (posY + sw <= maxPosY)
            numRect = numRect + 1;
            posY = round(posY + sh + cs);
        end
    end
end

%areaLargeRectangle = rw * rh;
%areaSmallRectangle = sw * sh;

%areaAllRectangles = areaSmallRectangle * numRect;
%ratio = round(100 * areaAllRectangles / areaLargeRectangle);
end