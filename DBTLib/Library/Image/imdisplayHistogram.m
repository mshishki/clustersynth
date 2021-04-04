function theFigureHandle = imdisplayHistogram( theImage, theWindowTitle, theRange)

% Variable Argumente
myWindowTitleBase = [];
if( nargin == 2)
    myWindowTitleBase = theWindowTitle;
end

for c=1:size( theImage, 3)
	if( isempty( myWindowTitleBase))
		myWindowTitleBase = [ 'Histogram image ', inputname( 1)];
	end
	if( size( theImage, 3) > 1) %mehr als 2 Kanäle
		myWindowTitle = [ myWindowTitleBase, ', channel ', num2str( c)];
	else
		myWindowTitle = myWindowTitleBase;
	end
	
	% Fenster öffnen
% 	myScreenSize = get(0,'ScreenSize');
% 
% 	if( isempty( myWindowTitle))
% 		theFigureHandle = figure('Position',[1 1 myScreenSize(3) myScreenSize(4)]);
% 	else
% 		% WindowTitle ist da
% 		theFigureHandle = figure('Position',[1 1 myScreenSize(3) myScreenSize(4)], 'Name', myWindowTitle, 'NumberTitle', 'off');
% 	end

	if( isempty( myWindowTitle))
		theFigureHandle = figure();
	else
		% WindowTitle ist da
		theFigureHandle = figure('Name', myWindowTitle, 'NumberTitle', 'off');
	end

	%Histogramm über 100 Intervalle bilden:
	[counts,x] = imhist( theImage( :, :, c), 1000);
	%Anzeige:
	h = stem(x,counts, '-');
	set(h,'Marker','none')
%	truesize;
end


