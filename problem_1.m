
k = 7;
x_0 = 5;
beta = .8;

% Plots part B
k=0;
a=sim('problem1_sim.slx');
figure(1)
plot(a.x_t.time,abs(a.x_t.signals.values),'red',...
     a.x_t.time,a.x_t.signals.values,'blue','linewidth',1.5)
legend('|x(t)|','x(t)')
title('Open Loop System')
xlabel('Time [s]')
ylabel('x(t)')
grid on
saveas(gcf,'Problem1b.png')


figure(2)
plot(a.x_t.time,a.x_t.signals.values,'red','linewidth',1.5)
hold on
k=7;
a=sim('problem1_sim.slx');
plot(a.x_t.time,a.x_t.signals.values,'blue','linewidth',1.5)
title('Closed Loop (state feedback) System')
legend('x_{open-loop}','x_{closed-loop}')
xlabel('Time [s]')
ylabel('x(t)')
grid on
saveas(gcf,'Problem1d.png')








