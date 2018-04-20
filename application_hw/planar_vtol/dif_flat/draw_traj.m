clc
clear
close all

t = 0:0.1:2*pi*10;
A = 2;
B = 4;

w = 0.1;

z = A*cos(w*t);
h = B*sin(w*t);

plot(z, h)