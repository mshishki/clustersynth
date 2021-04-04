function MAE = meanabsolute(IMG, IMG_est)

    n = numel(IMG);
    d = imabsdiff(IMG, IMG_est);
    MAE = 1/n * sum(d(:));
    
end