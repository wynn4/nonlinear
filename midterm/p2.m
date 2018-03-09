clc
clear

x = [-1; -1];
y = [1; 1];

fx = get_f(x);
fy = get_f(y);

norm(fx -fy)
norm(x - y)


function f = get_f(x)
a = 1;
b = 1;
f = zeros(2,1);
f(1) = -x(1) + a*abs(x(2));
f(2) = -(a+b)*x(1) + b*x(1)^2 - x(1)*x(2);
end