function [ theC11, theC12, theC21, theC22] = separateRaw( theBayerRaw)
% Zerlegt das Bayer-Rohbild theBayerRaw in seine 4 Farbauszüge theC11,
% theC12, theC21, theC22. 

theC11 = theBayerRaw( 1:2:end, 1:2:end);
theC12 = theBayerRaw( 1:2:end, 2:2:end);
theC21 = theBayerRaw( 2:2:end, 1:2:end);
theC22 = theBayerRaw( 2:2:end, 2:2:end);
