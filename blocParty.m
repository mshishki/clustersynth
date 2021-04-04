function [roi, mask_roi, roiBig, mask_roiBig] = blocParty(pix, I_new, mask, roi_half, win_half)

criterium_new=[pix > roi_half, pix < size(I_new) - roi_half];

y_min = pix(1) - roi_half;
y_max = pix(1) + roi_half;
x_min = pix(2) - roi_half;
x_max = pix(2) + roi_half;
if ~all(criterium_new)
    roi = zeros(roi_half*2+1, roi_half*2+1);
    mask_roi = ones(roi_half*2+1, roi_half*2+1);
    cr = find(~criterium_new);
    [y_diff_min, x_diff_min, y_diff_max, x_diff_max] = deal(0);
    if ismember(1, cr) % y-Richtung: Region beginnt außerhalb des Bildes
        y_diff_min = 1 - y_min;
        y_min = max(1, y_min);
    end
    if ismember(2, cr) % x-Richtung ...
        x_diff_min = 1 - x_min;
        x_min = max(1, x_min);
    end
    if ismember(3, cr) % y-Richtung: Region endet außerhalb des Bildes
        y_diff_max = y_max - size(I_new, 1);
        y_max = min(size(I_new, 1), y_max);
    end
    if ismember(4, cr) % x-Richtung:
        x_diff_max = x_max - size(I_new, 2);
        x_max = min(size(I_new, 2), x_max);
    end
    

    roi(1+y_diff_min:end-y_diff_max, 1+x_diff_min:end-x_diff_max)= I_new(y_min:y_max, x_min:x_max);
    mask_roi(1+y_diff_min:end-y_diff_max, 1+x_diff_min:end-x_diff_max)= mask(y_min:y_max, x_min:x_max);
else 
    
    % wird bei Maskengenerierung sichergestellt
    roi = I_new(pix(1)-roi_half:pix(1)+roi_half, pix(2)-roi_half:pix(2)+roi_half);
    mask_roi = mask(pix(1)-roi_half:pix(1)+roi_half, pix(2)-roi_half:pix(2)+roi_half);

end




% Die Suchumgebung ist eine Formalität und muss lediglich größer als 9x9
% ROI sein (um später mehrere 9x9 sliding-Nachbarschaften bieten zu können)
criterium = [pix > win_half, pix < size(I_new) - win_half];

y_min = pix(1) - win_half;
y_max = pix(1) + win_half;

x_min = pix(2) - win_half;
x_max = pix(2) + win_half;

if ~all(criterium)
    cr = find(~criterium);
    if ismember(1, cr) % y-Richtung: Region beginnt außerhalb des Bildes
        y_min = max(1, y_min);
    end
    if ismember(2, cr) % x-Richtung ...
        x_min = max(1, x_min);
    end
    if ismember(3, cr) % y-Richtung: Region endet außerhalb des Bildes
        y_max = min(size(I_new, 1), y_max);
    end
    if ismember(4, cr) % x-Richtung:
        x_max = min(size(I_new, 2), x_max);
    end
end

% err = any([y_max-y_min x_max-x_min]<9);

roiBig = I_new(y_min:y_max, x_min:x_max);
mask_roiBig = mask(y_min:y_max, x_min:x_max);
end
