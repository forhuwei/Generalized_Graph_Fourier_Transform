function [ predictor, class, A, sign ] = prediction3(recDep,BW_big,weakEdge,Bi,Bj,bSize,w,m_g)
% remove m_g = 5

predictor = zeros(bSize);
sign = 0;

if Bi == 1 && Bj == 1
    A = zeros(bSize^2,bSize^2);
    class = 1;
    return;
end

% find available neighboring pixels
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
bDep_orig = recDep(ind_row,ind_col);

nRow = length(ind_row);
nCol = length(ind_col);
ind_row_2 = 2*min(ind_row)-1:2*max(ind_row); 
ind_col_2 = 2*min(ind_col)-1:2*max(ind_col); 
bEdge = BW_big(ind_row_2,ind_col_2);
bWeakEdge = weakEdge(ind_row_2,ind_col_2);

if sum(bEdge(:)) ~= 0
    class = 3;   % class 3: zero correlation
    A = AdjMat(bEdge,0);
elseif sum(bWeakEdge(:)) ~= 0
    class = 2;   % class 3: zero correlation
    A = AdjMat(bWeakEdge,w);
%   [ NcutDiscrete ] = Ncut(bDep);
%   if length(unique(NcutDiscrete(:,1))) == 2
%       class = 2;  % class 2: weak correlation
%       [A,weakEdge] = Cut2AdjMat(NcutDiscrete(:,1),w,nRow,nCol);
%       weakEdge(2:2:end,2:2:end) = 0;   
%       weakEdge(:,end) = 0; 
%       weakEdge(end,:) = 0;
%       sumWeakEdge = sum(weakEdge(:));
else
      class = 1;  % class 1: strong correlation
      A = AdjMat(bEdge,0);
  
end

bDep(indX,indY) = 300;
if class ~= 2
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
end

if class == 2
    for i = indX(1):indX(end)
        for j = indY(1):indY(end)       
            A1 = A;
            ind1 = find(A(nRow*(j-1)+i,:)==1, 1); 
            ind2 = find(A(nRow*(j-1)+i,:)==w, 1); 
            if ~isempty(ind1) || ~isempty(ind2)
                
                    ikeep1 = find(bDep(ind1)~=300);
                    ikeep2 = find(bDep(ind2)~=300);
                    bDep(i,j) = 0;
                    if ~isempty(ikeep1) 
                        neighbors1 = ind1(ikeep1);
                        len1 = length(neighbors1);
                        
                        bDep(i,j) = bDep(i,j)+sum(bDep(neighbors1(1:len1)))./len1;
                       
                        continue;
                    end
                    if ~isempty(ikeep2) 
                        neighbors2 = ind2(ikeep2);
                        len2 = length(neighbors2);
                        for k=1:len2
                            if bDep(neighbors2(k)) > bDep_orig(i,j)
                                bDep(i,j) = bDep(i,j)+(bDep(neighbors2(k))-5)./len2;
                                sign = -1;
                            else
                                bDep(i,j) = bDep(i,j)+(bDep(neighbors2(k))+7)./len2;
                                sign = 1;
                            end
                        end
                       
%                         break;
                    end
                
            end

        end
    end
end

predictor = bDep(indX,indY);
predictor(predictor==300) = 0;  % or set as known pixel value
predictor = round(predictor);
    
% ind_row_2 = 2*min(ind_row)-1:2*max(ind_row); 
% ind_col_2 = 2*min(ind_col)-1:2*max(ind_col); 
% bEdge = BW_big(ind_row_2,ind_col_2);


end

