function [ P ] = getPotential(A,Bi,Bj,bSize)

% compute the potential matrix P
% A = ones(size(A));  % for ADST
A(A>0) = 1;
P = zeros(bSize^2);
if Bi == 1 && Bj == 1
    return;
end
    
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

end