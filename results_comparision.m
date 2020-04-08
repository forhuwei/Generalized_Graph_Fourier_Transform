%% Teddy
% GGT
PSNR_wGGT = [52.21	49.42	47.07	43.30 39.28 36.25];
Rate_wGGT = [31749  22939 18552 15123 12766 11650]/ (368*448);

% GT
PSNR_GT = [52.88 49.34 47.24 44.04 40.14 37.21];
Rate_GT = [36882 25142 20818 16265 13382 12063]/ (368*448);

% % HR-UGT
% RATE_HRUGT = [26952 20899 17797  13829 ] / (368*448);  % 15620  12516
% PSNR_HRUGT = [46.30 41.89 37.05  28.29 ];  % 32.57  22.39

figure(1)
set(gca,'Fontsize',15);
plot(Rate_wGGT,PSNR_wGGT,'-Dr',...
     Rate_GT,PSNR_GT,'-Sb',...
     'LineWidth',2);
grid on;
legend('GGFT','wGT');
xlabel('Bit per pixel (bpp)'); 
ylabel('PSNR(dB)');   
title('Teddy');