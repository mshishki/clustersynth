function theIllumination = getT( theColorTemperature)
%Usage: theIllumination = getT( theColorTemperature);

myLambda = 380:10:730;
myS = 1./( myLambda.^5 .* ( exp( 1.4388*10^-2 ./ myLambda / 10^-9 / theColorTemperature) - 1));
myLambda = 555;
myS550 = 1./( myLambda.^5 .* ( exp( 1.4388*10^-2 ./ myLambda / 10^-9 / theColorTemperature) - 1));

theIllumination = 100*(myS/myS550)';