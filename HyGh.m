function [A] = HyGh( X, sigma,k )
%HYGH Summary of this function goes here
%   Detailed explanation goes here
% H= [0 1 0 0 0 1;
%     1 0 1 0 1 1;
%     1 0 0 1 1 0; 
%     1 1 1 0 1 1; 
%     0 1 2 1 1 1; 
%     1 0 1 1 0 1];
H = zeros(size(X,1),size(X,1));
dist= exp(-sqdist(X)/(2*sigma*sigma));
%dist = sqdist(X);
for i = 1:size(dist,2)
t = dist(:,i);
[pos1,pos2]=sort(t,'descend');
t = pos2(1:k);
H(t,i)=pos1(1:k);
end
Dvm = diag(sum(H,2));
Dem = diag(sum(H,1));
Dwm = eye(size(dist,2));
A=diag(diag(Dvm.^(-0.5)))*H*Dwm*Dem^(-1)*H'*diag(diag(Dvm.^(-1/2)));

end

