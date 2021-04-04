function [ raw_image ] = open_binary_Raw( input_filename, headersize, xsize, ysize, orientation )
%[ raw_image ] = open_binary_raw( input_filename, headersize, xsize, ysize, orientation )
%input_filename: 'test.RAW'
%headersize: in byte
%orientation: 0 or 1 (portrait or landscape)

%Leica RAW Sizes: Header 108byte, x = 3976, y = 2647
%Leica DNG Sizes:....


%create a file identifier ('r': open file for reading)
fid = fopen(input_filename, 'r');

%set file position indicator to skip the header (headersize relative to the beginning of file (bof))
%status returns 0 if operation is succsessful and 1 if it fails
status = fseek(fid, headersize, 'bof');

if status == 0
    %read the file into the (y-size x-xsize)-matrix with uint16 precision
    raw_image = fread(fid, [xsize, ysize], 'uint16=>uint16');
    
    
    %close the file identifier
    fclose(fid);


    if orientation == 1 
        raw_image = raw_image';
    else
        raw_image = raw_image;
    end
    
    
else
    h = warndlg('Achtung, es stimmt etwas nicht','Die sehr präzise Warnung');
    waitfor(h);
end

%imdisplay(raw_image);