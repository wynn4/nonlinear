%clear all

% actual system parameters
AP.mc = 1.0;  % kg
AP.mr = 0.25;     % kg
AP.ml = AP.mr; % kg
AP.Jc = 0.0042; %kg m^2
AP.d = 0.3; % m
AP.mu = 0.1; % kg/s
AP.g = 9.81; % m/s^2

% initial conditions
AP.z0 = 0;
AP.zdot0 = 0;
AP.h0 = 0;
AP.hdot0 = 0;
AP.theta0 = 0;
AP.thetadot0 = 0;

% assumed system paramters used for design
P.mc = 1.05*AP.mc;  % kg
P.mr = 1*AP.mr;     % kg
P.ml = P.mr; % kg
P.Jc = 1*AP.Jc; %kg m^2
P.d = 1*AP.d; % m
P.mu = 1*AP.mu; % kg/s
P.g = 9.81; % m/s^2

%Input disturbances
AP.F_wind = 0.1;

% saturation limits for each rotor
P.fmax = 10;

% sample rate for controller
P.Ts = 0.01;

% dirty derivative gain for differentiator
P.tau = 0.05;

% mixing matrix
P.mixing = inv([1, 1; P.d, -P.d]);

% equilibrium force and constraints
P.Fe = (P.mc+2*P.mr)*P.g;
P.Ftildemax = 2*P.fmax - P.Fe;
P.taumax = (P.fmax-P.Fe/2)/P.d;

% design equations for longitudinal control
A_h    = 10;
zeta_h = 0.707;
P.kp_h = P.Ftildemax/A_h;
wn_h   = sqrt(P.kp_h/(P.mc+2*P.mr));
P.kd_h = 2*zeta_h*wn_h*(P.mc+2*P.mr);

P.ki_h = 0.5;

% design equations for lateral control
% PD design for lateral inner loop
b0       = 1/(P.Jc+2*P.mr*P.d^2);
A_th     = 1;
zeta_th  = 0.707;
P.kp_th  = P.taumax/A_th;
wn_th    = sqrt(b0*P.kp_th);
P.kd_th  = 2*zeta_th*wn_th/b0;

% DC gain for lateral inner loop
k_DC_th = 1;

%PD design for lateral outer loop
b1       = -P.Fe/(P.mc+2*P.mr);
a1       = P.mu/(P.mc+2*P.mr);
A_z      = 10;
zeta_z   = 0.707;
P.kp_z   = -A_th/A_z;
wn_z     = sqrt(b1*P.kp_z);
P.kd_z   = (2*zeta_z*wn_z-a1)/b1;

P.ki_z   = 0;

%%%%%%%%%%%%%%%%%%%%%__State Space Controller Params__%%%%%%%%%%%%%%%%%%%%

%Desired performance characteristics
wn_h   = 1*sqrt(P.kp_h/(P.mc+2*P.mr));
wn_th    = 1*sqrt(b0*P.kp_th);
wn_z     = 1*sqrt(b1*P.kp_z);

zeta_h = 1*0.707;
zeta_th = 1*0.707;
zeta_z = 1*0.707;

char_poly_h = conv([1, 2*zeta_h*wn_h, wn_h^2],poly(-1.0));
%char_poly_h = [1, 2*zeta_h*wn_h, wn_h^2];
des_poles_h = roots(char_poly_h);

char_poly_z_th = conv(conv([1, 2*zeta_z*wn_z, wn_z^2],...
    [1, 2*zeta_th*wn_th, wn_th^2]),poly(-.1));
% char_poly_z_th = conv([1, 2*zeta_z*wn_z, wn_z^2],...
%      [1, 2*zeta_th*wn_th, wn_th^2]);
des_poles_z_th = roots(char_poly_z_th);
%State space matrices

%%%%%%%%%%Up and Down%%%%%%%%%%%%%
P.A_h = [0 1;0 0];
P.B_h = [0;(1/(P.mc+2*P.mr))];
P.C_h = [1 0];
P.D_h = [0];

%Form the augmented system
P.A1_h = [P.A_h, zeros(2,1); P.C_h, 0];
P.B1_h = [P.B_h; 0];

%Check to see if system is controlable
if rank(ctrb(P.A1_h,P.B1_h)) ~= 3, disp('System Not Controllable');end
K_h = place(P.A1_h,P.B1_h,des_poles_h);
P.K_h = K_h(1:2);
P.Ki_h = K_h(3);
P.kr_h = -1/(P.C_h*inv(P.A_h-P.B_h*P.K_h)*P.B_h); %(1,:)

%up and down observer
P.A_h2 = [P.A_h, P.B_h; zeros(1,2), zeros(1,1)];
P.C_h2 = [P.C_h, zeros(1,1)];
% a = 10;
% q1 = -a + 1i*a;
% q2 = -a - 1i*a;
% pick observer poles
wn_obs_h   = 10*wn_h;
des_obsv_char_poly_h = [1,2*zeta_h*wn_obs_h,wn_obs_h^2];
des_obsv_poles_h = roots(des_obsv_char_poly_h);
dist_obsv_pole_h = -1;
%is the system observable?
if rank(obsv(P.A_h2,P.C_h2))~=3,
    disp('System Not Observable');
else
    L2_h = place(P.A_h2',P.C_h2',[des_obsv_poles_h;dist_obsv_pole_h])';
    P.L_h = L2_h(1:2,:);
    P.Ld_h = L2_h(3,:);
end


%%%%%%%%%%%Side to Side%%%%%%%%%%%%%%%%
P.A = [0 0 1 0;0 0 0 1;0 -P.Fe/(P.mc+2*P.mr) P.mu/(P.mc+2*P.mr) 0;...
    0 0 0 0];
P.B = [0; 0; 0; 1/(P.Jc+2*P.mr*P.d^2)];
P.C = [1 0 0 0;0 1 0 0];
P.D = [0; 0];

%form the augmented system
Cout = P.C(1,:);
P.A1 = [P.A, zeros(4,1); Cout, 0];
P.B1 = [P.B; 0];

%Check to see if system is controlable
if rank(ctrb(P.A1,P.B1)) ~= 5, disp('System Not Controllable');end
K1 = place(P.A1,P.B1,des_poles_z_th);
P.K = K1(1:4);
 P.Ki_z = K1(5);
P.kr = -1/(P.C(1,:)*inv(P.A-P.B*P.K)*P.B);

%Observer design
A2 = [P.A, P.B; zeros(1,4), zeros(1,1)];
C2 = [P.C, zeros(2,1)];
%pick observer poles
wn_th_obs   = 5*wn_th;
wn_z_obs    = 10*wn_z;
des_obsv_char_poly = conv([1,2*zeta_z*wn_z_obs,wn_z_obs^2],...
                      [1,2*zeta_th*wn_th_obs,wn_th_obs^2]);
des_obsv_poles = roots(des_obsv_char_poly);
dist_obsv_pole = -1;

% is the system observable?
if rank(obsv(A2,C2))~=5, 
    disp('System Not Observable'); 
else % if so, compute gains
   L2 = place(A2', C2', [des_obsv_poles; dist_obsv_pole])';
   P.L_z = L2(1:4,:);
   P.Ld_z = L2(5,:);
   %P.L_z = [62.7114 31.7899; -53.3682 45.8263; 661.5467 -7.1966; 6.4273 659.6511];
end









