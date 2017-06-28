function [M] = HyGh2( X, sigma,k )
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
t = pos2(2:k);
% H(i,t)=1;
% H(t,i)=1;
 H(i,t)=pos1(2:k);
end
H_temp=[];
for i =1:size(dist,1)
    k = H(:,i);
    if ~sum(k)==0
        H_temp=[H_temp k];
    end
end
H=H_temp';
% A = Hyper(H);
W=ones(size(H,1),1);
M=get_Zhou_Laplacian(H, W);

end

