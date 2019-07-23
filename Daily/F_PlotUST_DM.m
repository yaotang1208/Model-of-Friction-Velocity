function [UST_Stat]= F_PlotUST_DM(UST_Hmep,UST_Hobs,UST_OBS,Hmep,Hobs,WS,Day1,Day2)
%Calculate the daily mean of calculated fluxes. exclude the days with nan
%values.
%F_OBSH Ustar estimated from observed H 
%out put diurnal cycles

[RMSE_UST_Hobs,NRMSE_UST_Hobs,CC_UST_Hobs] = F_Statistics(UST_Hobs,UST_OBS);
[RMSE_UST_Hmep,NRMSE_UST_Hmep,CC_UST_Hmep] = F_Statistics(UST_Hmep,UST_OBS);

UST_Stat = [RMSE_UST_Hobs,NRMSE_UST_Hobs,CC_UST_Hobs,RMSE_UST_Hmep,NRMSE_UST_Hmep,CC_UST_Hmep];

X = (Day1+1):1:Day2;

figure(55);
subplot('position',[0.05 0.52 0.6 0.3]);
% subplot(3,1,1);
plot(X, Hobs,'--*b',X,Hmep,':ro','LineWidth',1.5);
grid on;
ylabel('H (W m^{-2})');
legend('OBS','MEP');
title('(a)','FontSize',11);

subplot('position',[0.7 0.52 0.3 0.3]);
% subplot(3,1,1);
scatter(Hobs, Hmep,'LineWidth',1.5);grid on;box on;
xlabel('OBS H(W m^{-2})');
ylabel('MEP H(W m^{-2})');
hold on;
plot(-200:1:600,-200:1:600,'-r','LineWidth',1.5);hold off;
title('(b)','FontSize',11);
axis('square');

subplot('position',[0.05 0.10 0.6 0.3]);
plot(X,UST_OBS,'-k',X,UST_Hobs,'--*b',X,UST_Hmep,':or','LineWidth',1.5);grid on;
ylabel('u_* (m s^{-1})');
yyaxis right
plot(X, WS,'-.g','LineWidth',1.5);
ylabel('WS (m s^{-1})','Color','k')
% legend('OBS','EXT_{HOBS}','EXT_{HMEP}','WS');
legend('OBS','Eq1(H_{OBS})','Eq1(H_{MEP})','WS');
% set(gca,'xtick',1:12,'xticklabel',MonthName)
title('(c)','FontSize',11);

subplot('position',[0.7 0.10 0.3 0.3]);
scatter(UST_OBS, UST_Hobs,'*b','LineWidth',1.5);hold on;
scatter(UST_OBS, UST_Hmep,'or','LineWidth',1.5);grid on;box on;
plot(0:0.1:2,0:0.1:2,'-r','LineWidth',1.5);hold off;
% legend('EXT_{HOBS}','EXT_{HMEP}');
legend('Eq1(H_{OBS})','Eq1(H_{MEP})');
xlabel('OBS u_*  (m s^{-1})');
ylabel('EST u_*  (m s^{-1})');
axis('square');
title('(d)','FontSize',11);

end

