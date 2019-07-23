function [ alpha_bar, beta_bar ] = F_BayesianLR( x, y,sigmax, sigmay,root )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
xbar = nanmean(x);
ybar = nanmean(y);
n = length(x);

Sxx = nanmean((x-xbar).^2);
Syy = nanmean((y-ybar).^2);
Sxy = nanmean((x-xbar).*(y-ybar));

beta_bar = fzero(@(x) x^3+Sxy/sigmax^2*x^2+((sigmay^2-Syy)/sigmax^2+sigmay^2*Sxx/sigmax^4)*x - sigmay^2*Sxy/sigmax^4, root);
alpha_bar = ybar - beta_bar*xbar;

end

