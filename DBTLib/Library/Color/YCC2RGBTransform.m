function theRGB = YCC2RGBTransform( theYCC)
YCC2RGB = [ 4*16, 0, 5*16+10; 4*16, -(256-(14*16+10)), -(256-(13*16+3)); 4*16, 7*16+1, -(256-(255))]/64;

theRGB = imMatMul_Single( theYCC, YCC2RGB);
