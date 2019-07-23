function [RMSE_UST_MEPH, NRMSE_UST_MEPH, CC_UST_MEPH,...
    RMSE_UST_OBSH, NRMSE_UST_OBSH, CC_UST_OBSH,...
    RMSE_H_MEP, NRMSE_H_MEP, CC_H_MEP,...
    RMSE_DC_UST_MEPH, NRMSE_DC_UST_MEPH, CC_DC_UST_MEPH,...
    RMSE_DC_UST_OBSH, NRMSE_DC_UST_OBSH, CC_DC_UST_OBSH]...
    = F_DiurnalMean_UST(F_HOD,F_OBSH,F_OBS,C_MEP,C_OBS,WS,PREC,RecordsADay,Days,Time)
%Calculate the daily mean of calculated fluxes. exclude the days with nan
%values.
M1 = F_HOD+F_OBS+F_OBSH;
F_HOD = F_HOD+M1 - M1;%make nan at the same positions
F_OBS = F_OBS + M1 - M1;
F_OBSH = F_OBSH + M1 - M1;

M2 = C_MEP + C_OBS;
C_MEP = C_MEP + M2 - M2;
C_OBS = C_OBS + M2 - M2;

[RMSE_UST_MEPH, NRMSE_UST_MEPH, CC_UST_MEPH] = F_Statistics( F_HOD, F_OBS);
[RMSE_UST_OBSH, NRMSE_UST_OBSH, CC_UST_OBSH] = F_Statistics( F_OBSH, F_OBS);
[RMSE_H_MEP, NRMSE_H_MEP, CC_H_MEP] = F_Statistics( C_MEP, C_OBS);


RecordsAnHour = RecordsADay/24;
% Reshape the vector to a matrix
F_HOD_Day = reshape(F_HOD,[RecordsADay, Days]);
F_OBS_Day = reshape(F_OBS,[RecordsADay, Days]);
F_OBSH_Day = reshape(F_OBSH,[RecordsADay, Days]);
C_OBS_Day = reshape(C_OBS,[RecordsADay, Days]);
C_MEP_Day = reshape(C_MEP,[RecordsADay, Days]);
WS_Day = reshape(WS,[RecordsADay, Days]);

%Daily Mean
F_HOD_DM = nanmean(F_HOD_Day,1);
F_OBS_DM = nanmean(F_OBS_Day,1);
F_OBSH_DM = nanmean(F_OBSH_Day,1);
C_OBS_DM = nanmean(C_OBS_Day,1);
C_MEP_DM = nanmean(C_MEP_Day,1);
WS_DM = nanmean(WS_Day,1);

[RMSE_DM_UST_MEP, NRMSE_DM_UST_MEP, CC_DM_UST_MEP] = F_Statistics( F_HOD_DM, F_OBS_DM );
[RMSE_DM_UST_OBSH, NRMSE_DM_UST_OBSH, CC_DM_UST_OBSH] = F_Statistics( F_OBSH_DM, F_OBS_DM );
[RMSE_DM_H_MEP, NRMSE_DM_H_MEP, CC_DM_H_MEP] = F_Statistics( C_MEP_DM, C_OBS_DM );

figure(40);
subplot(3,1,1);
plot(1:1:Days, C_OBS_DM,'--b*',1:1:Days, C_MEP_DM,':ro');grid on;
legend('OBS','MEP');
ylabel('Daily Mean H (W m^{-2})');
subplot(3,1,2);
plot(1:1:Days,F_OBS_DM,'-k',1:1:Days,F_OBSH_DM,'--*b',1:1:Days,F_HOD_DM,':or');grid on;
legend('OBS','EXT_{obs}','EXT_{mep}');
xlabel('DOY');
ylabel('Daily Mean UST (m/s)');
subplot(3,1,3);
scatter(F_OBS_DM, F_OBSH_DM,'*b');hold on;
scatter(F_OBS_DM, F_HOD_DM,'ro');grid on;hold off;
legend('EXT_{obs}','EXT_{mep}');
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

[ RMSE_DC_UST_MEPH, NRMSE_DC_UST_MEPH, CC_DC_UST_MEPH ] = F_Statistics( F_HOD_DC, F_OBS_DC );
[ RMSE_DC_UST_OBSH, NRMSE_DC_UST_OBSH, CC_DC_UST_OBSH ] = F_Statistics( F_OBSH_DC, F_OBS_DC );
[ RMSE_DC_MEPH, NRMSE_DC_MEPH, CC_DC_MEPH ] = F_Statistics( C_MEP_DC, C_OBS_DC );

X_DC = (1:1:RecordsADay)./RecordsAnHour;

figure(42)
subplot(3,1,1);
plot(X_DC, C_OBS_DC,'--b*',X_DC, C_MEP_DC,':ro');grid on;
legend('OBS','MEP');
ylabel('Daily Cycle H (W m^{-2})');
subplot(3,1,2);
plot(X_DC,F_OBS_DC,'-k',X_DC,F_OBSH_DC,'--*b',X_DC,F_HOD_DC,':or');grid on;
legend('OBS','EXT_{obs}','EXT_{mep}');
xlabel('DOY');
ylabel('Daily Cycle UST (m/s)');
subplot(3,1,3);
scatter(F_OBS_DC, F_OBSH_DC,'*b');hold on;
scatter(F_OBS_DC, F_HOD_DC,'ro');grid on;hold off;
legend('EXT_{obs}','EXT_{mep}');
xlabel('OBS Daily Cycle UST (m/s)');
ylabel('EXT Daily Cycle UST (m/s)');
axis('square');

figure(43)
h43_1 = subplot('position',[0.05 0.72 0.6 0.25]);
% subplot(3,1,1);
plot(Time, C_OBS,'--*b',Time, C_MEP,':ro','LineWidth',1.5);grid on;box on;
ylabel('H (W m^{-2})');
legend('OBS','MEP');
yyaxis right
plot(Time, PREC,'-.k','LineWidth',1.5);
set(gca,'Ydir','reverse')
ylabel('PREC (mm/30mins)','Color','k')
legend('OBS','MEP','PREC');
title('(a)','FontSize',11);

subplot('position',[0.7 0.72 0.25 0.25]);
% subplot(3,1,1);
scatter(C_OBS, C_MEP,'ob','LineWidth',1.5);grid on;box on;
xlabel('OBS H (W m^{-2})');
ylabel('MEP H (W m^{-2})');
hold on;
plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);hold off;
title('(b)','FontSize',11);
axis('square');

h43_2 = subplot('position',[0.05 0.40 0.6 0.25]);
plot(Time,F_OBS,'-k',Time,F_OBSH,'--*b',Time,F_HOD,':or','LineWidth',1.5);grid on;box on;
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}');
% legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP})');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
xlabel('DOY');
ylabel('u_* (m s^{-1})');
yyaxis right
plot(Time, WS,'-.g','LineWidth',1.5);
% set(gca,'Ydir','reverse')
ylabel('WS (m s^{-1})','Color','k')
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}','WS');
legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP})','WS');
title('(c)','FontSize',11);

subplot('position',[0.7 0.40 0.25 0.25]);
scatter(F_OBS, F_OBSH,'*b','LineWidth',1.5);hold on;
scatter(F_OBS, F_HOD,'or','LineWidth',1.5);grid on;box on;
plot(0:0.1:2,0:0.1:2,'-r','LineWidth',1.5);hold off;
legend('Eq1(H_{OBS})','Eq1(H_{MEP})');
xlabel('OBS u_*  (m s^{-1})');
ylabel('EST u_*  (m s^{-1})');
axis('square');
title('(d)','FontSize',11);

subplot('position',[0.05 0.07 0.6 0.25]);
plot(X_DC,F_OBS_DC,'-k',X_DC,F_OBSH_DC,'--*b',X_DC,F_HOD_DC,':or','LineWidth',1.5);grid on;box on;
xticks(0:6:24);
xlim([0 24]);
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}');
ylabel('u_* (m s^{-1})');
xlabel('Hour of Day');
yyaxis right
plot(X_DC, WS_DC,'-.g','LineWidth',1.5);
xticks(0:6:24);
xlim([0 24]);
% set(gca,'Ydir','reverse')
ylabel('WS (m s^{-1})','Color','k')
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}','WS');
legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP})','WS');
title('(e)','FontSize',11);

subplot('position',[0.7 0.07 0.25 0.25]);
scatter(F_OBS_DC,F_OBSH_DC,'*b','LineWidth',1.5);hold on;
scatter(F_OBS_DC,F_HOD_DC,'or','LineWidth',1.5);
plot(0:0.1:1,0:0.1:1,'-r','LineWidth',1.5);hold off;
xlabel('OBS u_* (m s^{-1})');
ylabel('EST u_* (m s^{-1})');
% legend('EST_{HOBS}','EXT_{HMEP}');
legend('Eq1(H_{OBS})','Eq1(H_{MEP})');
grid on;box on;
axis('square');
title('(f)','FontSize',11);

linkaxes([h43_1,h43_2] ,'x');
end

