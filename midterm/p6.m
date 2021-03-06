clc
clear
close all

% define our function of differential equaitons
% f @(t, X) [X1dot; X2dot];
% f = @(t, X) [X(2) + X(1)*X(3); -X(1) - X(2) + X(2)*X(3); -X(1)^2 -X(2)^2];

X0 = [3, 3, 3]';  % define x0
tspan = [0, 10];  % lets see solutions from time t = 0 to 10

% solve using ode45
[ts, xs] = ode45(@my_fun, tspan, X0);

figure(1), clf
plot(ts, xs(:,1), 'k', ts, xs(:,2), 'k-.', ts, xs(:,3), 'k--')
% plot(ts, xs(:,1), ts, xs(:,2))
legend('x1', 'x2', 'x3')
xlabel('time (s)')
ylabel('states')

function xdot = my_fun(t, X)
Xdot1 = X(2) + X(1)*X(3);
Xdot2 = -X(1) - X(2) + X(2)*X(3);
Xdot3 = -X(1)^2 -X(2)^2;

xdot = [Xdot1, Xdot2, Xdot3]';
end

