function [ WS ] = F_WS( UST, H, z,z0 )
%Calculate Wind Speed
% Calculate wind speed using extreme solution assumeing UST is constant in
% terms of z. 
kappa = 0.4;
gamma2 = 9;
gamma1 = 15;

D_S = 3/2;
D_U = (gamma2/(gamma2+2*gamma1))^(1/4);
WS_S = D_S.*UST./kappa.*log(z./z0);
WS_U = D_U.*UST./kappa.*log(z./z0);

WS = WS_U;
WS(H<0) = WS_S(H<0);

end

