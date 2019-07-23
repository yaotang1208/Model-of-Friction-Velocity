function [ A_DC] = F_DiurnalMean(A,RecordsADay,DaysAYear)
%Calculate the daily mean of calculated fluxes. exclude the days with nan
%values.
% Reshape the vector to a matrix
A_Day = reshape(A,[RecordsADay, DaysAYear]);

%mean of diurnal cycle
A_DC = nanmean(A_Day,2);
end

