% LT Joshua Malia
% ME4823 - MRC
% .bag file data extraction plotting

clear;clc;close all

% Load bag file
bag = rosbag('../data/myturtle.bag');

% Select topic and creat timeseries
msg_pose = rosmessage('turtlesim/Pose');
showdetails(msg_pose);
bagselect = select(bag,'Topic','turtle1/pose');
ts = timeseries(bagselect,'X','Y','Theta','LinearVelocity','AngularVelocity');

X = ts.Data(:,1); Y = ts.Data(:,2); Theta = ts.Data(:,3);
LinearVelocity = ts.Data(:,4); AngularVelocity = ts.Data(:,5);

Time = ts.Time-ts.Time(1);

% XY Position Plot
figure(1);
    plot(X,Y);grid on
    xlabel('X Position []'); ylabel('Y Position []')
    title('turtle1 X/Y position')

figure(2);
    plot(Time,Theta);grid on
    xlabel('Time [s]'); ylabel('Theta [rad]')
    title('turtle1 Heading')

figure(3);
    U = LinearVelocity.*cos(Theta);
    V = LinearVelocity.*sin(Theta);
    ii = 1:10:length(X);
    quiver(X(ii),Y(ii),U(ii),V(ii)); grid on
    xlabel('X Position []'); ylabel('Y Position []')
    title('Quiver Plot turtle1/pose')

    
    