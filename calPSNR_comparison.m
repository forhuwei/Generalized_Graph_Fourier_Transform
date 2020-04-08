I = imread('images/1_teddy.png');
I1 = imread('results\GT\1_teddy.png_QP16.png');
I2 = imread('results\GGT\1_teddy.png_QP16_wggt.png');

psnr1 = calPSNR(I,I1)
psnr2 = calPSNR(I,I2)