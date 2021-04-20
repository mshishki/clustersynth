# clustersynth

A ~~naive~~ loose implementation of the texture synthesis algorithm, discussed in

==Efros, A. A., & Leung, T. K. (1999, September). Texture synthesis by non-parametric sampling. In *Proceedings of the seventh IEEE international conference on computer vision* (Vol. 2, pp. 1033-1038). IEEE.== .

This submission is a part of the final examination in Digitale Bildtechnik (DBT) at Cologne University of Applied Sciences and has been originally developed for the purpose of eliminating the 3x3 defect pixel clusters in a grayscale image. For each defect pixel, a direct 9x9 neighboorhood is compared with the entirety of the same-sized sliding neighborhoods contained within the larger 31x31 window and weighted based on the neighboorhoods' proximity. This is a simple case of inpainting used best with digitally generated images: in natural images, the pixel-based nature of the algorithm will make it prone to errors due to the rotation, translation and scaling invariance. Similarly, one may require setting other window size values to accommodate the size, which gets computationally expensive quick.

