
df_state = load('diff_flat_state_slow.mat');
pd_state = load('pid_state_slow.mat');

figure(1), clf

tt = 0:0.1:200;
z = P.z_Amp*cos(P.omega*P.z_mult*tt);
h = P.h_Amp*sin(P.omega*P.h_mult*tt);
plot(z,h,'b')

hold on

plot(df_state.state(:,1), df_state.state(:,2), 'g')

plot(pd_state.state(:,1), pd_state.state(:,2), 'r')

axis([-10 10 -10 10])
legend('Desired Trajectory', 'Differential Flatness Trajectory', 'PID only Trajectory')

xlabel('z')
ylabel('h')
title('Planar VTOL Trajectory')