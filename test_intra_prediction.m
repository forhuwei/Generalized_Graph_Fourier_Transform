%----------------------------------------------------------
% Generalized Graph Transform for Compression of PWS Images
% Created by: Wei Hu
% Start Date: 2014/09/04
%----------------------------------------------------------

clear all;
clc;

imdir=dir('images\depth\*.png');
addpath('images\depth\');


for i=1:4
  
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

    
    x0 = zeros(1,1);
    xBar = zeros(1,1);
    k = 1;

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
                
                
                
                if abs(origDep(Bi,bSize*(Bj-1))-bDep(1)) > T
                    continue;
                end
            
                x0(k) = origDep(Bi,bSize*(Bj-1));
                xBar(k) = mean(bDep);
                k = k+1;
            end

        end
    end
%     ind1 = find(x0==0);
%     x0(ind1)=[];
%     xBar(ind1)=[]; 
%     ind2 = find(xBar==0);
%     xBar(ind2==0)=[];
%     x0(ind2==0)=[]; 
    figure(i);    
    plot(x0,xBar,'.');
    xlabel('x0');
    ylabel('\bar_x');

end






