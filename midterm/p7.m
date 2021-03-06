clc
clear
close all

% define our function of differential equaitons
% f @(t, X) [X1dot; X2dot];
% f = @(t, X) [X(2) + X(1)*X(3); -X(1) - X(2) + X(2)*X(3); -X(1)^2 -X(2)^2];

X0 = [1, 1]';  % define x0
% X0 = [3, 3]';
tspan = [0, 30];  % lets see solutions from time t = 0 to 10

% solve using ode45
[ts, xs] = ode45(@my_fun, tspan, X0);

figure(1), clf
plot(ts, xs(:,1), 'k', ts, xs(:,2), 'k--')
legend('x1', 'x2')
xlabel('t (s)')
ylabel('states')


function xdot = my_fun(t, X)
Xdot1 = -X(2)^3;
Xdot2 = X(1) - X(2);

xdot = [Xdot1, Xdot2]';
end