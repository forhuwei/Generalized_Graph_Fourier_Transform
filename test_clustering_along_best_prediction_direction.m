%----------------------------------------------------------
% Generalized Graph Transform for Compression of PWS Images
% Created by: Wei Hu
% Start Date: 2014/09/04
%----------------------------------------------------------

clear all;
clc;

imdir=dir('images\natural\*.png');
addpath('images\natural\');


for i=4:5
  
    fprintf('Testing image %d:',i);
    fprintf(imdir(i).name);
    fprintf('...\n');
    
    origDep = double(imread(imdir(i).name));
    origDep = origDep(:,:,1);
    [h, w] = size(origDep);
    bSize = 4; 
    bRow = floor(h/bSize);    
    bCol = floor(w/bSize);  
    
    x0 = zeros(1,1);
    xBar = zeros(1,1);
    x1 = zeros(1,1);
    k = 1;

    for Bi = 1:bRow
        for Bj = 1:bCol


          %% read image and edges in a row block
            ind_row = (bSize*(Bi-1)+1) : bSize*Bi;   
            ind_col = (bSize*(Bj-1)+1) : bSize*Bj;  
            bDep = origDep(ind_row,ind_col);
            
            % find boundary pixels
            if Bi == 1 && Bj == 1
                continue;
            end
            flag_hPredict = 1;
            flag_vPredict = 1;
            if Bi-1 > 0 && Bj-1 > 0 
                ind_row = (bSize*(Bi-1)+1-1) : bSize*Bi;   
                ind_col = (bSize*(Bj-1)+1-1) : bSize*Bj;  
                indX = (2:(bSize+1)); indY = (2:(bSize+1));
                bBlock = origDep(ind_row,ind_col);
                bdPixels_h = bBlock(1,2:5);
                bdPixels_v = bBlock(2:5,1);
                bdPixels(1:5) = bBlock(1,1:5);
                bdPixels(6:9) = bBlock(2:5,1);
            elseif Bi-1 > 0 
                ind_row = (bSize*(Bi-1)+1-1) : bSize*Bi;   
                ind_col = (bSize*(Bj-1)+1) : bSize*Bj;
                indX = (2:(bSize+1)); indY = (1:bSize);
                bBlock = origDep(ind_row,ind_col);
                bdPixels_h = bBlock(1,1:4);
                bdPixels = bdPixels_h;
                flag_hPredict = 0;
            else
                ind_row = (bSize*(Bi-1)+1) : bSize*Bi;   
                ind_col = (bSize*(Bj-1)+1-1) : bSize*Bj;
                indX = (1:bSize); indY = (2:(bSize+1));
                bBlock = origDep(ind_row,ind_col);
                bdPixels_v = bBlock(:,1);
                bdPixels = bdPixels_v;
                flag_vPredict = 0;
            end

            % choose the best prediction direction
            % DC prediction
            xBart = mean(bDep(:));
            x0Bar = mean(bdPixels);
            err1 = (xBart-x0Bar)^2;
            
            % vertical prediction
            if flag_vPredict == 0
                err2 = inf;
            else
                err2 = 0;
                for ind = 1:4
                    xBart = mean(bDep(:,ind));
                    x0t = bdPixels_h(ind);
                    err2 = err2 + (xBart-x0t)^2;
                end
            end
            
            % horizontal prediction
            if flag_hPredict == 0
                err3 = inf;
            else
                err3 = 0;
            
                for ind = 1:4
                    xBart = mean(bDep(ind,:));
                    x0t = bdPixels_v(ind);
                    err3 = err3 + (xBart-x0t)^2;
                end
            end
            
            if err1 <= err2 && err1 <= err3
                x0(k) = mean(bdPixels);
                xBar(k) = mean(bDep(:));
                x1(k) = bDep(1);
                k = k+1;
            elseif err2 <= err1 && err2 <= err3
                for ind = 1:4
                    x0(k) = bdPixels_h(ind);
                    xBar(k) = mean(bDep(:,ind));
                    x1(k) = bDep(1,ind);
                    k = k+1;
                end
            else
                for ind = 1:4
                    x0(k) = bdPixels_v(ind);
                    xBar(k) = mean(bDep(ind,:));
                    x1(k) = bDep(ind,1);
                    k = k+1;
                end
            end
            

        end
    end
%     ind1 = find(x0==0);
%     x0(ind1)=[];
%     xBar(ind1)=[]; 
%     ind2 = find(xBar==0);
%     xBar(ind2==0)=[];
%     x0(ind2==0)=[]; 
    set(gca,'Fontsize',20);

    tmp = x1-x0;
    tmp(abs(tmp)>50) = [];
    figure(i);    
    set(figure(i),'defaulttextinterpreter','latex');
    hist(tmp,40);
    xlabel('$x_1-x_0$');
    title('Barbara')
%     ylabel('\bar_x');

end






