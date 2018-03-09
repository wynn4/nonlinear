clc
clear
close all

% solve for the equilibria of the system

% declare symbolic variabls
syms x1 x2

% define system of equations
mu = 0;
eqns = [x2 == 0, (mu - x1^2 - x2^2)*x2 - x1 == 0];
vars = [x1, x2];
[solv, solu] = solve(eqns, vars);

% display the solutions
solutions = [solv, solu]

% Note solv corresponds to x1 values and solu corresponds to x2 values.
% Ignore any solutions with imaginary parts (can't have imaginary
% equilibria for real systems).