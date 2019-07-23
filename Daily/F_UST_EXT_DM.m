function [ UST_EXT, KH_EXT ] = F_UST_EXT_DM(H,zb)
%Calculate Ustar from H
rho = 1.18;
kappa = 0.4;
cp = 1000;
T0 = 300; % temperature
g = 9.8;
beta = 4.7;
gamma2 = 9;
gamma1 = 15;
alpha = 1;
D1 = (2*beta*kappa*g/rho/cp/T0)^(1/3);
D2 = (gamma2*kappa*g/2/rho/cp/T0)^(1/3);
D0 = (D1+D2)*0.5;

Ck1 = 2/(1+2*alpha);
Ck2 = sqrt(3)/alpha;
Ck0 = (Ck1+Ck2)*0.5;

UST_EXT = D0.*(abs(H).*zb).^(1./3);
KH_EXT = Ck0.*kappa.*zb.*UST_EXT;

end

