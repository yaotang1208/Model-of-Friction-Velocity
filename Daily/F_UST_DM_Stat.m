function [ UST_Hobs_DM,UST_Hobs_DM_E,UST_Hobs_DM_RE,...
    UST_Hmep_DM,UST_Hmep_DM_E,UST_Hmep_DM_RE,UST_OBS_DM] = F_UST_DM_Stat( UST_Hobs,UST_Hmep,UST_OBS )
%F_UST_DM_Stat Summary of this function goes here
%   Calculate the daily mean of UST and the errors of the calculations
UST_OBS_DM = nanmean(UST_OBS);
UST_Hobs_DM = nanmean(UST_Hobs);
UST_Hmep_DM = nanmean(UST_Hmep);

UST_Hobs_DM_E = abs(UST_Hobs_DM-UST_OBS_DM);
UST_Hmep_DM_E = abs(UST_Hmep_DM-UST_OBS_DM);

UST_Hobs_DM_RE = UST_Hobs_DM_E/UST_OBS_DM;
UST_Hmep_DM_RE = UST_Hmep_DM_E/UST_OBS_DM;
end

