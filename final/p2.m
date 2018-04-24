clc
clear all

syms w1 w2 w3 k1 k2 k3 d1 d2 d3

w = [w1, w2, w3]';

P = [-k1 + (d1/w1), 0, 0; 0, -k2 + (d2/w2), 0; 0, 0, -k3 + (d3/w3)]

vdot = w' * P * w