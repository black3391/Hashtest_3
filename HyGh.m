function [A] = HyGh( X )
%HYGH Summary of this function goes here
%   Detailed explanation goes here
% H= [0 1 0 0 0 1;
%     1 0 1 0 1 1;
%     1 0 0 1 1 0; 
%     1 1 1 0 1 1; 
%     0 1 2 1 1 1; 
%     1 0 1 1 0 1];

Dvm = diag(sum(H,2))
Dem = diag(sum(H,1))
Dwm = eye(6);
A=Dvm^(-1/2)*H*Dwm*Dem^(-1)*H'*Dvm^(-1/2)

end

