function [ WS ] = F_WS2(UST,H)
%Calculate Wind Speed
% Solve WS from Ustar 
C_S = 11.2468; %constant for stable condition
C_U = 5.2011; %constant for unstable condition

WS_S = C_S.* UST;
WS_U = C_U.* UST;

WS = WS_U;
WS(H<0) = WS_S(H<0);

end

