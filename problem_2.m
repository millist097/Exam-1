%x_init = [0,0];

x1_init = [0,.01, -.01, .01, -.01];
x2_init = [0,.01, -.01, -5, -5];

%x_init = [ x1_init, x2_init];
figure(1)
for i = [1,2,3,4,5]
    x_init = [x1_init(i), x2_init(i)]';
    a=sim('problem2_sim.slx');
    plot(a.x.signals.values(:,1),a.x.signals.values(:,2),...
         'blue', 'linewidth',1.5)
    hold on
    plot(x1_init(i), x2_init(i),'*r','linewidth',3)
end 

grid on
title('Phase Portrait')
xlabel('$x$(t)','interpreter','latex')
ylabel("$\dot{x}$(t)",'interpreter','latex')
hold off
saveas(gcf,'Problem2_PhasePortrait.png')