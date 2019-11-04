
D_wave = 0;
D_wind = 0;
theta_ref = 0;

x_init = [ 0.3, 0];

%system
w_n  = 2;   % rad/sec
zeta = 0.4; % damping 

A = [ 0, 1; -w_n^2, -2*zeta*w_n];
B = [0; 2*w_n^2];
C = [0.5, 0];

% Find stable poles of hamiltonian
% initial Q of diag(10,20) did not work well recalculated

Q = [35, 0; 0, 10];
R = 1;
H = [A, -B*inv(R)*B'; -Q, -A'];

[w,v] = eig(H); 
w11 = w( 1:2, 1:2);
w21 = w( 3:4, 1:2);

s_inf = w21*inv(w11);

k = B'*s_inf;

% find stable poles of hamiltonian for servo
a = [A,zeros(2,1); -C, 0];
b = [0;8;0];
c = [.5,0,0];

q = diag([45,30,10],0);
h = [a, -b*inv(R)*b'; -q, -a'];
rank(obsv(a,q))
[w,v] = eig(h); 
temp = w(:,[1,3,5]);
w11 = temp( 1:3, 1:3);
w21 = temp( 4:6, 1:3);

s_inf = w21*inv(w11);
k_servo = b'*s_inf


% Plots Part A

stateFeedBack = sim('problem3_sim.slx');
t = stateFeedBack.Y_gyro.time;
figure(1)
plot(t,stateFeedBack.Y_gyro.signals.values,'blue','linewidth',1.5)
grid on
title('State FeedBack System - Y_{gyro}')
xlabel('Time [s]')
ylabel('1/2 \Theta')
saveas(gcf,'Problem3a_SFB_NO_D_ygyro.png')

figure(2)
plot(t,stateFeedBack.x_t.signals.values(:,1),'blue','linewidth',1.5)
grid on
title('State FeedBack System - State: $\Theta$','interpreter','latex')
xlabel('Time [s]')
ylabel('\Theta [rad]')
saveas(gcf,'Problem3a_SFB_NO_D_theta.png')

figure(3)
plot(t,stateFeedBack.x_t.signals.values(:,2),'blue','linewidth',1.5)
grid on
title('State FeedBack System - State: $\dot{\Theta}$','interpreter','latex')
xlabel('Time [s]')
ylabel('$\dot{\theta}$ [rad/sec]','interpreter','latex')
saveas(gcf,'Problem3a_SFB_NO_D_thetaDot.png')

figure(4)
plot(t,stateFeedBack.u_t.signals.values,'blue','linewidth',1.5)
grid on
title('State FeedBack System - Control Signal')
xlabel('Time [s]')
ylabel('U(t)')
saveas(gcf,'Problem3a_SFB_NO_D_u.png')



%Plots part B
D_wave = 6;
stateFeedBack = sim('problem3_sim.slx');
t = stateFeedBack.Y_gyro.time;
figure(1)
plot(t,stateFeedBack.Y_gyro.signals.values,'blue','linewidth',1.5)
grid on
title('State FeedBack System - Y_{gyro}')
xlabel('Time [s]')
ylabel('1/2 \Theta')
saveas(gcf,'Problem3b_SFB_wave_ygyro.png')

figure(2)
plot(t,stateFeedBack.x_t.signals.values(:,1),'blue','linewidth',1.5)
grid on
title('State FeedBack System - State: $\Theta$','interpreter','latex')
xlabel('Time [s]')
ylabel('\Theta [rad]')
saveas(gcf,'Problem3b_SFB_wave_theta.png')

figure(3)
plot(t,stateFeedBack.x_t.signals.values(:,2),'blue','linewidth',1.5)
grid on
title('State FeedBack System - State: $\dot{\Theta}$','interpreter','latex')
xlabel('Time [s]')
ylabel('$\dot{\theta}$ [rad/sec]','interpreter','latex')
saveas(gcf,'Problem3b_SFB_wave_thetaDot.png')

figure(4)
plot(t,stateFeedBack.u_t.signals.values,'blue','linewidth',1.5)
grid on
title('State FeedBack System - Control Signal')
xlabel('Time [s]')
ylabel('U(t)')
saveas(gcf,'Problem3b_SFB_NO_D_u.png')

% Plots Part C
D_wind = 7;
D_wave = 0;

stateFeedBack = sim('problem3_sim.slx');
t = stateFeedBack.Y_gyro.time;
figure(1)
plot(t,stateFeedBack.Y_gyro.signals.values,'blue','linewidth',1.5)
grid on
title('State FeedBack System - Y_{gyro}')
xlabel('Time [s]')
ylabel('1/2 \Theta')
saveas(gcf,'Problem3c_SFB_wind_ygyro.png')

figure(2)
plot(t,stateFeedBack.x_t.signals.values(:,1),'blue','linewidth',1.5)
grid on
title('State FeedBack System - State: $\Theta$','interpreter','latex')
xlabel('Time [s]')
ylabel('\Theta [rad]')
saveas(gcf,'Problem3c_SFB_wind_theta.png')

figure(3)
plot(t,stateFeedBack.x_t.signals.values(:,2),'blue','linewidth',1.5)
grid on
title('State FeedBack System - State: $\dot{\Theta}$','interpreter','latex')
xlabel('Time [s]')
ylabel('$\dot{\theta}$ [rad/sec]','interpreter','latex')
saveas(gcf,'Problem3c_SFB_wind_thetaDot.png')

figure(4)
plot(t,stateFeedBack.u_t.signals.values,'blue','linewidth',1.5)
grid on
title('State FeedBack System - Control Signal')
xlabel('Time [s]')
ylabel('U(t)')
saveas(gcf,'Problem3c_SFB_wind_u.png')


% Plots Part D
D_wind = 7;
D_wave = 6;
figure(21)
servo_sys = sim('problem3_servo_sim.slx');
t = servo_sys.x_t.time;
plot(servo_sys.Y_gyro.time,servo_sys.Y_gyro.signals.values)
grid on
title('Servo System - Y_{gyro} ')
xlabel('Time [s]')
ylabel('1/2 \Theta')
saveas(gcf,'Problem3d_servo_all_D_ygyro.png')

figure(22)
plot(t,servo_sys.x_t.signals.values(:,1),'blue','linewidth',1.5)
grid on
title('Servo System - State: $\Theta$','interpreter','latex')
xlabel('Time [s]')
ylabel('\Theta [rad]')
saveas(gcf,'Problem3d_servo_all_D_theta.png')

figure(23)
plot(t,servo_sys.x_t.signals.values(:,2),'blue','linewidth',1.5)
grid on
title('Servo System - State: $\dot{\Theta}$','interpreter','latex')
xlabel('Time [s]')
ylabel('$\dot{\theta}$ [rad/sec]','interpreter','latex')
saveas(gcf,'Problem3d_servo_all_D_thetaDot.png')

figure(24)
plot(t,servo_sys.u_t.signals.values,'blue','linewidth',1.5)
grid on
title('Servo System - Control Signal')
xlabel('Time [s]')
ylabel('U(t)')
saveas(gcf,'Problem3d_servo_all_D_u.png')


figure(31)

servo_sys = sim('problem3_servo_sim.slx');
t = servo_sys.x_t.time;
plot(servo_sys.Y_gyro.time,servo_sys.Y_gyro.signals.values)
grid on
title('Servo System - Y_{gyro} ')
xlabel('Time [s]')
ylabel('1/2 \Theta')

figure(32)
plot(t,servo_sys.x_t.signals.values(:,1),'blue','linewidth',1.5)
grid on
title('Servo System - State: $\Theta$','interpreter','latex')
xlabel('Time [s]')
ylabel('\Theta [rad]')

figure(33)
plot(t,servo_sys.x_t.signals.values(:,2),'blue','linewidth',1.5)
grid on
title('Servo System - State: $\dot{\Theta}$','interpreter','latex')
xlabel('Time [s]')
ylabel('$\dot{\theta}$ [rad/sec]','interpreter','latex')

figure(34)
plot(t,servo_sys.u_t.signals.values,'blue','linewidth',1.5)
grid on
title('Servo System - Control Signal')
xlabel('Time [s]')
ylabel('U(t)')








