%----------------------------------------------------------
% Generalized Graph Transform for Compression of PWS Images
% Created by: Wei Hu
% Start Date: 2014/09/04
%----------------------------------------------------------

clear all;
clc;

imdir=dir('images\*.png');
addpath('images\');
Tr = 1;  % 1: GGT 
c = 1; % fractional edge weight
% m_g = 4;  % mean of gap
% c = 1; % fractional edge weight
m_g = 0;  % mean of gap
% Tr = 0;  % 0: GT
% Tr = 2;  % 2: GT / GGT
% mark_wggt = 0;
% indW = 0;
% ind = 1;


for i=4 
  
    fprintf('Compressing image %d:',i);
    fprintf(imdir(i).name);
    fprintf('...\n');
    
    origDep = double(imread(imdir(i).name));
    origDep = origDep(:,:,1);
    [h, w] = size(origDep);
    bSize = 4; 
    bRow = floor(h/bSize);    
    bCol = floor(w/bSize);  

    [BW, weakEdge, T] = edge_double_grid_alternate_tree(origDep,0,1);
    BW(2:2:end,2:2:end) = 0;
%     weakEdge(2:2:end,2:2:end) = 0;
%     figure(1);imshow(BW)
%     figure(2);imshow(weakEdge)
    weakEdge = zeros(h*2,w*2);
%     BW = zeros(h*2,w*2);
         
    for QP = 20
        
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

%                 bEdge = zeros(8,8);
%                 bWeakEdge = zeros(8,8);
              
              %% step 0. classification
              %               if sum(bEdge(:)) ~= 0
% %                   class = 3;   % class 3: zero correlation
%                   A = AdjMat(bEdge,0);
%               elseif sum(bWeakEdge(:)) ~= 0
% %                   class = 3;   % class 3: zero correlation
%                   A = AdjMat(bEdge,c);
%               else
% %                       class = 1;  % class 1: strong correlation
%                   A = AdjMat(bEdge,0);
%                   
%               end
                bEdge = zeros(8,8);
                A = AdjMat(bEdge,0);
                
              %% step 1. intra prediction
                [predictor, class, A_big,  sign] = prediction3(recDep,BW,weakEdge,Bi,Bj,bSize,c,m_g); 
                residue = bDep - predictor;
                P = getPotential(A_big,Bi,Bj,bSize);  % P: potential matrix
%                 Pc = getPotential(Ac,Bi,Bj,bSize);
                
                    if Tr == 1
                        [ssd_ggt, rate_ggt, Rec_ggt] = mode_ggt(residue,A,P,predictor,bDep,QStep);
%                         RDcost_ggt = ssd_ggt + lambda.*rate_ggt;
                        
                       
                            ssd = ssd_ggt;
                            rate = rate_ggt;  % +1: one bit to indicate which contour weight is used
                            
                            Rec = Rec_ggt;
%                             if sum(bEdge(:)) ~= 0 
%                                 indW(ind) = 1;
%                                 ind = ind + 1;
%                             end

                    elseif Tr == 0
                        [ssd, rate, Rec] = mode_gt(residue,A,predictor,bDep,QStep);
                    else
                        [ssd_ggt, rate_ggt, Rec_ggt, alpha_ggt, V_ggt] = mode_ggt(residue,P,predictor,bDep,QStep);
                        RDcost_ggt = ssd_ggt + lambda.*rate_ggt;
                        [ssd_gt, rate_gt, Rec_gt, alpha_gt, V_gt] = mode_gt(residue,predictor,bDep,QStep);
                        RDcost_gt = ssd_gt + lambda.*rate_gt;
                        if ssd_ggt < ssd_gt && rate_ggt < rate_gt
%                             residue
%                             reshape(V_ggt(:,1),4,4)
%                             reshape(V_gt(:,1),4,4)
                            mark = mark + 1;
                            ssd = ssd_ggt;
                            rate = rate_ggt;
                            Rec = Rec_ggt;
                        else
                            ssd = ssd_gt;
                            rate = rate_gt;
                            Rec = Rec_gt;
                        end
                    end
%                 end
               
                MSE = MSE + ssd;
                RATE_coeff = RATE_coeff + rate;
                recDep(ind_row,ind_col) = Rec;
            end
        end
        
        RATE_strongEdge = sum(BW(:));
        RATE = RATE_coeff  + RATE_strongEdge;
                                          
        MSE = MSE/(h*w);
        PSNR = 10*log10(255*255/MSE);
        if Tr == 1
            imwrite(uint8(recDep),['results\GGT\',imdir(i).name,'_QP',int2str(QP),'_ggt_adst.png']);
            fid=fopen('results\GGT\log_adst.txt','a+');
        end
        if Tr == 0
            imwrite(uint8(recDep),['results\GT\',imdir(i).name,'_QP',int2str(QP),'.png']);
            fid=fopen('results\GT\log.txt','a+');
        end
        if Tr == 2
            imwrite(uint8(recDep),['results\GGT\',imdir(i).name,'_QP',int2str(QP),'_modes.png']);
            fid=fopen('results\GGT\log_modes.txt','a+');
        end
        
        
        fprintf(fid,'%s\n\r',imdir(i).name);
        fprintf(fid,'QP = %d, PSNR = %f, Rate = %f\r\n',QP,PSNR,RATE);     
            
        
    end
    fprintf(fid,'==============================================================');
    fclose(fid);  
end






