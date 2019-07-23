function [UST_Stat1,UST_Stat2,UST_StatMEP]= F_PlotUST_DM2(UST_Hmep1,UST_Hobs1,UST_Hmep2,UST_Hobs2,UST_OBS,Hmep1,Hmep2,Hobs,WS,Day1,Day2)
%Calculate the daily mean of calculated fluxes. exclude the days with nan
%values.
%F_OBSH Ustar estimated from observed H 
%out put diurnal cycles

[RMSE_UST_Hobs1,NRMSE_UST_Hobs1,CC_UST_Hobs1] = F_Statistics(UST_Hobs1,UST_OBS);
[RMSE_UST_Hmep1,NRMSE_UST_Hmep1,CC_UST_Hmep1] = F_Statistics(UST_Hmep1,UST_OBS);
UST_Stat1 = [RMSE_UST_Hobs1,NRMSE_UST_Hobs1,CC_UST_Hobs1,RMSE_UST_Hmep1,NRMSE_UST_Hmep1,CC_UST_Hmep1];

[RMSE_UST_Hobs2,NRMSE_UST_Hobs2,CC_UST_Hobs2] = F_Statistics(UST_Hobs2,UST_OBS);
[RMSE_UST_Hmep2,NRMSE_UST_Hmep2,CC_UST_Hmep2] = F_Statistics(UST_Hmep2,UST_OBS);
UST_Stat2 = [RMSE_UST_Hobs2,NRMSE_UST_Hobs2,CC_UST_Hobs2,RMSE_UST_Hmep2,NRMSE_UST_Hmep2,CC_UST_Hmep2];

[RMSE_UST_HobsMEP,NRMSE_UST_HobsMEP,CC_UST_HobsMEP] = F_Statistics(UST_Hobs2,UST_Hobs1);
[RMSE_UST_HmepMEP,NRMSE_UST_HmepMEP,CC_UST_HmepMEP] = F_Statistics(UST_Hmep2,UST_Hmep1);
UST_StatMEP = [RMSE_UST_HobsMEP,NRMSE_UST_HobsMEP,CC_UST_HobsMEP,RMSE_UST_HmepMEP,NRMSE_UST_HmepMEP,CC_UST_HmepMEP];

X = (Day1+1):1:Day2;

figure(51);
subplot('position',[0.05 0.52 0.6 0.3]);
% subplot(3,1,1);
plot(X, Hobs,'--*b',X,Hmep1,':ro','LineWidth',1.5);
grid on;
ylabel('H (W m^{-2})');
legend('OBS','MEP1');
title('(a)','FontSize',11);

subplot('position',[0.7 0.52 0.3 0.3]);
% subplot(3,1,1);
scatter(Hobs, Hmep1,'LineWidth',1.5);grid on;box on;
xlabel('OBS H(W m^{-2})');
ylabel('MEP1 H(W m^{-2})');
hold on;
plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);hold off;
title('(b)','FontSize',11);
axis('square');

subplot('position',[0.05 0.10 0.6 0.3]);
plot(X,UST_OBS,'-k',X,UST_Hobs1,'--*b',X,UST_Hmep1,':or','LineWidth',1.5);grid on;
ylabel('u_* (m s^{-1})');
yyaxis right
plot(X, WS,'-.g','LineWidth',1.5);
ylabel('WS (m s^{-1})','Color','k')
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}','WS');
legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP1})','WS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
title('(c)','FontSize',11);

subplot('position',[0.7 0.10 0.3 0.3]);
scatter(UST_OBS, UST_Hobs1,'*b','LineWidth',1.5);hold on;
scatter(UST_OBS, UST_Hmep1,'or','LineWidth',1.5);grid on;box on;
plot(0:0.1:2,0:0.1:2,'-r','LineWidth',1.5);hold off;
% legend('EXT_{HOBS}','EXT_{HMEP}');
legend('Eq1(H_{OBS})','Eq1(H_{MEP1})');
xlabel('OBS u_*  (m s^{-1})');
ylabel('EST u_*  (m s^{-1})');
axis('square');
title('(d)','FontSize',11);

figure(52);
subplot('position',[0.05 0.52 0.6 0.3]);
% subplot(3,1,1);
plot(X, Hobs,'--*b',X,Hmep2,':ro','LineWidth',1.5);
grid on;
ylabel('H (W m^{-2})');
legend('OBS','MEP2');
title('(a)','FontSize',11);

subplot('position',[0.7 0.52 0.3 0.3]);
% subplot(3,1,1);
scatter(Hobs, Hmep2,'LineWidth',1.5);grid on;box on;
xlabel('OBS H(W m^{-2})');
ylabel('MEP2 H(W m^{-2})');
hold on;
plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);hold off;
title('(b)','FontSize',11);
axis('square');

subplot('position',[0.05 0.10 0.6 0.3]);
plot(X,UST_OBS,'-k',X,UST_Hobs1,'--*b',X,UST_Hmep2,':or','LineWidth',1.5);grid on;
ylabel('u_* (m s^{-1})');
yyaxis right
plot(X, WS,'-.g','LineWidth',1.5);
ylabel('WS (m s^{-1})','Color','k')
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}','WS');
legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP2})','WS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
title('(c)','FontSize',11);

subplot('position',[0.7 0.10 0.3 0.3]);
scatter(UST_OBS, UST_Hobs1,'*b','LineWidth',1.5);hold on;
scatter(UST_OBS, UST_Hmep2,'or','LineWidth',1.5);grid on;box on;
plot(0:0.1:2,0:0.1:2,'-r','LineWidth',1.5);hold off;
% legend('EXT_{HOBS}','EXT_{HMEP}');
legend('Eq1(H_{OBS})','Eq1(H_{MEP2})');
xlabel('OBS u_*  (m s^{-1})');
ylabel('EST u_*  (m s^{-1})');
axis('square');
title('(d)','FontSize',11);

figure(53);
subplot('position',[0.05 0.52 0.6 0.3]);
% subplot(3,1,1);
plot(X, Hmep1,'--*b',X,Hmep2,':ro','LineWidth',1.5);
grid on;
ylabel('H (W m^{-2})');
legend('MEP1','MEP2');
title('(a)','FontSize',11);

subplot('position',[0.7 0.52 0.3 0.3]);
% subplot(3,1,1);
scatter(Hmep1, Hmep2,'LineWidth',1.5);grid on;box on;
xlabel('MEP1 H(W m^{-2})');
ylabel('MEP2 H(W m^{-2})');
hold on;
plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);hold off;
title('(b)','FontSize',11);
axis('square');

subplot('position',[0.05 0.10 0.6 0.3]);
plot(X,UST_Hmep1,'--*b',X,UST_Hmep2,':or','LineWidth',1.5);grid on;
ylabel('u_* (m s^{-1})');
yyaxis right
plot(X, WS,'-.g','LineWidth',1.5);
ylabel('WS (m s^{-1})','Color','k')
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}','WS');
legend('Eq1(H_{MEP1})','Eq1(H_{MEP2})','WS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
title('(c)','FontSize',11);

subplot('position',[0.7 0.10 0.3 0.3]);
scatter(UST_Hmep1, UST_Hmep2,'*b','LineWidth',1.5);hold on;
% scatter(UST_OBS, UST_Hmep2,'or','LineWidth',1.5);
grid on;box on;
plot(0:0.1:2,0:0.1:2,'-r','LineWidth',1.5);hold off;
% legend('EXT_{HOBS}','EXT_{HMEP}');
xlabel('MEP1 u_*  (m s^{-1})');
ylabel('MEP2 u_*  (m s^{-1})');
axis('square');
title('(d)','FontSize',11);

end

