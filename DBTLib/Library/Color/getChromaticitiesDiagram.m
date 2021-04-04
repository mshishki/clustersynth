function theFigureHandle = getChromaticitiesDiagram( theAdditiveTitle)

	theFigureHandle = figure('Name',[ theAdditiveTitle], 'NumberTitle', 'off');
	axis([ 0,  1, 0, 1]);% x - y
	xlabel('x'); ylabel ('y');
