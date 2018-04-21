function traj = diff_flat(in,P)
    
   % get the time 
   t = in(1);
   
   
   %
   % fly a circle
   %
   
   
   A = P.z_Amp;  % z-axis radius (amplitude)
   B = P.h_Amp;  % h-axis radius (amplitude)
   
   w = P.omega;
   % w = in(2);
   
   w_z = w * P.z_mult;
   w_h = w * P.h_mult;
   
   % compute the desired trajectory
   z = A*cos(w_z*t);
   zdot = -A*w_z*sin(w_z*t);
   zddot = -A*(w_z^2)*cos(w_z*t);
   
   
   h = B*sin(w_h*t);
   hdot = B*w_h*cos(w_h*t);
   hddot = -B*(w_h^2)*sin(w_h*t);
   
   hddot = hddot + P.g;  % don't forget gravity
   
   traj = [z; zdot; zddot; h; hdot; hddot];
   
end