%% Teddy

% MR-GT
RATE_MRGT = [27649 16936 13457  9049 ];  % rate(Tc)  % 8015  5187
RateEdges = 0; % didn't + rate(starting points) 
RATE_MRGT = RATE_MRGT + RateEdges;
RATE_MRGT = RATE_MRGT / (368*448);
PSNR_MRGT = [52.81 49.49 47.24  43.57 ];   % 42.04 36.23

% MR-UGT
RATE_MRUGT = [30060  18668 14477 9624]; % 26947 17948 8050
RATE_MRUGT = RATE_MRUGT + 0;
RATE_MRUGT = RATE_MRUGT / (368*448);
PSNR_MRUGT = [52.81  49.47 47.50 44.16];  % 49.05 46.66 38.91

figure(1)
plot(RATE_MRGT,PSNR_MRGT,'-Dr',...
     RATE_MRUGT,PSNR_MRUGT,'-Sb','LineWidth',2);
grid on;
set(gca,'Fontsize',15);
legend('GGFT/GFT','GFT');
xlabel('Bit per pixel (bpp)'); 
ylabel('PSNR(dB)');   
title('Teddy');

%% Dude

% MR-GT
RATE_MRGT = [68844 49070 35796 24950 ];  % rate(Tc)  % 8015  5187
RateEdges = 0; % didn't + rate(starting points) 
RATE_MRGT = RATE_MRGT + RateEdges;
RATE_MRGT = RATE_MRGT / (800*480);
PSNR_MRGT = [54.38 47.41 46.10 45.57 ];   % 42.04 36.23

% MR-UGT
RATE_MRUGT = [75697 54469 39617 27671]; % 26947 17948 8050
RATE_MRUGT = RATE_MRUGT + 0;
RATE_MRUGT = RATE_MRUGT / (800*480);
PSNR_MRUGT = [54.38 47.30 46.21 45.93];  % 49.05 46.66 38.91

figure(2)
plot(RATE_MRGT,PSNR_MRGT,'-Dr',...
     RATE_MRUGT,PSNR_MRUGT,'-Sb','LineWidth',2);
grid on;
% set(gca,'Fontsize',15);
legend('GGFT/GFT','GFT');
xlabel('Bit per pixel (bpp)'); 
ylabel('PSNR(dB)');   
title('Dude');

%% Carphone

% MR-GT
RATE_MRGT = [34733 26098 19464  13277 ];  % rate(Tc)  % 8015  5187
RateEdges = 0; % didn't + rate(starting points) 
RATE_MRGT = RATE_MRGT + RateEdges;
RATE_MRGT = RATE_MRGT / (176*144);
PSNR_MRGT = [46.68 43.30 40.37  37.29];   % 42.04 36.23

% MR-UGT
RATE_MRUGT = [37051  28037 20872 14606]; % 26947 17948 8050
RATE_MRUGT = RATE_MRUGT + 0;
RATE_MRUGT = RATE_MRUGT / (176*144);
PSNR_MRUGT = [46.63  43.35 40.38 37.40];  % 49.05 46.66 38.91

figure(3)
plot(RATE_MRGT,PSNR_MRGT,'-Dr',...
     RATE_MRUGT,PSNR_MRUGT,'-Sb','LineWidth',2);
grid on;
set(gca,'Fontsize',15);
legend('GGFT/GFT','GFT');
xlabel('Bit per pixel (bpp)'); 
ylabel('PSNR(dB)');   
title('Carphone');