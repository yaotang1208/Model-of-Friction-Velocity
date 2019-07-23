function [ output_args ] = F_PlotInputs_DM(Rn,H,Ta,UST,WS,RH,DaysAYear)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
x = 1:1:DaysAYear;

figure(1);
subplot(3,1,1);
plot(x,Rn);
ylabel('Rn');

subplot(3,1,2);
plot(x,Ta);
ylabel('Ta');

subplot(3,1,3);
plot(x,RH);
ylabel('RH');

figure(2);
subplot(3,1,1);
plot(x,H);
ylabel('H');

subplot(3,1,2);
plot(x,WS);
ylabel('WS');

subplot(3,1,3);
plot(x,UST);
ylabel('UST');

end

