clear all;
clc;
dim = 50;

A(1,:) = [2 -1 zeros(1,dim-2)];
for i=1:dim-2,
    A(1+i,:) = [zeros(1,i-1) -1 2 -1 zeros(1,dim-i-2)];
end
A(dim,:) = [zeros(1,dim-2) -1 1];
[V1,D1] = eig(A);

m = 20;
w = 0.1;
A(1,:) = [1 -1 zeros(1,dim-2)];
for i=1:dim-2,
    A(1+i,:) = [zeros(1,i-1) -1 2 -1 zeros(1,dim-i-2)];
end
A(dim,:) = [zeros(1,dim-2) -1 1];
A(m,:) = [zeros(1,m-2) -1 1+w -w zeros(1,dim-m-1)];
A(m+1,:) = [zeros(1,m-1) -w 1+w -1 zeros(1,dim-m-2)];
[V2,D2] = eig(A);

A(1,:) = [2 -1 zeros(1,dim-2)];
for i=1:dim-2,
    A(1+i,:) = [zeros(1,i-1) -1 2 -1 zeros(1,dim-i-2)];
end
A(dim,:) = [zeros(1,dim-2) -1 1];
A(m,:) = [zeros(1,m-2) -1 1+w -w zeros(1,dim-m-1)];
A(m+1,:) = [zeros(1,m-1) -w 1+w -1 zeros(1,dim-m-2)];
[V3,D3] = eig(A);

% x(1:m) = 50*ones(1,m) + randn(1,m);
% x(m+1:dim) = 45*ones(1,dim-m) + randn(1,dim-m);
% r = x - x(1);
% Tr_DST = V3'*r';
% Tr_DCT = V2'*r';

figure(1);
plot(diag(D1),'r');
hold on;
plot(diag(D2),'b');
hold on;
plot(diag(D3),'g');
legend('DST', 'DCT','DST2');

figure(2);
subplot(1,3,1);
hold off;
plot(-V1(:,1),'r');
hold on;
plot(-V1(:,2),'b');
legend('1st eig func', '2nd eig func');

subplot(1,3,2);
hold off;
plot(V3(:,1),'r');
hold on;
plot(V3(:,2),'b');
% legend('1st eig func', '2nd eig func');

subplot(1,3,3);
hold off;
plot(V2(:,1),'r');
hold on;
plot(V2(:,2),'b');
% legend('1st eig func', '2nd eig func');
