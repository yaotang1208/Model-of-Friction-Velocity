function [ WS ] = F_WS1( H, z)
%Calculate Wind Speed
% Solve WS from H and z 
C_S = 0.5286; %constant for stable condition
C_U = 0.1914; %constant for unstable condition

WS_S = C_S.*(abs(H).*z).^(1./3);
WS_U = C_U.*(abs(H).*z).^(1./3);

WS = WS_U;
WS(H<0) = WS_S(H<0);

end

