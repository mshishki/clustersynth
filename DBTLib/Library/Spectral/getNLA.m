function theNLA = getNLA()
%Usage: theNLA = getNLA();

theNLA = importdata( 'NLA_5nm.txt');
theNLA = theNLA( 1:2:end, 2);
