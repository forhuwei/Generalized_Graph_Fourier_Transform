function [ssd, rate, Rec, alpha_q, V] = mode_gt(residue,A,predictor,bDep,QStep)

bSize = 4;
% GT
% [ NcutDiscrete ] = Ncut(residue);
% A = Cut2AdjMat(NcutDiscrete(:,1),bSize,bSize);
D = diag(sum(A,2));  
L = D - A;
% A = AdjMat(bEdge);
% D = diag(sum(A,2));
% L = D - A;
[V, Lam] = eig(L);
alpha = V'*residue(:); % Spectral Transform
alpha_q = floor(abs(alpha)/QStep + 1.0/3).*sign(alpha);
recResidue = reshape(V*(QStep*alpha_q),bSize,bSize);
Rec = round(recResidue + predictor);

% RD cost
ssd = sum(sum((Rec-bDep).^2));
rateTc = AriCod(alpha_q);
% rateTr = 1.2*sum(bEdge(:));
rateTr = 0;
rate = rateTc + rateTr;

end
