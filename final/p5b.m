clc
clear
close all



X0 = [0, 0, 0]';  % define x0
% X0 = [3, 3]';
tspan = [0, 60];  % lets see solutions from time t = 0 to 60

% solve using ode45
[ts, xs] = ode45(@my_fun, tspan, X0);

figure(1), clf
plot(ts(1:50:end), xs(1:50:end,1), '-r*', ts(1:50:end), xs(1:50:end,2), '-ms', ts(1:50:end), xs(1:50:end,3))

xlabel('t (s)')
ylabel('states')

hold on

plot(ts, sin(ts), '--k')
legend('x1 (our output)', 'x2', 'x3', 'r(t) = sin(t)')

% % plot error vs time
% figure(2), clf
% e1 = xs(:,1) - sin(ts);
% plot(ts, e1)
% xlabel('t (sec)')
% ylabel('error of the output y = x1')



function xdot = my_fun(t, X)

% define the error:
e1 = X(1) - sin(t);
e2 = X(2) + 2*X(1)^2 - cos(t);

% set our gains:
K1 = 200;
K2 = 200;

% Define our control input, u:
u = -X(3) - 4*X(2) - 8*X(1)^2 - sin(t) - K1*e1 - K2*e2;

Xdot1 = X(2) + 2*X(1)^2;
Xdot2 = X(3) + u;
Xdot3 = X(1) - X(3);

xdot = [Xdot1, Xdot2, Xdot3]';
end