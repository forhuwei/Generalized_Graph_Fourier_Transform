function [ h ] = entropy_mine(x)

x = x(:);
Nbins = 20;

p = hist(x,Nbins)./length(x);
p = p(p > 0);

h = -sum(p.*log2(p));