function MSE  = meansquared(IMG, IMG_est)

    n = numel(IMG);
    MSE = 1/n * sum((IMG(:) - IMG_est(:)).^2);

    %% eventuell für andere Metriken nützlich
    %{
    indices = find(maskcopy==1);
    n = size(indices, 1); 

    MSE = 1/n * sum((I(indices) - I_new(indices)).^2);
    %}
end
