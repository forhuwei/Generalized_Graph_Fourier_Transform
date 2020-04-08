function [ predictor, A1, Ac ] = prediction(recDep,BW_big,Bi,Bj,bSize,c)
% dull intra prediction 
% copy

predictor = zeros(bSize); 
if Bi==1 && Bj==1   
    A1 = zeros(bSize);
    Ac = zeros(bSize);
    return;
end

if Bi-1 > 0 && Bj-1 > 0 
    ind_row = (bSize*(Bi-1)+1-1) : bSize*Bi;   
    ind_col = (bSize*(Bj-1)+1-1) : bSize*Bj;  
    indX = (2:(bSize+1)); indY = (2:(bSize+1));
elseif Bi-1 > 0 
    ind_row = (bSize*(Bi-1)+1-1) : bSize*Bi;   
    ind_col = (bSize*(Bj-1)+1) : bSize*Bj;
    indX = (2:(bSize+1)); indY = (1:bSize);
else
    ind_row = (bSize*(Bi-1)+1) : bSize*Bi;   
    ind_col = (bSize*(Bj-1)+1-1) : bSize*Bj;
    indX = (1:bSize); indY = (2:(bSize+1));
end

bDep = recDep(ind_row,ind_col);
if Bi == 1  % copy horizontally
    for i = 1:bSize
        predictor(i,:) = bDep(i);
    end
elseif Bj == 1  % copy vertically
    for j = 1:bSize
        predictor(:,j) = bDep(1,j);
    end
else
    for j = 1:bSize
        predictor(:,j) = bDep(1,j+1);
    end
end
predictor = round(predictor);
    
ind_row_2 = 2*min(ind_row)-1:2*max(ind_row); 
ind_col_2 = 2*min(ind_col)-1:2*max(ind_col); 
bEdge = BW_big(ind_row_2,ind_col_2);
A1 = AdjMat(bEdge,0);
Ac = AdjMat(bEdge,c);

end

