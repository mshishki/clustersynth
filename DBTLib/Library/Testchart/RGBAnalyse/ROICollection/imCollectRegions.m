function [theImageRegions, theImage] = imCollectRegions()

% Bild ausw�hlen;
[file, path] = uigetfile ('*.*');

image = imread([path file(1,:)]);

% Schleife, die  solange �ber "Bildausschnitt w�hlen"(rect) l�uft und Infos sammelt, 
% bis per Tastendruck "a" abgebrochen wird 
myEnd = 0;
i = 1;
while myEnd == 0

    % Bildausschnitt w�hlen; mit imcrop; liefert Koordinaten und Gr��e der Auswahl
    rect = RectImages( image);

    % Bildausschnitt aus Bild ausschneiden; liefert 1 Ausschnitt 
    partimage = PartImage(image, rect);
    
    % Bildausschnitte sammeln
    mySavePart.PartRect = rect;
    mySavePart.Info.Partimage = partimage;


    % Die Bildausschnitte werden alle
    % in einem Vektor gesammelt 
    if( i == 1)
        informationVector = mySavePart;
    else
        informationVector( i) = mySavePart;
    end

    i = i+1;
    
    %Schleifensteuerung
    [x,y,button] = ginput( 1);
    if button == 'a'
        myEnd = 1;
    end
    
end %while

% Infos zusammenbauen
mySaveData.ImFileName = char( file);
mySaveData.Parts = informationVector;

% Infos speichern
mySaveName = [ file( 1:end-4), '.mat'];
save( mySaveName, 'mySaveData');

%externe �bergaben:
theImageRegions = mySaveData;
theImage = image;
