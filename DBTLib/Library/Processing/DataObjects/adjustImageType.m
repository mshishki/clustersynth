function theImageObjectAdjusted = adjustImageType( theImageObject, theImageTypeName)

theImageObjectAdjusted = theImageObject;

if( ~exist( 'theImageTypeName'))
    theImageObjectAdjusted = theImageObject;
    return;
end

switch getImObjClass( theImageObject)
    case {'uint8', 'uint16', 'double'}
        myFuncPtrBuildDisplay = getFuncPtr_BuildDisplayImage( theImageTypeName);
%         myFuncPtrBuildDisplay = getFuncPtrBuildDispIm_uint8( theImageTypeName);
%     case 'uint16'
%         myFuncPtrBuildDisplay = getFuncPtrBuildDispIm_uint16( theImageTypeName);
%     case 'double'
%         myFuncPtrBuildDisplay = getFuncPtrBuildDispIm_double( theImageTypeName);
    otherwise
        myFuncPtrBuildDisplay = 0;        
end

if( ~isnumeric( myFuncPtrBuildDisplay))
    %Nur wenn gültig eintragen:
    theImageObjectAdjusted.FuncPtr.buildDisplayImage = myFuncPtrBuildDisplay;
end
% if isType( theImageObject, 'Raw')
%     theImageObjectAdjusted.FuncPtr.buildDisplayImage = @buildDisplayImageRaw;
% elseif isType( theImageObject, 'Log_L')
%     theImageObjectAdjusted.FuncPtr.buildDisplayImage = @buildDisplayImageRaw;
% elseif isType( theImageObject, 'Log_a') || isType( theImageObject, 'Log_b') || isType( theImageObject, 'Log_ab') 
%     theImageObjectAdjusted.FuncPtr.buildDisplayImage = @buildDisplayImageRaw;
% end
    
% switch theImageTypeName
%     case 'Raw'
%         theImageObjectAdjusted.FuncPtr.buildDisplayImage = @buildDisplayImageRaw;
%     otherwise
% end

end
        

% function theBuildDisplayImageFuncPtr = getFuncPtrBuildDispIm_uint8( theImageTypeName)
% 
% theBuildDisplayImageFuncPtr = 0;
% 
% end
% 
% 
% 
% function theBuildDisplayImageFuncPtr = getFuncPtrBuildDispIm_uint16( theImageTypeName)
% 
% if isType( theImageObject, 'Raw')
%     theBuildDisplayImageFuncPtr = @buildDisplayImageRaw;
% else
%     theBuildDisplayImageFuncPtr = 0;
% end
% 
% end



function theBuildDisplayImageFuncPtr = getFuncPtr_BuildDisplayImage( theImageTypeName)

if isType( theImageTypeName, '_Raw_')
    theBuildDisplayImageFuncPtr = @buildDisplayImageRaw;
elseif isType( theImageTypeName, '_R_') || isType( theImageTypeName, '_G_') || ...
            isType( theImageTypeName, '_B_') || isType( theImageTypeName, '_RGB_') || ...
            isType( theImageTypeName, '_L_')
    theBuildDisplayImageFuncPtr = @buildDisplayImageRGB;

elseif isType( theImageTypeName, '_a_') || isType( theImageTypeName, '_b_') 
    theBuildDisplayImageFuncPtr = @buildDisplayImage_abSingle;
elseif isType( theImageTypeName, '_ab_')
    theBuildDisplayImageFuncPtr = @buildDisplayImage_ab;
elseif isType( theImageTypeName, '_Lab_')
    theBuildDisplayImageFuncPtr = @buildDisplayImageLab;
else
    theBuildDisplayImageFuncPtr = 0;
end

end


