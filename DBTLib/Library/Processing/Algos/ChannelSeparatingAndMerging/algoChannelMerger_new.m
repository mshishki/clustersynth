function theAlgoChannelMerger = algoChannelMerger_new()
%Input: 

theAlgoChannelMerger = algo_new( 'ChannelMerger');

theAlgoChannelMerger.FuncPtr.getSettings = @algoChannelMerger_getSettings;
theAlgoChannelMerger.FuncPtr.getInputTypeList = @algoChannelMerger_getInputTypeList;
theAlgoChannelMerger.FuncPtr.execute = @algoChannelMerger_execute;



function theChannelMergerSettings = algoChannelMerger_getSettings( theAlgoControl)

theChannelMergerSettings.Settings = [];


function theInputTypeList = algoChannelMerger_getInputTypeList()

theInputTypeList( 1:100) = {[{ 'Image'}]};   %max. 100 Input Images



function theAlgoChannelMergerOut = algoChannelMerger_execute( theAlgoChannelMergerIn, theSettings, theInput)
theAlgoChannelMergerOut = theAlgoChannelMergerIn;

%Reihenfolge und Zielbildtyp feststellen
[ ImageType, SortedInput] = analyseMultiChannels( theInput.Input);

%Kanäle zusammenfasssen:
myNumImages = size( SortedInput, 2);
myStartChanNr = 1;
for i=1:myNumImages
    SingleImage = SortedInput( i).Input.Data.ImageData;
    [myNumY, myNumX, myNumChan] = size( SingleImage);
    if( exist( 'myLastNumX') && ~isequal( [ myNumY, myNumX], [ myLastNumY, myLastNumX]))
        error( 'Leica: MultiImageMismatch', 'Image dimensions do not fit to merge.');
    end
    
    MergedImage( :, :, myStartChanNr : myStartChanNr + myNumChan -1) = ...
                                        SingleImage( :, :, 1 : myNumChan);
    %Merging Index merken:
    myStartChanNr = myStartChanNr + myNumChan;
    %Dimensionen des letzten Bildes:
    myLastNumX = myNumX; myLastNumY = myNumY;
    
end

theAlgoChannelMergerOut.Data.Output.Output( 1).Output = new( 'dataImage', { MergedImage, ImageType, getTaskName( theAlgoChannelMergerOut)});



% -------------------------------
function [ theImageType, theSortedInput] = analyseMultiChannels( theInputImages)

fDone = false;

%Spezialfälle:
if size( theInputImages, 2)==1
    % 1 Bild
    theImageType = getfield( theInputImages( 1).Input, 'Type');
    theSortedInput = theInputImages( 1);
    fDone = true;    
elseif size( theInputImages, 2)==2
    % 2 Bilder
    my_LIndex = getTypeIndex( theInputImages, '_L_');
    my_abIndex = getTypeIndex( theInputImages, '_ab_');
    my_aIndex = getTypeIndex( theInputImages, '_a_');
    my_bIndex = getTypeIndex( theInputImages, '_b_');
    
    if( ~isempty( my_LIndex) && ~isempty( my_abIndex))
        if( isType( theInputImages( 1).Input, '_Log_'))
            theImageType = 'Log_Lab';
        else
            theImageType = 'Lab';
        end
        theSortedInput( 1) = theInputImages( my_LIndex);
        theSortedInput( 2) = theInputImages( my_abIndex);
        fDone = true;    
    elseif( ~isempty( my_aIndex) && ~isempty( my_bIndex))
        if( isType( theInputImages( 1).Input, '_Log_'))
            theImageType = 'Log_ab';
        else
            theImageType = 'ab';
        end
        theSortedInput( 1) = theInputImages( my_aIndex);
        theSortedInput( 2) = theInputImages( my_bIndex);
        fDone = true;    
    end
elseif size( theInputImages, 2)==3
    % 3 Bilder
    my_LIndex = getTypeIndex( theInputImages, '_L_');
    my_aIndex = getTypeIndex( theInputImages, '_a_');
    my_bIndex = getTypeIndex( theInputImages, '_b_');
    my_RIndex = getTypeIndex( theInputImages, '_R_');
    my_GIndex = getTypeIndex( theInputImages, '_G_');
    my_BIndex = getTypeIndex( theInputImages, '_B_');

    if( ~isempty( my_LIndex) && ~isempty( my_aIndex) && ~isempty( my_bIndex))
        if( isType( theInputImages( 1).Input, '_Log_'))
            theImageType = 'Log_Lab';
        else
            theImageType = 'Lab';
        end
        theSortedInput( 1) = theInputImages( my_LIndex);
        theSortedInput( 2) = theInputImages( my_aIndex);
        theSortedInput( 3) = theInputImages( my_bIndex);
        fDone = true;    
    elseif( ~isempty( my_RIndex) && ~isempty( my_GIndex) && ~isempty( my_BIndex))
        if( isType( theInputImages( 1).Input, '_Log_'))
            theImageType = 'Log_RGB';
        elseif( isType( theInputImages( 1).Input, '_Lin_'))
            theImageType = 'Lin_RGB';
        else
            theImageType = 'RGB';
        end
        theSortedInput( 1) = theInputImages( my_RIndex);
        theSortedInput( 2) = theInputImages( my_GIndex);
        theSortedInput( 3) = theInputImages( my_BIndex);
        fDone = true;    
    end
end

%default:
if ~fDone
    theImageType = '';
    theSortedInput = theInputImages;
end
    


% -------------------------------
function theIndex = getTypeIndex( theInputList, theType)
% returns a List of indices
myNumInput = size( theInputList, 2);
myIndexInd = 1;
theIndex = [];

for i= 1: myNumInput
    myImageObj = theInputList( i).Input;
    if isType( myImageObj, theType)
        theIndex( myIndexInd) = i;
        myIndexInd = myIndexInd + 1;
    end
end
