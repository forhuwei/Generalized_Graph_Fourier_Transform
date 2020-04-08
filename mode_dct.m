function [ ssd,rate,recDep ] = mode_dct(residue,predictor,bDep,QStep)

bSize = 4;
% DCT
alpha = dct2(residue);
alpha_q = floor(abs(alpha)/QStep + 1.0/3).*sign(alpha);
recDep = round(idct2(QStep*alpha_q) + predictor);

% RD cost
ssd = sum(sum((recDep-bDep).^2));
alpha_zigzag = zigzag(alpha_q);
% rateTc = AriCod(alpha_zigzag);
% rate_dct = length(find(abs(alpha_zigzag)>=0.0001));
rateTc = bSize.^2*entropy_mine(alpha_zigzag);
rate = rateTc + 1;
% RDcost = ssd + lambda.*rate;

end