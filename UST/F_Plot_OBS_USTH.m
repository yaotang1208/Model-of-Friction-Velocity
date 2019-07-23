function [ H_avail,UST_avail, H_DC,UST_DC ] = F_Plot_OBS_USTH(T,H,WS,UST,UST_min,RecordsADay,DaysAYear)
%Plot CO2 Concentration with other variables.
M = H + WS + UST;
H_avail = H + M - M;
WS_avail = WS + M - M;
UST_avail = UST + M - M;
H13_avail = abs(H_avail).^(1./3);

H13_r = H13_avail(UST_avail > UST_min);
UST_r = UST_avail(UST_avail > UST_min); %H reliable, when Ustar is greater than a threshold. 

figure(20);%scatter plot
subplot(2,1,1);
scatter(UST_avail,H13_avail);box on;grid on;
axis('square');
xlabel('Ustar');
ylabel('|H|^{1/3}');
subplot(2,1,2);
scatter(log(UST_avail),log(abs(H_avail)));box on;grid on;axis('square');
xlabel('log(Ustar)');
ylabel('log(|H|)');

figure(21); % time series
h21_1=subplot(3,1,1);
plot(T,H13_avail);box on;grid on;
ylabel('|H|^{1/3}');
h21_2 = subplot(3,1,2);
plot(T,UST_avail);box on;grid on;
ylabel('Ustar');
h21_3 = subplot(3,1,3);
plot(T,WS_avail);box on;grid on;
ylabel('Wind Speed');
xlabel('Time');
linkaxes([h21_1,h21_2,h21_3] ,'x');

%calculate diurnal cycle then change time scales. 
UST_DC = F_DiurnalMean(UST,RecordsADay,DaysAYear);
H_DC = F_DiurnalMean(H,RecordsADay,DaysAYear);
WS_DC = F_DiurnalMean(WS,RecordsADay,DaysAYear);

X_DC = 1:1:RecordsADay;
figure(22); %mean diurnal cycle
h21_1=subplot(3,1,1);
plot(X_DC,H_DC);box on;grid on;
ylabel('H_{DC}');
h21_2 = subplot(3,1,2);
plot(X_DC,UST_DC);box on;grid on;
ylabel('UST_{DC}');
h21_3 = subplot(3,1,3);
plot(X_DC,WS_DC);box on;grid on;
ylabel('WS_{DC}');
xlabel('Hour of Day');
linkaxes([h21_1,h21_2,h21_3] ,'x');

figure(23);%scatter plot
subplot(2,1,1);
scatter(UST_DC,abs(H_DC).^(1./3));box on;grid on;axis('square');
xlabel('UST_{DC} ');
ylabel('|H|^{1/3}');
subplot(2,1,2);
scatter(log(UST_DC),log(abs(H_DC)));box on;grid on;axis('square');
xlabel('log(UST_{DC})');
ylabel('log(|H_{obs}|)');

UST_DC_r = UST_DC(UST_DC>UST_min);
H_DC_r = H_DC(UST_DC>UST_min);
figure(24);%scatter plot
subplot(2,1,1);
scatter(UST_DC_r,abs(H_DC_r).^(1./3));box on;grid on;axis('square');
xlabel('UST_{DC}(>USTmin)');
ylabel('|H_{obs}|^{1/3}');
subplot(2,1,2);
scatter(log(UST_DC_r),log(abs(H_DC_r)));box on;grid on;axis('square');
xlabel('log(Ustar_{DC})');
ylabel('log(|H|)');

figure(24);
subplot(1,2,1);
scatter(UST_avail,H13_avail);box on;grid on;
axis('square');
xlabel('UST');
ylabel('|H|^{1/3}');title('Hourly Data');

subplot(1,2,2);
scatter(UST_DC_r,abs(H_DC_r).^(1./3));box on;grid on;axis('square');
xlabel('UST');
ylabel('|H|^{1/3}');title('Diurnal Mean');

end