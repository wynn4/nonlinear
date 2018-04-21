function torques_and_forces = f_inv(in, P, AP)

% this function takes in zddot and hddot (accelerations) from our 
% differential flatness and converts them to forces and torques

x = in(1:6);
traj = in(7:12);


mass = AP.mc + AP.mr + AP.ml;

% get our accelerations
zddot = traj(3);
hddot = traj(6);

%
% compute force from our accelerations
%

% F = m * a
F = mass * sqrt(zddot^2 + hddot^2);
% F = mass * sqrt(hddot^2);

%
% compute torque
%

% first we need to solve for theta
theta_des = asin(zddot*mass/-F);

% pull our actual theta and thetadot off of our state
theta = x(3);
thetadot = x(6);

% now we use a PD controller to compute our torque
Tau = PD(theta_des, theta, thetadot, P.kp_th, P.kd_th, P.taumax);


torques_and_forces = [F; Tau];
end

% PD control for angle theta
function u = PD(theta_c,theta,thetadot, kp, kd, limit)

    % gains
    
    
    % compute the error
    error = theta_c-theta;
    

    % compute the pid control signal
    u_unsat = kp*error - kd*thetadot;
    u = sat(u_unsat,limit);
    
end

% saturation function
function out = sat(in,limit)
    if     in > limit,      out = limit;
    elseif in < -limit,     out = -limit;
    else                    out = in;
    end
end