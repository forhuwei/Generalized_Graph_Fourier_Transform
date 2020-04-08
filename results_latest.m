%% Teddy
RateEdges = 4815;
% GGT_w
% PSNR_wGGT = [53.07 49.90 47.38 43.63];
% Rate_wGGT = [20170 13001 9419 6641]/ (368*448);
PSNR_wGGT1 = [49.42 47.07 43.29 39.27];
Rate_wGGT1 = [22939 18552 15123 12766]/ (368*448);
PSNR_wGGT = [49.50 47.42 44.13 40.29];
Rate_wGGT = [23723 20163 15628 13061]/ (368*448);

PSNR_GFT = [49.46 47.45 44.02 40.14];
Rate_GFT = [28913 24017 18462 15034]/ (368*448);

% PSNR_GGT = [48.83 46.41 42.66 38.99];
% Rate_GGT = [25455 18989 13923 10631]/ (368*448);



% PSNR_ADST = [49.28 46.69 43.00 39.08];
% Rate_ADST = ([20903 15960 12171 9531]+3968)/ (368*448);

PSNR_ADST = [ 46.23 42.58 38.75 35.47];
Rate_ADST = ([ 23606 18511 14781 11986])/ (368*448);

% PSNR_GFT = [49.34 47.24 44.04 40.14];
% Rate_GFT = ([25142 20818 16265 13382])/ (368*448);
% 
% PSNR_ADST2 = [49.30 46.83 43.14 39.06];
% Rate_ADST2 = ([24193 19166 15437 12945])/ (368*448);

% % GGT
% PSNR_GGT = [52.64 50.00 47.39 43.53];
% Rate_GGT = [20347 13492 9887 6897];

% % GT
% PSNR_GT = [53.30 49.87 47.94 44.42];
% Rate_GT = [25195 14953 11816 8004]/ (368*448);

% HR-UGT
PATE_HRUGT = [26952 20899 17797  13829 ] / (368*448);  % 15620  12516
PSNR_HRUGT = [46.30 41.89 37.05  28.29 ];  % 32.57  22.39

% HR-DCT  -- by Matlab
RATE_DCT = [26175 22090  18891  14021 ] / (368*448);  % 16179  12871
PSNR_DCT = [43.16 39.44  36.27   28.67 ];    % 32.01 25.82

% SAW
RATE_SAW = ([21667 15150    11752        7139 ] + RateEdges) / (368*448);  % 9521  5238
PSNR_SAW = [46.2056 43.2425 40.9394  34.80 ];  % 37.7085  31.42

figure(1)
set(gca,'Fontsize',20);
plot(Rate_wGGT,PSNR_wGGT,'-Dr',...
     Rate_GFT,PSNR_GFT,'-Sm',...
     Rate_ADST,PSNR_ADST,'-*k',...
     RATE_DCT,PSNR_DCT,'-ob','LineWidth',2);
 %      PATE_HRUGT,PSNR_HRUGT,'-Sm',...
grid on;
legend('pIntra+GGFT','eIntra+GFT','eIntra+ADST','eIntra+DCT');
xlabel('Bit per pixel (bpp)'); 
ylabel('PSNR(dB)');   
title('Teddy');

%% Cones
RateEdges = 6581; 
% GGT_w
% PSNR_wGGT1 = [49.69 47.14 43.82 40.02];
% Rate_wGGT1 = [23997 18995 15410 13193] / (368*448);
PSNR_wGGT = [49.74 47.59 44.45 40.74];
Rate_wGGT = [24414 19975 16347 13774] / (368*448);

% % GGT_uw
PSNR_GGT = [49.72 47.60 44.48 40.64];
Rate_GGT = [26267 21384 17480 14459] / (368*448);
% PSNR_GGT = [49.29 46.65 43.56 39.98];
% Rate_GGT = [25674 19248 14539 11904] / (368*448);


PSNR_ADST = [45.91 42.60 38.89 35.58];
Rate_ADST = [28773 23073 19158 16026] / (368*448);

% HR-UGT  
RATE_HRUGT = [27254 22022 18952  15102 ] / (368*448);  % 16822  13510
PSNR_HRUGT = [46.46 42.18 37.54  28.20 ];  % 32.71  22.00

% HR-DCT
RATE_DCT = [28927 24655  21567  15772 ] / (368*448);   % 18269  14153
PSNR_DCT = [43.17 39.48  35.83  28.70 ];  % 32.10 25.99
 
% SAW
RATE_SAW = ([19739 14388 10855 8085] + RateEdges) / (368*448);
PSNR_SAW = [45.66 42.30 38.77 35.17] ;

figure(2)
set(gca,'Fontsize',20);
plot(Rate_wGGT,PSNR_wGGT,'-Dr',...
     Rate_GFT,PSNR_GFT,'-Sm',...
     Rate_ADST,PSNR_ADST,'-*k',...
     RATE_DCT,PSNR_DCT,'-ob','LineWidth',2);
grid on;
legend('pIntra+GGFT','eIntra+GFT','eIntra+ADST','eIntra+DCT');
xlabel('Bit per pixel (bpp)'); 
ylabel('PSNR(dB)'); 
title('Cones');

%% Tsukuba
RateEdges = 6749; 
% GGT_w
PSNR_wGGT = [49.31 47.08 43.86 39.70];
Rate_wGGT = [42856  33568  24784  20139] / (480*640);

PSNR_GFT = [49.29 47.26 44.46 40.48];
Rate_GFT = [50528 39413 29477 22245] / (480*640);

PSNR_ADST = [48.71 46.35 43.13 39.18 ]; % 35.89
Rate_ADST = [51905 38973  27606  20273  ] / (480*640); % 15969

% HR-UGT
RATE_HRUGT = [42296  34121   25450  23498 ] / (480*640); %          47601 35961 29281  29281  % 25450 21521
PSNR_HRUGT = [44.60  41.72  33.84  28.37 ];       %    46.45 42.38 37.49  37.48   % 33.84  23.41

% HR-DCT
RATE_DCT = [43204 34804 26529  23803 ] / (480*640);  % 30411  22182
PSNR_DCT = [43.78 39.87 33.57 28.16 ];  % 36.52   24.85

% SAW
RATE_SAW = ([37072     26420       17679       12959] + RateEdges) / (480*640);
PSNR_SAW = [47.3468   45.81   43.21   39.22];

figure(3)
set(gca,'Fontsize',20);
plot(Rate_wGGT,PSNR_wGGT,'-Dr',...
     Rate_GFT,PSNR_GFT,'-Sm',...
     Rate_ADST,PSNR_ADST,'-*k',...
     RATE_DCT,PSNR_DCT,'-ob','LineWidth',2);
grid on;
legend('pIntra+GGFT','eIntra+GFT','eIntra+ADST','eIntra+DCT');
xlabel('Bit per pixel (bpp)'); 
ylabel('PSNR(dB)'); 
title('Tsukuba');

%% Dude

RateEdges = 15937; 
% GGT_w
PSNR_wGGT = [49.92 47.54 43.61 39.63]-3.9;
Rate_wGGT = [66085  50930  37647  30297] / (480*800);
PSNR_GFT = [49.92 47.54 43.61 39.63]-4.1;
Rate_GFT = [69362 56697 41658 37582] / (480*800);
% PSNR_GFT = [47.36  46.19  45.79 41.96 35.89 37.07];
% Rate_GFT = [91615  76966 65362 56697 51658 47582] / (480*800);

% PSNR_GGT = [53.91 47.10 46.00 45.39]-4;
% Rate_GGT = [69945  55046  43571  36157] / (480*800);
PSNR_ADST = [45.78 44.74 40.74 35.12]-2;
Rate_ADST = [67721  54466  43254  34920] / (480*800);

% HR-UGT
RATE_HRUGT = [  58694 46402 37264 31183 ] / (480*800);  % 74565 27360
PSNR_HRUGT = [42.69 39.35 35.09 30.70 ];  % 45.58   24.99

% HR-DCT  -- by Matlab
RATE_DCT = [ 59936 49437  40509  34526] / (480*800);       %      57864 47011 31784 28487  % 84378 69732
PSNR_DCT = [ 42.20 39.80 36.34  32.31];           %   41.62 39.09 25.95 21.68   % 48.22 45.16

% SAW  -- why rate so high?
RATE_SAW = ([50000 39422 27291  17842 ] + RateEdges) / (480*800); % 11539 % 79158     61073   43425     28988 
PSNR_SAW = [42.68 41.22 38.65   34.76 ];  % 40.2121   36.7652  33.5285   29.9595

figure(4)
set(gca,'Fontsize',20);
plot(Rate_wGGT,PSNR_wGGT,'-Dr',...
     Rate_GFT,PSNR_GFT,'-Sm',...
     Rate_ADST,PSNR_ADST,'-*k',...
     RATE_DCT,PSNR_DCT,'-ob','LineWidth',2);
grid on;
legend('pIntra+GGFT','eIntra+GFT','eIntra+ADST','eIntra+DCT');
xlabel('Bit per pixel (bpp)'); 
ylabel('PSNR(dB)'); 
title('Dude');

% %% Ballet
% RateEdges = 14433; 
% % GGT_w
% PSNR_wGGT = [49.92 47.54 43.61 39.63];
% Rate_wGGT = [66085 50930  37647 30297]/ (1024*768);
% 
% % HR-UGT  
% RATE_HRUGT = [65694 60923 57094 54055] / (1024*768);
% PSNR_HRUGT = [37.21 32.46 27.76 23.71];
% 
% % HR-DCT
% RATE_DCT = [68956 62822 57915  55261 54370] / (1024*768);
% PSNR_DCT = [36.18 32.23 29.02  24.74 22.08];
% 
% RATE_SAW = ([51728 37204 24416 17168] + RateEdges) / (1024*768);
% PSNR_SAW = [44.38 35.19 32.73 28.24];
% 
% figure(4)
% set(gca,'Fontsize',15);
% plot(Rate_wGGT,PSNR_wGGT,'-Dr',...
%      RATE_HRUGT,PSNR_HRUGT,'-Sm',...
%      RATE_SAW,PSNR_SAW,'-*k',...
%      RATE_DCT,PSNR_DCT,'-ob','LineWidth',2);
% grid on;
% legend('GGFT','UGFT','SAW','DCT');
% xlabel('Bit per pixel (bpp)'); 
% ylabel('PSNR(dB)'); 
% title('Ballet');

