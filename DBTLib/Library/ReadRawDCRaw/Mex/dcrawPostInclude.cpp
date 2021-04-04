               

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    int argc = 0;
    char **argv;
    mwIndex i;
    int k, ncell;
    int j = 0;
    int result=0;

    
// Count inputs and check for char type
    
    for( k=0; k<nrhs; k++ )
    {
        if( mxIsCell( prhs[k] ) )
        {
            argc += ncell = mxGetNumberOfElements( prhs[k] );
            for( i=0; i<ncell; i++ )
                if( !mxIsChar( mxGetCell( prhs[k], i ) ) )
                    mexErrMsgTxt("Input cell element is not char");
        }
        else
        {
            argc++;
            if( !mxIsChar( prhs[k] ) )
                mexErrMsgTxt("Input argument is not char");
        }
    }

// Construct argv, (changed to argc + 1 to avoid memory error)
    
    argv = (char **) mxCalloc( argc + 1, sizeof(char *) );
    
    for( k=0; k<nrhs; k++ )
    {
        if( mxIsCell( prhs[k] ) )
        {
            ncell = mxGetNumberOfElements( prhs[k] );
            for( i=0; i<ncell; i++ )
                argv[j++] = mxArrayToString( mxGetCell( prhs[k], i ));
        }
        else
        {
            argv[j++] = mxArrayToString( prhs[k] );
        }
    }
    

// Call main with argc and argv
        
    result = main( argc, argv );
    if( nlhs == 1)
		plhs[0] = pMxImage;
	else 
		mexErrMsgTxt("Only single argument allowed.");


	// Free the dynamic memory, each individual string and the argv array

	for( j=argc-1; j>=0; j-- )
        mxFree( argv[j] );
    mxFree( argv );
  
	
	// Check the main return value
        
    if( result )
        mexErrMsgTxt("main returned non-zero value");

}



void CLASS transfer2Matlab( void)
{
	// Part for 8bit Output
	if (output_bps == 8){
		
		uchar lut[0x10000];

		int trim = 0;
		int row, col, i, c, val, total;
		float max, mul, scale[0x10000];
		ushort *rgb;
		uint8_T *pMxImageData;
		const int mxImageWidth = width;// - 2;*(trim-1);
		const int mxImageHeight = height;// - 2*trim;
		const int mxImageDims[] = {mxImageHeight, mxImageWidth, colors};
	    
		// Create mxArray for image data to be passed to MATLAB. 
		pMxImage = mxCreateNumericArray( 3, mxImageDims, mxUINT8_CLASS,mxREAL);
		pMxImageData = mxGetData( pMxImage);

		// prepare gamma lut
		gamma_lut ( lut);	    
	
		// Write data to mxArray.
		 for (c=0; c < colors; c++) {
			for (row=0; row < mxImageHeight; row++) {
				for (col=0; col < mxImageWidth; col++) {
					rgb = image[(trim+row)*mxImageWidth+(trim+col)];
					val = lut[ rgb[c]];
					if (val > 255) val=255;
					*( pMxImageData + (row + mxImageHeight*col + mxImageWidth*mxImageHeight*c)*
					sizeof(uint8_T) ) = val;
				}
			}
		}
	}
	
	// Part for 16bit Output
	if (output_bps == 16){
		int trim = 0;
		int rgb_max = maximum;
		int row, col, c, val;
		ushort *rgb;
		uint16_T *pMxImageData;
		const int mxImageWidth = width;// - 2*(trim-1);
		const int mxImageHeight = height;// - 2*trim;
		const int mxImageDims[] = {mxImageHeight, mxImageWidth, colors};
	    
		val = rgb_max * bright;
		if (val < 256)
			val = 256;
		if (val > 0xffff)
			val = 0xffff;
	    
	// Create uint16 mxArray for image data to be passed to MATLAB 
		pMxImage = mxCreateNumericArray( 3, mxImageDims, mxUINT16_CLASS, mxREAL);
		pMxImageData = mxGetData(pMxImage);
		
		//Write data to mxArray.
		for (c=0; c < colors; c++) {
			for (row=0; row < mxImageHeight; row++) {
				for (col=0; col < mxImageWidth; col++) {
					rgb = image[(trim+row)*mxImageWidth+(trim+col)];
					val = rgb[c] * bright;	//evtl. bright ausklammern
					if (val > 0xffff) val = 0xffff;
					*( pMxImageData + (row + mxImageHeight*col + mxImageWidth*mxImageHeight*c)*
					sizeof(uint8_T) ) = val;   // Original author's code had it assign as follows:  "... = htons(val);" 
				}
			}
		}
	}
}



//Original part of dcRaw Sourcecode, write ppm/Tiff Function
//{
//  struct tiff_hdr th;
//  uchar *ppm, lut[0x10000];
//  ushort *ppm2;
//  int c, row, col, soff, rstep, cstep;
//
//  iheight = height;
//  iwidth  = width;
//  if (flip & 4) SWAP(height,width);
//  ppm = (uchar *) calloc (width, colors*output_bps/8);
//  ppm2 = (ushort *) ppm;
//  merror (ppm, "write_ppm_tiff()");
//  if (output_tiff) {
//    tiff_head (&th, 1);
//    fwrite (&th, sizeof th, 1, ofp);
//    if (oprof)
//      fwrite (oprof, ntohl(oprof[0]), 1, ofp);
//  } else if (colors > 3)
//    fprintf (ofp,
//      "P7\nWIDTH %d\nHEIGHT %d\nDEPTH %d\nMAXVAL %d\nTUPLTYPE %s\nENDHDR\n",
//	width, height, colors, (1 << output_bps)-1, cdesc);
//  else
//    fprintf (ofp, "P%d\n%d %d\n%d\n",
//	colors/2+5, width, height, (1 << output_bps)-1);
//
//  if (output_bps == 8) gamma_lut (lut);
//  soff  = flip_index (0, 0);
//  cstep = flip_index (0, 1) - soff;
//  rstep = flip_index (1, 0) - flip_index (0, width);
//  for (row=0; row < height; row++, soff += rstep) {
//    for (col=0; col < width; col++, soff += cstep)
//      if (output_bps == 8)
//	   FORCC ppm [col*colors+c] = lut[image[soff][c]];
//      else FORCC ppm2[col*colors+c] =     image[soff][c];
//    if (output_bps == 16 && !output_tiff && htons(0x55aa) != 0x55aa)
//      swab (ppm2, ppm2, width*colors*2);
//    fwrite (ppm, colors*output_bps/8, width, ofp);
//  }
//  free (ppm);
//}
