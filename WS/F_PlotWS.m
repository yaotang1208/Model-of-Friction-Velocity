function [ output_args ] = F_PlotWS(WS_OBS,WS_OBSUST,WS_OBSH,WS_MEPH,RecordsADay,Days,Time)
%Plot Wind Speed
%Plot diurnal variation and mean diurnal cycle of wind speed 
RecordsAnHour = RecordsADay/24;

M = WS_OBS+WS_OBSH+WS_MEPH+WS_OBSUST; %make NaN the same.
WS_OBS = WS_OBS+M-M;
WS_OBSH = WS_OBSH+M-M;
WS_MEPH = WS_MEPH +M -M;
WS_OBSUST = WS_OBSUST+M-M;

%Reshape the vector to a matrix
WS_OBS_Day = reshape(WS_OBS,[RecordsADay, Days]);
WS_OBSH_Day = reshape(WS_OBSH,[RecordsADay, Days]);
WS_MEPH_Day = reshape(WS_MEPH,[RecordsADay, Days]);
WS_OBSUST_Day = reshape(WS_OBSUST,[RecordsADay, Days]);

%Mean diurnal cycles
WS_OBS_DC = nanmean(WS_OBS_Day,2);
WS_OBSH_DC = nanmean(WS_OBSH_Day,2);
WS_MEPH_DC = nanmean(WS_MEPH_Day,2);
WS_OBSUST_DC = nanmean(WS_OBSUST_Day,2);

X_DC = (1:1:RecordsADay)./RecordsAnHour;

figure(60);
subplot(3,1,1);
plot(Time,WS_OBS,Time,WS_OBSUST,'LineWidth',1.5);
legend('OBS','OBSUST');
xlabel('DOY');
ylabel('WS (m s^{-1})');
grid on;box on;

subplot(3,1,2);
plot(Time,WS_OBS,Time,WS_OBSH,'LineWidth',1.5);
legend('OBS','OBSH');
xlabel('DOY');
ylabel('WS (m s^{-1})');
grid on;box on;

subplot(3,1,3);
plot(Time,WS_OBS,Time,WS_MEPH,'LineWidth',1.5);
legend('OBS','MEPH');
xlabel('DOY');
ylabel('WS (m s^{-1})');
grid on;box on;

figure(61);
subplot(3,1,1);
scatter(WS_OBS,WS_OBSUST);
hold on;plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
xlabel('OBS WS (m s^{-1})');
ylabel('WS using OBSUST (m s^{-1})');
grid on;box on;
axis('square');

subplot(3,1,2);
scatter(WS_OBS,WS_OBSH);
hold on;plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
xlabel('OBS WS (m s^{-1})');
ylabel('WS using OBSH (m s^{-1})');
grid on;box on;
axis('square');

subplot(3,1,3);
scatter(WS_OBS,WS_MEPH);
hold on;plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
xlabel('OBS WS (m s^{-1})');
ylabel('WS using MEPH (m s^{-1})');
grid on;box on;
axis('square');

figure(62);
subplot(3,1,1);
plot(X_DC,WS_OBS_DC,X_DC,WS_OBSUST_DC,'LineWidth',1.5);
legend('OBS','OBSUST');
xlabel('Hour of Day');
ylabel('WS (m s^{-1})');
grid on;box on;

subplot(3,1,2);
plot(X_DC,WS_OBS_DC,X_DC,WS_OBSH_DC,'LineWidth',1.5);
legend('OBS','OBSH');
xlabel('Hour of Day');
ylabel('WS (m s^{-1})');
grid on;box on;

subplot(3,1,3);
plot(X_DC,WS_OBS_DC,X_DC,WS_MEPH_DC,'LineWidth',1.5);
legend('OBS','MEPH');
xlabel('Hour of Day');
ylabel('WS (m s^{-1})');
grid on;box on;

figure(63);
subplot(3,1,1);
scatter(WS_OBS_DC,WS_OBSUST_DC);
hold on;plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
xlabel('OBS WS (m s^{-1})');
ylabel('WS using OBSUST (m s^{-1})');
grid on;box on;
axis('square');

subplot(3,1,2);
scatter(WS_OBS_DC,WS_OBSH_DC);
hold on;plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
xlabel('OBS WS (m s^{-1})');
ylabel('WS using OBSH (m s^{-1})');
grid on;box on;
axis('square');

subplot(3,1,3);
scatter(WS_OBS_DC,WS_MEPH_DC);
hold on;plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
xlabel('OBS WS (m s^{-1})');
ylabel('WS using MEPH (m s^{-1})');
grid on;box on;
axis('square');


figure(64)
% h43_1 = subplot('position',[0.05 0.72 0.6 0.25]);
% % subplot(3,1,1);
% plot(Time, C_OBS,'--*b',Time, C_MEP,':ro','LineWidth',1.5);grid on;box on;
% ylabel('H (W m^{-2})');
% legend('OBS','MEP');
% yyaxis right
% plot(Time, PREC,'-.k','LineWidth',1.5);
% set(gca,'Ydir','reverse')
% ylabel('PREC (mm/30mins)','Color','k')
% legend('OBS','MEP','PREC');
% title('(a)','FontSize',11);

% subplot('position',[0.7 0.72 0.25 0.25]);
% % subplot(3,1,1);
% scatter(C_OBS, C_MEP,'ob','LineWidth',1.5);grid on;box on;
% xlabel('OBS H (W m^{-2})');
% ylabel('MEP H (W m^{-2})');
% hold on;
% plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);hold off;
% title('(b)','FontSize',11);
% axis('square');

h43_2 = subplot('position',[0.05 0.40 0.6 0.25]);
plot(Time,WS_OBS,'-k',Time,WS_OBSH,'--*b',Time,WS_MEPH,':or','LineWidth',1.5);grid on;box on;
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}');
% legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP})');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
xlabel('DOY');
ylabel('WS (m s^{-1})');
legend('OBS','OBSH','MEPH');
% title('(c)','FontSize',11);

subplot('position',[0.7 0.40 0.25 0.25]);
scatter(WS_OBS, WS_OBSH,'*b','LineWidth',1.5);hold on;
scatter(WS_OBS, WS_MEPH,'or','LineWidth',1.5);grid on;box on;
plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
legend('OBSH','MEPH');
xlabel('OBS WS  (m s^{-1})');
ylabel('MOD WS  (m s^{-1})');
axis('square');
% title('(d)','FontSize',11);

subplot('position',[0.05 0.07 0.6 0.25]);
plot(X_DC,WS_OBS_DC,'-k',X_DC,WS_OBSH_DC,'--*b',X_DC,WS_MEPH_DC,':or','LineWidth',1.5);grid on;box on;
xticks(0:6:24);
xlim([0 24]);
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}');
ylabel('WS (m s^{-1})');
xlabel('Hour of Day');
legend('OBS','OBSH','MEPH');
% title('(e)','FontSize',11);

subplot('position',[0.7 0.07 0.25 0.25]);
scatter(WS_OBS_DC,WS_OBSH_DC,'*b','LineWidth',1.5);hold on;
scatter(WS_OBS_DC,WS_MEPH_DC,'or','LineWidth',1.5);
plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
xlabel('OBS WS (m s^{-1})');
ylabel('EST WS (m s^{-1})');
% legend('EST_{HOBS}','EXT_{HMEP}');
legend('OBSH','MEPH');
grid on;box on;
axis('square');
% title('(f)','FontSize',11);

% linkaxes([h43_1,h43_2] ,'x');

figure(65)
% h43_1 = subplot('position',[0.05 0.72 0.6 0.25]);
% % subplot(3,1,1);
% plot(Time, C_OBS,'--*b',Time, C_MEP,':ro','LineWidth',1.5);grid on;box on;
% ylabel('H (W m^{-2})');
% legend('OBS','MEP');
% yyaxis right
% plot(Time, PREC,'-.k','LineWidth',1.5);
% set(gca,'Ydir','reverse')
% ylabel('PREC (mm/30mins)','Color','k')
% legend('OBS','MEP','PREC');
% title('(a)','FontSize',11);

% subplot('position',[0.7 0.72 0.25 0.25]);
% % subplot(3,1,1);
% scatter(C_OBS, C_MEP,'ob','LineWidth',1.5);grid on;box on;
% xlabel('OBS H (W m^{-2})');
% ylabel('MEP H (W m^{-2})');
% hold on;
% plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);hold off;
% title('(b)','FontSize',11);
% axis('square');

subplot('position',[0.05 0.55 0.6 0.35]);
plot(Time,WS_OBS,'-k',Time,WS_OBSH,'--*b',Time,WS_MEPH,':or','LineWidth',1.5);grid on;box on;
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}');
% legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP})');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
xlabel('DOY');
ylabel('WS (m s^{-1})');
legend('OBS','OBSH','MEPH');
% title('(c)','FontSize',11);

subplot('position',[0.7 0.55 0.35 0.35]);
scatter(WS_OBS, WS_OBSH,'*b','LineWidth',1.5);hold on;
scatter(WS_OBS, WS_MEPH,'or','LineWidth',1.5);grid on;box on;
plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
legend('OBSH','MEPH');
xlabel('OBS WS  (m s^{-1})');
ylabel('MOD WS  (m s^{-1})');
axis('square');
% title('(d)','FontSize',11);

subplot('position',[0.05 0.07 0.6 0.35]);
plot(X_DC,WS_OBS_DC,'-k',X_DC,WS_OBSH_DC,'--*b',X_DC,WS_MEPH_DC,':or','LineWidth',1.5);grid on;box on;
xticks(0:6:24);
xlim([0 24]);
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}');
ylabel('WS (m s^{-1})');
xlabel('Hour of Day');
legend('OBS','OBSH','MEPH');
% title('(e)','FontSize',11);

subplot('position',[0.7 0.07 0.35 0.35]);
scatter(WS_OBS_DC,WS_OBSH_DC,'*b','LineWidth',1.5);hold on;
scatter(WS_OBS_DC,WS_MEPH_DC,'or','LineWidth',1.5);
plot(0:0.1:10,0:0.1:10,'-r','LineWidth',1.5);hold off;
xlabel('OBS WS (m s^{-1})');
ylabel('EST WS (m s^{-1})');
% legend('EST_{HOBS}','EXT_{HMEP}');
legend('OBSH','MEPH');
grid on;box on;
axis('square');
% title('(f)','FontSize',11);

% linkaxes([h43_1,h43_2] ,'x');




end

