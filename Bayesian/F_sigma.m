function [ sigma ] = F_sigma( H,UST,RecordsADay,DaysAYear)
%F_sigma Calculate sigmax and sigmay for u*=beta*H^(1/3)+alpha
%   sigmax is uncertainty of H^(1/3)
%   sigmay is uncertainty of Ustar
%   only calculate unstable conditions
UC_Ustar = 0.2; %relative uncertainty of Ustar
UC_H = 0.2; %uncertainty of H
UC_H13 = UC_H/3; %uncertainty of H13 is 1/3 of that of H.

UST_US = UST(H>0); %US means unstable
H_US = H(H>0);
H13_US = H_US.^(1./3);

UC_Ustar_SI = UC_Ustar.* UST_US; %SI means uncertainty in SI units 
UC_H13_SI = UC_H13.*H13_US;

sigmax = nanmean(UC_H13_SI);
sigmay = nanmean(UC_Ustar_SI);

sigmax_DC = sigmax ./ DaysAYear;
sigmay_DC = sigmay ./ DaysAYear;

sigmax_DM = sigmax ./ RecordsADay;
sigmay_DM = sigmay ./ RecordsADay;

sigma = [sigmax,sigmay,sigmax_DC,sigmay_DC,sigmax_DM,sigmay_DM];

end

