clc, clear, close all

t0 = 0;
tf = 100;

N = 100;

I1 = 3;
I2 = 2;
I3 = 1;
mu = 0;

% make initialize omegas and make some random angular momentms
w0 = zeros(3,N);
h0 = randn(3,N);

for i = 1:N
    h0(:,i) = h0(:,i)/norm(h0(:,i));
    w0(1,i) = h0(1,i)/I1;
    w0(2,i) = h0(2,i)/I2;
    w0(3,i) = h0(3,i)/I3;
end

% part D
figure(1), clf
hold on

for i = 1:N
    [t1, y] = ode45(@euler_fun, [t0, tf], w0(:,i));
    plot3(I1*y(:,1), I2*y(:,2)*I2, I3*y(:,3))
end

figure(1)
xlabel('h_G 1')
ylabel('h_G 2')
zlabel('h_G 3')

% part E
[t1, y] = ode45(@euler_fun, [t0, tf], [0.5, 0.01, 0.01]);
[t2, y2] = ode45(@euler_fun, [t0, tf], [0.5, 0.0, 0.0]);

figure(2), clf
plot3(y(:,1), y(:,2), y(:,3), 'r')
hold on
plot3(y2(:,1), y2(:,2), y2(:,3), '*b')
axis equal

[t1, y] = ode45(@euler_fun, [t0, tf], [0.01, 0.5, 0.01]);
[t2, y2] = ode45(@euler_fun, [t0, tf], [0.0, 0.5, 0.0]);

figure(3), clf
plot3(y(:,1), y(:,2), y(:,3), 'r')
hold on
plot3(y2(:,1), y2(:,2), y2(:,3), '*b')
axis equal

[t1, y] = ode45(@euler_fun, [t0, tf], [0.01, 0.01, 0.5]);
[t2, y2] = ode45(@euler_fun, [t0, tf], [0.0, 0.0, 0.5]);

figure(4), clf
plot3(y(:,1), y(:,2), y(:,3), 'r')
hold on
plot3(y2(:,1), y2(:,2), y2(:,3), '*b')
axis equal


function [f] = euler_fun(T, Y)
w1 = Y(1,1);
w2 = Y(2,1);
w3 = Y(3,1);

I1 = 3;
I2 = 2;
I3 = 1;
mu = 0;

w1dot = ((I2 - I3)*w2*w3 + mu)/I1;
w2dot = ((I3 - I1)*w1*w3 + mu)/I2;
w3dot = ((I1 - I2)*w1*w2 + mu)/I3;


f = [w1dot, w2dot, w3dot]';
end