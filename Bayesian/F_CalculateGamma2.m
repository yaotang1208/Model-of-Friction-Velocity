function [ gamma2 ] = F_CalculateGamma2( beta,z )
%F_Calculate Gamma2
%   Back Calculate Gamma2
rho = 1.18;
kappa = 0.4;
cp = 1000;
T0 = 300; % temperature
g = 9.8;
gamma2 = beta^3*2*rho*cp*T0/(kappa*g*z);

end

