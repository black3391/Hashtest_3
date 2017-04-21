function [ x ] = func_C(a,b)
%FUNC_C Summary of this function goes here
%   Detailed explanation goes here
%    if a(:) ==0
%        x=b;
%    else
%        x=a;
%    end
k = zeros(1,size(a,2));
p=xor(k,a);
p=~p;
t=p.*b
x=t+a;
end

