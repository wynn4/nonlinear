clc, clear, close all

t0 = 0;
tf = 100;
% y0 = [0, 2, 0]';

% options= odeset('OutputFcn',@myplot3);
% [t, x] = ode45(@lorenz_fun, [t0, tf], y0, options);

% no options necessary
[t1, x1] = ode45(@lorenz_fun, [t0, tf], [0, 2, 0]');
[t2, x2] = ode45(@lorenz_fun, [t0, tf], [0, -2, 0]');
[t3, x3] = ode45(@lorenz_fun, [t0, tf], [0, 2.01, 0]');

% grab the index of the end point
end1 = length(x1);
end2 = length(x2);
end3 = length(x3);

% static plot
figure(1), clf
plot3(x1(:,1), x1(:,2), x1(:,3), 'r')
hold on
plot3(x2(:,1), x2(:,2), x2(:,3), '-.g')
plot3(x3(:,1), x3(:,2), x3(:,3), '.b')
plot3(0, 0, 0,'Color',[1 1 1])
plot3(x1(end1, 1), x1(end1, 2), x1(end1, 3), 'k+', 'MarkerSize', 20, 'LineWidth', 3)
plot3(0, 0, 0,'Color',[1 1 1])
plot3(x2(end2, 1), x2(end2, 2), x2(end2, 3), 'kx', 'MarkerSize', 20, 'LineWidth', 3)
plot3(0, 0, 0,'Color',[1 1 1])
plot3(x3(end3, 1), x3(end3, 2), x3(end3, 3), 'k*', 'MarkerSize', 20, 'LineWidth', 3)
plot3(0, 0, 0,'Color',[1 1 1])
legend('x0 = [0, 2, 0]', 'x0 = [0, -2, 0]', 'x0 = [0, 2.01, 0]',...
    '', 'end point 1', '', 'end point 2', '', 'end point 3', '')
view([0, 0])

% animaited plot
% comet3(x1(:,1), x1(:,2), x1(:,3))

function [f] = lorenz_fun(T, Y)
x = Y(1,1);
y = Y(2,1);
z = Y(3,1);
sigma = 10;
b = 8/3;
r = 28;
xdot = sigma*(y - x);
ydot = r*x - y - x*z;
zdot = x*y - b*z;
f = [xdot, ydot, zdot]';
end

