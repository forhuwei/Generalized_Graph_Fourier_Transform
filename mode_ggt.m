function [ssd, rate, Rec, alpha_q, V] = mode_ggt(residue,A,P,predictor,bDep,QStep)

bSize = 4;

% GGFT
% [ NcutDiscrete ] = Ncut(residue);
% A = Cut2AdjMat(NcutDiscrete(:,1),bSize,bSize);
D = diag(sum(A,2));  
L = D - A;

% if row == 5 && col == 5
%     ind = [1 2 3 4 5 6 11 16 21];
% elseif row == 4 && col == 4
%     ind = [];
% elseif row == 5 && col == 4
%     ind = [1 6 11 16];
% elseif row == 4 && col == 5
%     ind = [1 2 3 4];
% end
% L(ind,:) = [];
% L(:,ind) = [];

L = L + P;
[V, Lam] = eig(L);
alpha = V'*residue(:); % Spectral Transform
alpha_q = floor(abs(alpha)/QStep + 1.0/3).*sign(alpha);
% alpha_q = round(alpha/QStep);
recResidue = reshape(V*(QStep*alpha_q),bSize,bSize);
Rec = round(recResidue + predictor);

% RD cost
ssd = sum(sum((Rec-bDep).^2));
rateTc = AriCod(alpha_q);
% rateTr = 1.2*sum(bEdge(:));
rateTr = 0;  % the same for GFT and GGFT, omit for now
rate = rateTc + rateTr;

end
