function showCompareSpectralSensitivities( theSpectralSensitivities_Ref, theSpectralSensitivities, theWinTitle)

myLineWidth = 2;

if exist( 'theWinTitle')==0 || isempty(theWinTitle)==1
    figure();
else
    figure( 'Name', theWinTitle, 'NumberTitle', 'off');
end

hold on;

plot( 380:10:730, theSpectralSensitivities( :, 1), 'r', 'Linewidth', myLineWidth);
plot( 380:10:730, theSpectralSensitivities( :, 2), 'g', 'Linewidth', myLineWidth);
plot( 380:10:730, theSpectralSensitivities( :, 3), 'b', 'Linewidth', myLineWidth);

plot( 380:10:730, theSpectralSensitivities_Ref( :, 1), 'k', 'Linewidth', myLineWidth/2);
plot( 380:10:730, theSpectralSensitivities_Ref( :, 2), 'k', 'Linewidth', myLineWidth/2);
plot( 380:10:730, theSpectralSensitivities_Ref( :, 3), 'k', 'Linewidth', myLineWidth/2);

plot( 380:10:730, (theSpectralSensitivities( :, 1) - theSpectralSensitivities_Ref( :, 1)), ...
				'--r', 'Linewidth', myLineWidth);
plot( 380:10:730, (theSpectralSensitivities( :, 2) - theSpectralSensitivities_Ref( :, 2)), ...
				'--g', 'Linewidth', myLineWidth);
plot( 380:10:730, (theSpectralSensitivities( :, 3) - theSpectralSensitivities_Ref( :, 3)), ...
				'--b', 'Linewidth', myLineWidth);

legend( 'r', 'g', 'b', 'rRef', 'gRef', 'bRef', 'r-rRef', 'g-gRef', 'b-bRef');

hold off;
