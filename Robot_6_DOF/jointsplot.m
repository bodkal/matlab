function  jointsplot(t,teta,totaltime)
for j=1:6
for i=2:length(teta)
    vel(j,i)= (teta(j,i)- teta(j,i-1))/0.01;
end
end

for j=1:6
for i=2:length(vel)
    acc(j,i)= (vel(j,i)- vel(j,i-1))/0.01;
end
end

figure('name','joint q1');
subplot(3,1,1);
plot(t,teta(1,:))
title("Angel Vs Time")
xlabel('Time (sec)')
ylabel('Angle (deg)')
xlim([0 totaltime]);
subplot(3,1,2);
plot(t,(vel(1,:)))
title("Velocity  Vs Time")
xlabel('Time (sec)')
ylabel('w (deg/sec)')
xlim([0 totaltime]);
subplot(3,1,3); 
plot(t,(acc(1,:)))
title("accel Vs Time")
xlabel('Time (sec)')
ylabel('A (deg/sec^2)')
xlim([0 totaltime]);

figure('name','joint q2');
subplot(3,1,1);
plot(t,teta(2,:))
title("Angel  Vs Time")
xlabel('Time (sec)')
ylabel('Angle (deg)')
xlim([0 totaltime]);
subplot(3,1,2);
plot(t,(vel(2,:)))
title("Velocity Vs Time")
xlabel('Time (sec)')
ylabel('w (deg/sec)')
xlim([0 totaltime]);
subplot(3,1,3); 
plot(t,acc(2,:))
title("accel Vs Time")
xlabel('Time (sec)')
ylabel('A (deg/sec^2)')
xlim([0 totaltime]);


figure('name','joint q3');
subplot(3,1,1);
plot(t,teta(3,:))
title("Length Vs Time")
xlabel('Time (sec)')
ylabel('Length (mm)')
xlim([0 totaltime]);
subplot(3,1,2);
plot(t,(vel(3,:)))
title("Velocity  Vs Time")
xlabel('Time (sec)')
ylabel('V (mm/sec)')
xlim([0 totaltime]);
subplot(3,1,3); 
plot(t,acc(3,:))
title("accel Vs Time")
xlabel('Time (sec)')
ylabel('A (mm/sec^2)')
xlim([0 totaltime]);

figure('name','joint q4');
subplot(3,1,1);
plot(t,teta(4,:))
title("Angel  Vs Time")
xlabel('Time (sec)')
ylabel('Angle (deg)')
xlim([0 totaltime]);
subplot(3,1,2);
plot(t,(vel(4,:)))
title("Velocity  Vs Time")
xlabel('Time (sec)')
ylabel('w (deg/sec)')
xlim([0 totaltime]);
subplot(3,1,3); 
plot(t,acc(4,:))
title("accel  Vs Time")
xlabel('Time (sec)')
ylabel('A (deg/sec^2)')
xlim([0 totaltime]);

figure('name','joint q5');
subplot(3,1,1);
plot(t,teta(5,:))
title("Angel  Vs Time")
xlabel('Time (sec)')
ylabel('Angle (deg)')
xlim([0 totaltime]);
subplot(3,1,2);
plot(t,(vel(5,:)))
title("Velocity  Vs Time")
xlabel('Time (sec)')
ylabel('w (deg/sec)')
xlim([0 totaltime]);
subplot(3,1,3); 
plot(t,acc(5,:))
title("accel  Vs Time")
xlabel('Time (sec)')
ylabel('A (deg/sec^2)')
xlim([0 totaltime]);

figure('name','joint q6');
text(0.9,0.5,'joint q6');
subplot(3,1,1);
plot(t,teta(6,:))
title("Angel  Vs Time")
xlabel('Time (sec)')
ylabel('Angle (deg)')
xlim([0 totaltime]);
subplot(3,1,2);
plot(t,(vel(6,:)))
title("Velocity  Vs Time")
xlabel('Time (sec)')
ylabel('w (deg/sec)')
xlim([0 totaltime]);
subplot(3,1,3); 
plot(t,acc(6,:))
title("accel Vs Time")
xlabel('Time (sec)')
ylabel('A (deg/sec^2)')
xlim([0 totaltime]);
end