imdir=dir('results\compare\*.png');
addpath('results\compare\');

for i = 1:length(imdir)
    img = double(imread(imdir(i).name));
    imgCrop = img(20:204,1:224);
    imshow(uint8(imgCrop));
    img2eps(uint8(imgCrop),imdir(i).name);
end

