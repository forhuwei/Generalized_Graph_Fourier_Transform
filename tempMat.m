clear A;
dim = 10;
k = 5;

A(1,:) = [2 -1 zeros(1,dim-2)];
for i=1:dim-2,
    A(1+i,:) = [zeros(1,i-1) -1 2 -1 zeros(1,dim-i-2)];
end
A(dim,:) = [zeros(1,dim-2) -1 1];
[V1,D1] = eig(A);
figure(1);
hold off;
plot(V1(:,1),'r');
% hold on;
% plot(-V1(:,2),'b');
% hold on;
% plot(V(:,3),'g');
% legend('1st eig func', '2nd eig func');

w = 0.1;
A(1,:) = [2 -1 zeros(1,dim-2)];
for i=1:dim-2,
    A(1+i,:) = [zeros(1,i-1) -1 2 -1 zeros(1,dim-i-2)];
end
A(1+k,:) = [zeros(1,k-1) -1 1+w -w zeros(1,dim-k-2)];
A(2+k,:) = [zeros(1,k) -w 1+w -1 zeros(1,dim-k-3)];
A(dim,:) = [zeros(1,dim-2) -1 1];
% A = A + eye(dim);
[V2,D2] = eig(A);
figure(2);
hold off;
plot(-V2(:,1),'r');
% hold on;
% plot(V2(:,2),'b');
% legend('1st eig func', '2nd eig func');

V1_1 = V1(:,1)
V2_1 = -V2(:,1)
Vd_1 = V2_1 - V1_1
figure(3)
plot(Vd_1)
