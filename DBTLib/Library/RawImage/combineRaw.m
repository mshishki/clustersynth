function [ theBayerRaw] = combineRaw( theC11, theC12, theC21, theC22)
% Kombiniert die 4 Farbauszüge theC11, theC12, theC21, theC22 gemäß Ihren 
% Indizes zu einem Bayer-Rohbild theBayerRaw.

theBayerRaw = zeros( size( theC11, 1)+size( theC21, 1), ...
					size( theC11, 2)+size( theC12, 2), 'single');
theBayerRaw( 1:2:end, 1:2:end) = theC11;
theBayerRaw( 2:2:end, 1:2:end) = theC21;
theBayerRaw( 1:2:end, 2:2:end) = theC12;
theBayerRaw( 2:2:end, 2:2:end) = theC22;
