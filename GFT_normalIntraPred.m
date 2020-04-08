%----------------------------------------------------------
% Generalized Graph Transform for Compression of PWS Images
% Created by: Wei Hu
% Start Date: 2014/09/04
%----------------------------------------------------------

clear all;
clc;

imdir=dir('images\depth\*.png');
addpath('images\depth\');
Tr = 1;  % 1: GGT 
c = 0.13; % fractional edge weight
% m_g = 4;  % mean of gap
% c = 1; % fractional edge weight
m_g = 6;  % mean of gap for Cones
% Tr = 0;  % 0: GT
% Tr = 2;  % 2: GT / GGT
% mark_wggt = 0;
% indW = 0;
% ind = 1;


for i=3:length(imdir) 
  
    fprintf('Compressing image %d:',i);
    fprintf(imdir(i).name);
    fprintf('...\n');
    
    origDep = double(imread(imdir(i).name));
    origDep = origDep(:,:,1);
    [h, w] = size(origDep);
    bSize = 4; 
    bRow = floor(h/bSize);    
    bCol = floor(w/bSize);  

    [BW, weakEdge, T] = edge_double_grid_alternate_tree(origDep,0,2);
    BW(2:2:end,2:2:end) = 0;
    weakEdge(2:2:end,2:2:end) = 0;
%     figure(1);imshow(BW)
%     figure(2);imshow(weakEdge)
         
    for QP = 28:4:40
        
        QStep = QStep_Compute(QP);
        lambda = 0.85*2^((QP-6)./3);
        MSE = 0; 
%         RATE_weakEdge = 0; 
        RATE_coeff = 0; 
        recDep = origDep;
        mSign = zeros(bRow,bCol);

        for Bi = 1:bRow
            if mod(Bi,10) == 0
                Bi
            end
            for Bj = 1:bCol

                if Bi == 10 && Bj == 94
                    check = 1;
                end

              %% read image and edges in a block
                ind_row = (bSize*(Bi-1)+1) : bSize*Bi;   
                ind_col = (bSize*(Bj-1)+1) : bSize*Bj;  
                bDep = origDep(ind_row,ind_col);

                ind_row_2 = 2*min(ind_row)-1:2*max(ind_row); 
                ind_col_2 = 2*min(ind_col)-1:2*max(ind_col); 
                bEdge = BW(ind_row_2,ind_col_2);   % 8-connected
                bEdge(2:2:end,2:2:end) = 0;   
                bEdge(:,end) = 0; 
                bEdge(end,:) = 0;
                bWeakEdge = weakEdge(ind_row_2,ind_col_2);   % 8-connected
                bWeakEdge(2:2:end,2:2:end) = 0;   
                bWeakEdge(:,end) = 0; 
                bWeakEdge(end,:) = 0;
              
              %% step 0. classification
              if sum(bEdge(:)) ~= 0
%                   class = 3;   % class 3: zero correlation
                  A = AdjMat(bEdge,0);
              elseif sum(bWeakEdge(:)) ~= 0
%                   class = 3;   % class 3: zero correlation
                  A = AdjMat(bWeakEdge,c);
              else
%                       class = 1;  % class 1: strong correlation
                  A = AdjMat(bEdge,0);
                  
              end
                
              %% step 1. intra prediction
              [ predictor, P ] = intra_prediction_simple(recDep,BW,Bi,Bj,bSize);
              residue = bDep - predictor;
              [ssd, rate, Rec] = mode_gt(residue,A,predictor,bDep,QStep);
    
              MSE = MSE + ssd;
              RATE_coeff = RATE_coeff + rate;
              recDep(ind_row,ind_col) = Rec;
            end
        end

        RATE_strongEdge = sum(BW(:));
        RATE_weakEdge = sum(weakEdge(:));
        RATE = RATE_coeff  + RATE_strongEdge + RATE_weakEdge;
                                  
        MSE = MSE/(h*w);
        PSNR = 10*log10(255*255/MSE);
        imwrite(uint8(recDep),['results\GFT+normalIntraPred\',imdir(i).name,'_QP',int2str(QP),'_gft.png']);
        fid=fopen('results\GGT\log_gft.txt','a+');
           
        fprintf(fid,'%s\n\r',imdir(i).name);
        fprintf(fid,'QP = %d, PSNR = %f, Rate = %f, Edges = %d\r\n',QP,PSNR,RATE,RATE_strongEdge);     
            
        
    end
    fprintf(fid,'==============================================================');
    fclose(fid);  
end






