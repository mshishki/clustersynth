function theAlgoChannelSeparator = algoChannelSeparator_new()
%Input: 

theAlgoChannelSeparator = algo_new( 'ChannelSeparator');

theAlgoChannelSeparator.FuncPtr.getSettings = @algoChannelSeparator_getSettings;
theAlgoChannelSeparator.FuncPtr.getInputTypeList = @algoChannelSeparator_getInputTypeList;
theAlgoChannelSeparator.FuncPtr.execute = @algoChannelSeparator_execute;



function theChannelSeparatorSettings = algoChannelSeparator_getSettings( theAlgoControl)

theChannelSeparatorSettings.Settings = [];


function theInputTypeList = algoChannelSeparator_getInputTypeList()

theInputTypeList( 1) = {[{ 'Image'}]};



function theAlgoChannelSeparatorOut = algoChannelSeparator_execute( theAlgoChannelSeparatorIn, theSettings, theInput)
theAlgoChannelSeparatorOut = theAlgoChannelSeparatorIn;

ImageObject = theInput.Input( 1).Input;
Image = ImageObject.Data.ImageData;

if( isType( ImageObject, '_Lab_'))
    if( isType( ImageObject, '_Log_'))
        theAlgoChannelSeparatorOut.Data.Output.Output( 1).Output = new( 'dataImage', { Image( :, :, 1), 'Log_L', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 2).Output = new( 'dataImage', { Image( :, :, 2), 'Log_a', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 3).Output = new( 'dataImage', { Image( :, :, 3), 'Log_b', getTaskName( theAlgoChannelSeparatorOut)});
    else
        theAlgoChannelSeparatorOut.Data.Output.Output( 1).Output = new( 'dataImage', { Image( :, :, 1), 'L', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 2).Output = new( 'dataImage', { Image( :, :, 2), 'a', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 3).Output = new( 'dataImage', { Image( :, :, 3), 'b', getTaskName( theAlgoChannelSeparatorOut)});
    end
elseif( isType( ImageObject, '_ab_'))
    if( isType( ImageObject, '_Log_'))
        theAlgoChannelSeparatorOut.Data.Output.Output( 1).Output = new( 'dataImage', { Image( :, :, 1), 'Log_a', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 2).Output = new( 'dataImage', { Image( :, :, 2), 'Log_b', getTaskName( theAlgoChannelSeparatorOut)});
    else
        theAlgoChannelSeparatorOut.Data.Output.Output( 1).Output = new( 'dataImage', { Image( :, :, 1), 'a', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 2).Output = new( 'dataImage', { Image( :, :, 2), 'b', getTaskName( theAlgoChannelSeparatorOut)});
    end
elseif( isType( ImageObject, '_RGB_'))
    if( isType( ImageObject, '_Lin_'))
        theAlgoChannelSeparatorOut.Data.Output.Output( 1).Output = new( 'dataImage', { Image( :, :, 1), 'Lin_R', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 2).Output = new( 'dataImage', { Image( :, :, 2), 'Lin_G', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 3).Output = new( 'dataImage', { Image( :, :, 3), 'Lin_B', getTaskName( theAlgoChannelSeparatorOut)});
    elseif( isType( ImageObject, '_Log_'))
        theAlgoChannelSeparatorOut.Data.Output.Output( 1).Output = new( 'dataImage', { Image( :, :, 1), 'Log_R', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 2).Output = new( 'dataImage', { Image( :, :, 2), 'Log_G', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 3).Output = new( 'dataImage', { Image( :, :, 3), 'Log_B', getTaskName( theAlgoChannelSeparatorOut)});
    else
        theAlgoChannelSeparatorOut.Data.Output.Output( 1).Output = new( 'dataImage', { Image( :, :, 1), 'R', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 2).Output = new( 'dataImage', { Image( :, :, 2), 'G', getTaskName( theAlgoChannelSeparatorOut)});
        theAlgoChannelSeparatorOut.Data.Output.Output( 3).Output = new( 'dataImage', { Image( :, :, 3), 'B', getTaskName( theAlgoChannelSeparatorOut)});
    end
else
    if( isType( ImageObject, '_Lin_'))
        myType = 'Lin';
    elseif( isType( ImageObject, '_Log_'))
        myType = 'Log';
    else
        myType = '';
    end

    myNumChannels = size( Image, 3);
    for i=1:myNumChannels
        theAlgoChannelSeparatorOut.Data.Output.Output( i).Output = new( 'dataImage', { Image( :, :, i), myType, getTaskName( theAlgoChannelSeparatorOut)});
    end            
end




