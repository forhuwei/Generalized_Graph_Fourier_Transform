%----------------------------------------------------------
% Generalized Graph Transform for Compression of PWS Images
% Created by: Wei Hu
% Start Date: 2014/09/04
%----------------------------------------------------------

clear all;
clc;

imdir=dir('images\depth\*.png');
addpath('images\depth\');


for i=2:length(imdir) 
  
    fprintf('Testing image %d:',i);
    fprintf(imdir(i).name);
    fprintf('...\n');
    
    origDep = double(imread(imdir(i).name));
    origDep = origDep(:,:,1);
    [h, w] = size(origDep);
    bSize = 4; 
    bRow = floor(h/bSize);    
    bCol = floor(w/bSize);  
    
    [BW, weakEdge, T] = edge_double_grid_alternate_tree(origDep,0,1);
    
    mgPos = zeros(1,10);
    mgNeg = zeros(1,10);
    mgPos(1) = 4;
    mgNeg(1) = -4;
    
    
    for iter = 1:10
        iter

    cluster1 = zeros(1,5);
    cluster2 = zeros(1,5);
    cluster3 = zeros(1,5);
    k1 = 1; k2=1; k3=1;

    for Bi = 1:h
        for Bj = 1:bCol
            


          %% read image and edges in a row block
%                 ind_row = (bSize*(Bi-1)+1) : bSize*Bi;  
            ind_row_2 = 2*Bi-1:2*Bi; 
            ind_col = (bSize*(Bj-1)+1) : bSize*Bj;  
            ind_col_2 = 2*min(ind_col)-1:2*max(ind_col);
            bDep = origDep(Bi,ind_col);
            bEdge = BW(ind_row_2,ind_col_2);   % 8-connected
            bEdge(2:2:end,2:2:end) = 0;   
            bEdge(:,end) = 0; 
            bEdge(end,:) = 0;
            
            if Bj == 1 || sum(bEdge(:)) ~= 0 
                continue;
            else
                
                x0 = origDep(Bi,bSize*(Bj-1));
                
                if abs(x0-bDep(1)) > T
                    continue;
                end
                xBar = mean(bDep);
                
                err_cluster1 = (xBar-x0)^2; 
                err_cluster2 = (xBar-(x0+mgPos(iter)))^2; 
                err_cluster3 = (xBar-(x0+mgNeg(iter)))^2; 
                
%                 [min, ind] = min([err_cluster1,err_cluster2,err_cluster3]);
                if err_cluster1 <= err_cluster2 && err_cluster1 <= err_cluster3
                    cluster1(k1,:) = [x0 bDep];
                    k1 = k1+1;
                elseif err_cluster2 <= err_cluster1 && err_cluster2 <= err_cluster3
                    cluster2(k2,:) = [x0 bDep];
                    k2 = k2+1;
                else
                    cluster3(k3,:) = [x0 bDep];
                    k3 = k3+1;
                end
                
            end

        end
    end
    
    for k = 1:length(cluster2)
        mgPos(iter+1) = mgPos(iter+1) + (mean(cluster2(k,2:5))-cluster2(k,1));
    end
    mgPos(iter+1) = mgPos(iter+1)/length(cluster2)
    
    for k = 1:length(cluster3)
        mgNeg(iter+1) = mgNeg(iter+1) + (mean(cluster3(k,2:5))-cluster3(k,1));
    end
    mgNeg(iter+1) = mgNeg(iter+1)/length(cluster3)
    
    if mgPos(iter+1) == mgPos(iter) && mgNeg(iter+1) == mgNeg(iter)
        break;
    end
    end
    
end






