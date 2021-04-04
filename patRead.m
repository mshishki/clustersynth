%[file, path] = uigetfile({'PT/*.*'}, 'Select a pattern', 'PT/efr2.tif');
function [I, imf] = patRead(fp)
    I = imread(fp);
    imf = imfinfo(fp);
    
    if imf.ColorType == "truecolor"
        I = I(:,:,1:3); % falls Alpha-Kanal präsent
        I = rgb2gray(I);
    end
    
    I = im2double(I);
end