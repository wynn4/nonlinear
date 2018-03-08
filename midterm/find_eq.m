clc
clear
close all

% solve for the equilibria of a system

% declare symbolic variabls
syms x1 x2

% define system of equations we'd like to solve
% notice == 0 because we're looking for equilibirum (xdot = 0)
% here we do HK problem 2.1(2) from the hw as an exmaple
eqns = [x1 + x1*x2 == 0, -x2 + x2^2 + x1*x2 - x1^3 == 0];
vars = [x1, x2];
[solv, solu] = solve(eqns, vars);

% display the solutions
solutions = [solv, solu]

% Note solv corresponds to x1 values and solu corresponds to x2 values.
% Ignore any solutions with imaginary parts (can't have imaginary
% equilibria for real systems).