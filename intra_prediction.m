function [ predictor, P ] = intra_prediction(recDep,BW_big,Bi,Bj,bSize)
% edge-adaptive intra prediction 
% use PWC model

if Bi==1 && Bj==1
    predictor = zeros(bSize); 
    P = zeros(bSize^2);
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
bDep(indX,indY) = 300;
nRow = length(ind_row);
ind_row_2 = 2*min(ind_row)-1:2*max(ind_row); 
ind_col_2 = 2*min(ind_col)-1:2*max(ind_col); 
bEdge = BW_big(ind_row_2,ind_col_2);
A = AdjMat(bEdge,0);

% compute the potential matrix P
P = zeros(bSize^2);
if Bi-1 > 0 && Bj-1 > 0 
    P(1,1) = P(1,1) + A(7,6) + A(7,2);
    P(5,5) = P(5,5) + A(12,11);
    P(9,9) = P(9,9) + A(17,16);
    P(13,13) = P(13,13) + A(22,21);
    P(2,2) = P(2,2) + A(8,3);
    P(3,3) = P(3,3) + A(9,4);
    P(4,4) = P(4,4) + A(10,5);
elseif Bi-1 > 0 
    P(1,1) = P(1,1) + A(2,1);
    P(5,5) = P(5,5) + A(7,6);
    P(9,9) = P(9,9) + A(12,11);
    P(13,13) = P(13,13) + A(17,16);
else
    P(1,1) = P(1,1) + A(5,1);
    P(2,2) = P(2,2) + A(6,2);
    P(3,3) = P(3,3) + A(7,3);
    P(4,4) = P(4,4) + A(8,4);
end


for i = indX(1):indX(end)
    for j = indY(1):indY(end)       
        A1 = A;
        ind = find(A(nRow*(j-1)+i,:)~=0); 
        if ~isempty(ind)
            depth = 1;
            while(depth<=8)
                ikeep = find(bDep(ind)~=300);
                if ~isempty(ikeep)
                    neighbors = ind(ikeep);
                    len = length(neighbors);
                    bDep(i,j) = 0;
                    bDep(i,j) = bDep(i,j)+sum(bDep(neighbors(1:len)))./len;
                    break;
                else
                    A1 = A1*A;
                    depth = depth+1;
                    ind = find(A1(nRow*(j-1)+i,:)~=0); 
                end
            end
        end
        
    end
end

predictor = bDep(indX,indY);
predictor(predictor==300) = 0;
predictor = round(predictor);

end

