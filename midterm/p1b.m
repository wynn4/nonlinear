clc
clear
close all

% define number of grid points
N = 20;

% define our function of differential equaitons
% f @(t, X) [X1dot; X2dot];
mu = 1;  % 
f = @(t, X) [X(2); (mu - X(1)^2 - X(2)^2)*X(2) - X(1)];

% create a grid where we will evaluate the function derivatives
x1 = linspace(-2, 2, N);  % from -5 to 5 on the x1 axis with N points
x2 = linspace(-2, 2, N);  % same^

% create a meshgrid (two NxN matrices), one for all the x values on the
% grid and one for all the y values on the grid
[x,y] = meshgrid(x1,x2);

% create u matrix to hold values of X1dot at each x and y position in the
% grid
u = zeros(size(x));
% create v matrix to hold values of X2dot at each x and y position in the
% grid
v = zeros(size(y));

% evaluate the Xdot at each point in the grid
t=0;  
for i = 1:numel(x)
    Xdot = f(t, [x(i); y(i)]);
    u(i) = Xdot(1);
    v(i) = Xdot(2);
end


% plot phase plot using quiver
figure(1), clf
quiver(x,y,u,v,'b', 'AutoScaleFactor', 2.0);
xlabel('x1')
ylabel('x2')
title('phase plot mu = 1')
axis tight equal;


% plot solutions on plot
hold on
X0 = [1, 1]';  % define initial x1 and x2 locations
tspan = [0, 100];  % lets see solutions from time t = 0 to 10

% solve using ode45
[ts, xs] = ode45(f, tspan, X0);
plot(xs(:,1), xs(:,2), 'g')
plot(xs(1,1),xs(1,2),'go') % starting point
plot(xs(end,1),xs(end,2),'r*') % ending point

[ts, xs] = ode45(f, tspan, [0.5; -1]);
plot(xs(:,1), xs(:,2), 'g')
plot(xs(1,1),xs(1,2),'go') % starting point
plot(xs(end,1),xs(end,2),'r*') % ending point

[ts, xs] = ode45(f, tspan, [-1.75; -0.5]);
plot(xs(:,1), xs(:,2), 'g')
plot(xs(1,1),xs(1,2),'go') % starting point
plot(xs(end,1),xs(end,2),'r*') % ending point

[ts, xs] = ode45(f, tspan, [-0.5; 1.5]);
plot(xs(:,1), xs(:,2), 'g')
plot(xs(1,1),xs(1,2),'go') % starting point
plot(xs(end,1),xs(end,2),'r*') % ending point

[ts, xs] = ode45(f, tspan, [0.1; 0.1]);
plot(xs(:,1), xs(:,2), 'g')
plot(xs(1,1),xs(1,2),'go') % starting point
plot(xs(end,1),xs(end,2),'r*') % ending point

