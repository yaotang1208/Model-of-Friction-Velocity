function [RMSE_DC_OBSH, NRMSE_DC_OBSH, CC_DC_OBSH,...
    RMSE_DC_MEPH, NRMSE_DC_MEPH, CC_DC_MEPH,...
    RMSE_MMDC_OBSH, NRMSE_MMDC_OBSH, CC_MMDC_OBSH ,...
    RMSE_MMDC_MEPH, NRMSE_MMDC_MEPH, CC_MMDC_MEPH,H_Stat_OneYear]...
    = F_FluxMean_UST(F_HOD,F_OBSH,F_OBS,C_MEP,C_OBS,WS,RecordsADay,DaysAYear)
%Calculate the daily mean of calculated fluxes. exclude the days with nan
%values.
%F_OBSH Ustar estimated from observed H 
%out put diurnal cycles

RecordsAnHour = RecordsADay/24;

M1 = F_HOD + F_OBS+ F_OBSH;
F_HOD = F_HOD + M1 - M1;
F_OBS = F_OBS + M1 - M1;
F_OBSH = F_OBSH + M1 - M1;

M2 = C_OBS + C_MEP;
C_OBS = C_OBS + M2 - M2;
C_MEP = C_MEP + M2 - M2;

% Reshape the vector to a matrix
F_HOD_Day = reshape(F_HOD,[RecordsADay, DaysAYear]);
F_OBS_Day = reshape(F_OBS,[RecordsADay, DaysAYear]);
F_OBSH_Day = reshape(F_OBSH,[RecordsADay, DaysAYear]);
C_OBS_Day = reshape(C_OBS,[RecordsADay, DaysAYear]);
C_MEP_Day = reshape(C_MEP,[RecordsADay, DaysAYear]);
WS_Day = reshape(WS,[RecordsADay, DaysAYear]);

%Daily Mean
F_HOD_DM = nanmean(F_HOD_Day,1);
F_OBS_DM = nanmean(F_OBS_Day,1);
F_OBSH_DM = nanmean(F_OBSH_Day,1);
C_OBS_DM = nanmean(C_OBS_Day,1);
C_MEP_DM = nanmean(C_MEP_Day,1);

[RMSE_DM_MEP,NRMSE_DM_MEP,CC_DM_MEP] = F_Statistics(F_HOD_DM,F_OBS_DM );
[RMSE_DM_OBSH,NRMSE_DM_OBSH,CC_DM_OBSH] = F_Statistics(F_OBSH_DM, F_OBS_DM);


figure(51);
subplot(3,1,1);
plot(1:1:DaysAYear, C_MEP_DM,'-or',1:1:DaysAYear, C_OBS_DM,'-b');grid on;
legend('MEP','OBS');
ylabel('Daily Mean H (W m^{-2})');
subplot(3,1,2);
plot(1:1:DaysAYear,F_HOD_DM,'-or',1:1:DaysAYear,F_OBSH_DM,'-*b',1:1:DaysAYear,F_OBS_DM,'-k');grid on;
legend('EXT_{HMEP}','EXT_{HOBS}','OBS');
xlabel('DOY');
ylabel('Daily Mean UST (m/s)');
subplot(3,1,3);
scatter(F_OBS_DM, F_HOD_DM,'o','r');grid on;hold on
scatter(F_OBS_DM,F_OBSH_DM,'*','b');hold off;
legend('EXT_{HMEP}','EXT_{HOBS}');
xlabel('OBS Daily Mean UST (m/s)');
ylabel('EXT Daily Mean UST (m/s)');
axis('square');

%mean of diurnal cycle
F_HOD_DC = nanmean(F_HOD_Day,2);
F_OBS_DC = nanmean(F_OBS_Day,2);
F_OBSH_DC = nanmean(F_OBSH_Day,2);
C_OBS_DC = nanmean(C_OBS_Day,2);
C_MEP_DC = nanmean(C_MEP_Day,2);
WS_DC = nanmean(WS_Day,2);

[ RMSE_DC_MEPH, NRMSE_DC_MEPH, CC_DC_MEPH ] = F_Statistics( F_HOD_DC, F_OBS_DC );
[ RMSE_DC_OBSH, NRMSE_DC_OBSH, CC_DC_OBSH ] = F_Statistics( F_OBSH_DC, F_OBS_DC );

X_DC = (1:1:RecordsADay)./RecordsAnHour;

figure(52)
title('Monthly Diurnal Cycles')
subplot(3,1,1);
plot(X_DC, C_MEP_DC,'-or',X_DC, C_OBS_DC,'-*b');grid on;
legend('MEP','OBS');
ylabel('HMEP (W m^{-2})');
subplot(3,1,2);
plot(X_DC,F_HOD_DC,'-or',X_DC,F_OBSH_DC,'-*b',X_DC,F_OBS_DC,'-k');grid on;
legend('EXT_{HMEP}','EXT_{HOBS}','OBS');
ylabel('UST (m/s)');
subplot(3,1,3);
scatter(F_OBS_DC,F_HOD_DC,'o','r');grid on;
hold on
scatter(F_OBS_DC,F_OBSH_DC,'*','b');hold off;
legend('EXT_{HMEP}','EXT_{HOBS}');
xlabel('OBS UST (m/s)');
ylabel('EXT UST (m/s)');
axis('square');


%Monthly Mean
if DaysAYear > 365 % leap years
    DaysEachMonth = [31 29 31 30 31 30 31 31 30 31 30 31];
else
    DaysEachMonth = [31 28 31 30 31 30 31 31 30 31 30 31];
end

Month = 12;
F_HOD_MM = NaN(Month, 1);
F_OBS_MM = NaN(Month, 1);
F_OBSH_MM = NaN(Month, 1);
C_OBS_MM = NaN(Month, 1);
C_MEP_MM = NaN(Month, 1);

for i =1:Month
    FirstDay = sum(DaysEachMonth(1:(i-1)))+1;
    LastDay = sum(DaysEachMonth(1:i));
    F_HOD_MM(i) = nanmean(F_HOD_DM(FirstDay:LastDay));
    F_OBS_MM(i) = nanmean(F_OBS_DM(FirstDay:LastDay));
    F_OBSH_MM(i) = nanmean(F_OBS_DM(FirstDay:LastDay));
    C_OBS_MM(i) = nanmean(C_OBS_DM(FirstDay:LastDay));
    C_MEP_MM(i) = nanmean(C_MEP_DM(FirstDay:LastDay));
end

[ RMSE_MM_MEPH, NRMSE_MM_MEPH, CC_MM_MEPH ] = F_Statistics( F_HOD_MM, F_OBS_MM );
[ RMSE_MM_OBSH, NRMSE_MM_OBSH, CC_MM_OBSH ] = F_Statistics( F_OBSH_MM, F_OBS_MM );


figure(53);
title('monthly mean');
subplot(3,1,1);
plot(1:1:Month, C_OBS_MM,'-*b',1:1:Month, C_MEP_MM,'-ro');grid on;
legend('OBS','MEP');
ylabel('H (W m^{-2})');
subplot(3,1,2);
plot(1:1:Month,F_OBS_MM,'-k',1:1:Month,F_OBSH_MM,'-*b',1:1:Month,F_HOD_MM,'-or');grid on;
legend('OBS','EXT_{HOBS}','EXT_{HMEP}');
ylabel('UST (m/s)');
subplot(3,1,3);
scatter(F_OBS_MM, F_OBSH_MM,'*b');grid on;hold on;
scatter(F_OBS_MM, F_HOD_MM,'or');hold off;
legend('EXT_{HOBS}','EXT_{HMEP}');
xlabel('OBS UST (m/s)');
ylabel('EXT UST (m/s)');
axis('square');

%Monthly Mean of Diurnal Cycle

F_HOD_MMDC = NaN(RecordsADay, Month);
F_OBS_MMDC = NaN(RecordsADay, Month);
F_OBSH_MMDC = NaN(RecordsADay, Month);
C_OBS_MMDC = NaN(RecordsADay, Month);
C_MEP_MMDC = NaN(RecordsADay, Month);
WS_MMDC = NaN(RecordsADay, Month);

for i =1:Month
    FirstDay = sum(DaysEachMonth(1:(i-1)))+1;
    LastDay = sum(DaysEachMonth(1:i));
    F_HOD_MMDC(:,i) = nanmean(F_HOD_Day(:,FirstDay:LastDay),2);
    F_OBS_MMDC(:,i) = nanmean(F_OBS_Day(:,FirstDay:LastDay),2);
    F_OBSH_MMDC(:,i) = nanmean(F_OBSH_Day(:,FirstDay:LastDay),2);
    C_OBS_MMDC(:,i) = nanmean(C_OBS_Day(:,FirstDay:LastDay),2);
    C_MEP_MMDC(:,i) = nanmean(C_MEP_Day(:,FirstDay:LastDay),2);
    WS_MMDC(:,i) = nanmean(WS_Day(:,FirstDay:LastDay),2);
end

% monthly mean of diurnal cycle in a vector form
F_HOD_MMDC_V = reshape(F_HOD_MMDC, [RecordsADay*Month,1]); 
F_OBS_MMDC_V = reshape(F_OBS_MMDC, [RecordsADay*Month,1]);
F_OBSH_MMDC_V = reshape(F_OBSH_MMDC, [RecordsADay*Month,1]);
C_OBS_MMDC_V = reshape(C_OBS_MMDC, [RecordsADay*Month,1]);
C_MEP_MMDC_V = reshape(C_MEP_MMDC, [RecordsADay*Month,1]);
WS_MMDC_V = reshape(WS_MMDC, [RecordsADay*Month,1]);

X_MMDC = 1:RecordsADay*Month;

[ RMSE_MMDC_MEPH, NRMSE_MMDC_MEPH, CC_MMDC_MEPH ] = F_Statistics( F_HOD_MMDC_V, F_OBS_MMDC_V );
[ RMSE_MMDC_OBSH, NRMSE_MMDC_OBSH, CC_MMDC_OBSH ] = F_Statistics( F_OBSH_MMDC_V, F_OBS_MMDC_V );
[ RMSE_MMDC_H, NRMSE_MMDC_H, CC_MMDC_H ] = F_Statistics( C_MEP_MMDC_V, C_OBS_MMDC_V );
H_Stat_OneYear = [ RMSE_MMDC_H, NRMSE_MMDC_H, CC_MMDC_H ];

MonthName = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

figure(54);
subplot(3,1,1);
plot(X_MMDC, C_OBS_MMDC_V,'-*b',X_MMDC, C_MEP_MMDC_V,'-ro');grid on;
ylabel('HMEP (W m{-2})');
legend('OBS','MEP');

subplot(3,1,2);
plot(X_MMDC,F_OBS_MMDC_V,'-k',X_MMDC,F_OBS_MMDC_V,'-*b',X_MMDC,F_HOD_MMDC_V,'-or');grid on;
legend('OBS','EXT_{HOBS}','EXT_{HMEP}');
ylabel('UST (m/s)');

subplot(3,1,3);
scatter(F_OBS_MMDC_V, F_OBSH_MMDC_V,'*b');hold on;
scatter(F_OBS_MMDC_V, F_HOD_MMDC_V,'or');grid on;hold off;
legend('EXT_{HOBS}','EXT_{HMEP}');
xlabel('OBS UST (m/s)');
ylabel('EXT UST (m/s)');
axis('square');

figure(55);
subplot('position',[0.05 0.72 0.6 0.25]);
% subplot(3,1,1);
plot(X_MMDC, C_OBS_MMDC_V,'--*b',X_MMDC, C_MEP_MMDC_V,':ro','LineWidth',1.5);grid on;
ylabel('H (W m^{-2})');
legend('OBS','MEP');
xticks((RecordsADay/2):RecordsADay:(RecordsADay/2+RecordsADay*(Month-1)));
xlim([0 RecordsADay*Month]);
xticklabels(MonthName);
title('(a)','FontSize',11);

subplot('position',[0.7 0.72 0.25 0.25]);
% subplot(3,1,1);
scatter(C_OBS_MMDC_V, C_MEP_MMDC_V,'LineWidth',1.5);grid on;box on;
xlabel('OBS H(W m^{-2})');
ylabel('MEP H(W m^{-2})');
hold on;
plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);hold off;
title('(b)','FontSize',11);
axis('square');

subplot('position',[0.05 0.40 0.6 0.25]);
plot(X_MMDC,F_OBS_MMDC_V,'-k',X_MMDC,F_OBSH_MMDC_V,'--*b',X_MMDC,F_HOD_MMDC_V,':or','LineWidth',1.5);grid on;
ylabel('u_* (m s^{-1})');
yyaxis right
plot(X_MMDC, WS_MMDC_V,'-.g','LineWidth',1.5);
ylabel('WS (m s^{-1})','Color','k')
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}','WS');
legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP})','WS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
xticks((RecordsADay/2):RecordsADay:(RecordsADay/2+RecordsADay*(Month-1)));
xlim([0 RecordsADay*Month]);
xticklabels(MonthName);
xlabel('Month');
title('(c)','FontSize',11);

subplot('position',[0.7 0.40 0.25 0.25]);
scatter(F_OBS_MMDC_V, F_OBSH_MMDC_V,'*b','LineWidth',1.5);hold on;
scatter(F_OBS_MMDC_V, F_HOD_MMDC_V,'or','LineWidth',1.5);grid on;box on;
plot(0:0.1:2,0:0.1:2,'-r','LineWidth',1.5);hold off;
% legend('EXT_{HOBS}','EXT_{HMEP}');
legend('Eq1(H_{OBS})','Eq1(H_{MEP})');
xlabel('OBS u_*  (m s^{-1})');
ylabel('EST u_*  (m s^{-1})');
axis('square');
title('(d)','FontSize',11);

subplot('position',[0.05 0.07 0.6 0.25]);
plot(X_DC,F_OBS_DC,'-k',X_DC,F_OBSH_DC,'--*b',X_DC,F_HOD_DC,':or','LineWidth',1.5);grid on;
xticks(0:6:24);
xlim([0 24]);
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}');
ylabel('u_* (m s^{-1})');
xlabel('Hour of Day');
yyaxis right
plot(X_DC, WS_DC,'-.g','LineWidth',1.5);
ylabel('WS (m s^{-1})','Color','k');
xticks(0:6:24);
xlim([0 24]);
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}','WS');
legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP})','WS');
title('(e)','FontSize',11);

subplot('position',[0.7 0.07 0.25 0.25]);
scatter(F_OBS_DC,F_OBSH_DC,'*b','LineWidth',1.5);hold on;
scatter(F_OBS_DC,F_HOD_DC,'or','LineWidth',1.5);
plot(0:0.1:1,0:0.1:1,'-r','LineWidth',1.5);hold off;
xlabel('OBS u_* (m s^{-1})');
ylabel('EST u_* (m s^{-1})');
% legend('EXT_{HOBS}','EXT_{HMEP}');
legend('Eq1(H_{OBS})','Eq1(H_{MEP})');
grid on;box on;
axis('square');
title('(f)','FontSize',11);

end

