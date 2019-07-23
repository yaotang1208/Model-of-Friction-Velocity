function [ q ] = F_qs_theta( qa,qs,theta,theta0 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
q = qs;
M = find(theta<theta0);
q(M) = qa(M);


end

