
first_data = '/home/jesse/Desktop/rosbags/sm_2gravity.bag';
% second_data = blind_flight_2017-08-01-SECOND.bag;
data = processAllTopics(first_data)


%% Load data and plots

% figure attributes
font_size = 16;
line_width = 2;

% copter state data
t_copter = data.multirotor.ground_truth.odometry.NED.t';
pos_copter = data.multirotor.ground_truth.odometry.NED.pose.position';
rpy_copter = data.multirotor.euler.vec';
t_copter_rpy = data.multirotor.euler.t';



% ALTITUDE
command = zeros(length(t_copter), 1);

% find index where t == 5
[~, idx1] = min(abs(t_copter-5));
% find index where t == 10
[~, idx2] = min(abs(t_copter-10));

command(idx1:end,1) = 2.0;
% command(idx1:idx2-1,1) = 0.5;
% command(idx2:end) = 1.0;

figure(1), clf
plot(t_copter, -pos_copter(:,3), 'LineWidth', 2)
hold on
plot(t_copter, command, '--', 'LineWidth', 2)
axis([0 10 -0.2 2.4])
title('Altitude')
xlabel('Time (sec)')
ylabel('Altitude (m)')
legend('Altitude', 'Reference', 'Location', 'NorthWest')
grid on


% ROLL
% find index where t == 5
%[~, idx1] = min(abs(t_copter_rpy-5));
%t_copter_rpy = t_copter_rpy(idx1:end);
%t_copter_rpy = t_copter_rpy - t_copter_rpy(1);

%rpy_copter = rpy_copter(idx1:end,:);

command = zeros(length(t_copter_rpy), 1);

% find index where t == 2
[~, idx] = min(abs(t_copter_rpy-2));

command(idx:end) = 0.087;

figure(2), clf
plot(t_copter_rpy, rpy_copter(:,1), 'LineWidth', 2)
hold on
plot(t_copter_rpy, command, '--', 'LineWidth', 2)
axis([0 10 0 0.09])
title('Roll')
xlabel('Time (sec)')
ylabel('Phi (rad)')
legend('Phi', 'Reference', 'Location', 'SouthEast')
grid on

% PITCH
% find index where t == 4
[~, idx] = min(abs(t_copter_rpy-4));

command = zeros(length(t_copter_rpy), 1);
command(idx:end) = 0.087;

figure(3), clf
plot(t_copter_rpy, rpy_copter(:,2), 'LineWidth', 2)
hold on
plot(t_copter_rpy, command, '--', 'LineWidth', 2)
axis([0 10 -0.02 0.1])
yticks([-0.02 0 0.02 0.04 0.06 0.08 0.1])
title('Pitch')
xlabel('Time (sec)')
ylabel('Theta (rad)')
legend('Theta', 'Reference', 'Location', 'SouthEast')
grid on

% YAW
% find index where t == 6
[~, idx] = min(abs(t_copter_rpy-6));

command = zeros(length(t_copter_rpy), 1);
command(idx:end) = 0.087;

figure(4), clf
plot(t_copter_rpy, rpy_copter(:,3), 'LineWidth', 2)
hold on
plot(t_copter_rpy, command, '--', 'LineWidth', 2)
axis([0 10 -0.02 0.1])
yticks([-0.02 0 0.02 0.04 0.06 0.08 0.1])
title('Yaw')
xlabel('Time (sec)')
ylabel('Psi (rad)')
legend('Psi', 'Reference', 'Location', 'SouthEast')
grid on

% TRAJ
% find index where t == 10
[~, idx] = min(abs(t_copter-10));

pos_copter = pos_copter(1:idx,:);

figure(5), clf
plot3(pos_copter(:,1), pos_copter(:,2), -pos_copter(:,3), 'LineWidth', 2)
axis([-10 1 -5 20 0 2])
grid on
view(-133, 14)
xticks([-10 -5 0 1])
yticks([-5 0 5 10 15])
zticks([0 0.5 1 1.5 2])
xlabel('X pos')
ylabel('Y pos')
zlabel('-Z pos')
title('3D Path')



