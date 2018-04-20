function traj = diff_flat(in,P)
    
   % get the time 
   t = in(1);
   
   %
   % fly a circle
   %
   
   
   A = 5;  % z-axis radius
   B = 5;  % h-axis radius
   
   w = 0.1;
   
   % compute the desired trajectory
   z = A*cos(w*t);
   zdot = -A*w*sin(w*t);
   zddot = -A*(w^2)*cos(w*t);
   
   
   h = B*sin(w*t);
   hdot = B*w*cos(w*t);
   hddot = -B*(w^2)*sin(w*t);
   
   hddot = hddot + P.g;  % don't forget gravity
   
   traj = [z; zdot; zddot; h; hdot; hddot];
   
end