function [ output_args ] = F_PlotGEH_DM(Rn,FG,LE,H,GMEP1,EMEP1,HMEP1,GMEP2,EMEP2,HMEP2,T)


figure(31);
h21_1 = subplot(4,1,1);
plot(T,Rn,'-b');
grid on;
ylabel('Rn (W m^-2)');

h21_2 = subplot(4,1,2);
plot(T, EMEP1,'r-',T, LE,'b-');
grid on;
% axis([160,170,-100,600])
legend('EMEP1','EOBS');
% title('MEP VS OBS, 2006')
% xlabel('Julian Day');
ylabel('E (W m-2)');

h21_3 = subplot(4,1,3);
plot(T, HMEP1,'r-',T, H,'b-');
grid on;
% axis([160,170,-100,500])
legend('HMEP1','HOBS');
% xlabel('Julian Day');
ylabel('H (W m-2)');

h21_4 = subplot(4,1,4);
plot(T, GMEP1,'r-',T, FG,'b-');
grid on;
% axis([160,170,-100,500])
legend('GMEP1','GOBS');
xlabel('Julian Day');
ylabel('G (W m-2)');
linkaxes([h21_1,h21_2,h21_3, h21_4] ,'x');

FG(isnan(FG)) = 0;

figure(32);
subplot(3,1,1);
scatter(LE,EMEP1);hold on;
plot(-1000:1:2000,-1000:1:2000,'-r');hold off
xlabel(' EOBS (W/m^2)');
ylabel(' EMEP1 (W/m^2)');
axis('square');
grid on;

subplot(3,1,2);
scatter(H,HMEP1);hold on;
plot(-1000:1:2000,-1000:1:2000,'-r');hold off
xlabel(' HOBS (W/m^2)');
ylabel(' HMEP1 (W/m^2)');
axis('square');
grid on;

subplot(3,1,3);
scatter(FG,GMEP1);
xlabel(' GOBS (W/m^2)');
ylabel(' GMEP1 (W/m^2)');
axis('square');
grid on;
%%
figure(33);
h21_1 = subplot(4,1,1);
plot(T,Rn,'-b');
grid on;
ylabel('Rn (W m^-2)');

h21_2 = subplot(4,1,2);
plot(T, EMEP2,'r-',T, LE,'b-');
grid on;
% axis([160,170,-100,600])
legend('EMEP2','EOBS');
% title('MEP VS OBS, 2006')
% xlabel('Julian Day');
ylabel('E (W m-2)');

h21_3 = subplot(4,1,3);
plot(T, HMEP2,'r-',T, H,'b-');
grid on;
% axis([160,170,-100,500])
legend('HMEP2','HOBS');
% xlabel('Julian Day');
ylabel('H (W m-2)');

h21_4 = subplot(4,1,4);
plot(T, GMEP2,'r-',T, FG,'b-');
grid on;
% axis([160,170,-100,500])
legend('GMEP2','GOBS');
xlabel('Julian Day');
ylabel('G (W m-2)');
linkaxes([h21_1,h21_2,h21_3, h21_4] ,'x');

FG(isnan(FG)) = 0;

figure(34);
subplot(3,1,1);
scatter(LE,EMEP2);hold on;
plot(-1000:1:2000,-1000:1:2000,'-r');hold off
xlabel(' EOBS (W/m^2)');
ylabel(' EMEP2 (W/m^2)');
axis('square');
grid on;

subplot(3,1,2);
scatter(H,HMEP2);hold on;
plot(-1000:1:2000,-1000:1:2000,'-r');hold off
xlabel(' HOBS (W/m^2)');
ylabel(' HMEP2 (W/m^2)');
axis('square');
grid on;

subplot(3,1,3);
scatter(FG,GMEP2);
xlabel(' GOBS (W/m^2)');
ylabel(' GMEP2 (W/m^2)');
axis('square');
grid on;

%%
figure(35);
h21_1 = subplot(4,1,1);
plot(T,Rn,'-b');
grid on;
ylabel('Rn (W m^-2)');

h21_2 = subplot(4,1,2);
plot(T, EMEP1,'r-',T, EMEP2,'b-');
grid on;
% axis([160,170,-100,600])
legend('EMEP1','EMEP2');
% title('MEP VS OBS, 2006')
% xlabel('Julian Day');
ylabel('E (W m-2)');

h21_3 = subplot(4,1,3);
plot(T, HMEP1,'r-',T, HMEP2,'b-');
grid on;
% axis([160,170,-100,500])
legend('HMEP1','HMEP2');
% xlabel('Julian Day');
ylabel('H (W m-2)');

h21_4 = subplot(4,1,4);
plot(T, GMEP1,'r-',T, GMEP2,'b-');
grid on;
% axis([160,170,-100,500])
legend('GMEP1','GMEP2');
xlabel('Julian Day');
ylabel('G (W m-2)');
linkaxes([h21_1,h21_2,h21_3, h21_4] ,'x');

FG(isnan(FG)) = 0;

figure(36);
subplot(3,1,1);
scatter(EMEP1,EMEP2);hold on;
plot(-1000:1:2000,-1000:1:2000,'-r');hold off
xlabel(' EMEP1 (W/m^2)');
ylabel(' EMEP2 (W/m^2)');
axis('square');
grid on;

subplot(3,1,2);
scatter(HMEP1,HMEP2);hold on;
plot(-1000:1:2000,-1000:1:2000,'-r');hold off
xlabel(' HMEP1 (W/m^2)');
ylabel(' HMEP2 (W/m^2)');
axis('square');
grid on;

subplot(3,1,3);
scatter(GMEP1,GMEP2);
xlabel(' GMEP1 (W/m^2)');
ylabel(' GMEP2 (W/m^2)');
axis('square');
grid on;

end

