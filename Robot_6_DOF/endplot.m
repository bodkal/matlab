function  endplot(t,line,Velocity,accel,totaltime)

figure;

subplot(3,1,1);
plot(t,line(1,:))
title("X Vs Time")
xlim([0 totaltime]);
xlabel('Time (sec)')
ylabel('Position (mm)')

subplot(3,1,2); 
plot(t,line(2,:))
title("Y Vs Time")
xlim([0 totaltime]);
xlabel('Time (sec)')
ylabel('Position (mm)')

subplot(3,1,3);
plot(t,line(3,:))
title("Z Vs Time")
xlim([0 totaltime]);
xlabel('Time (sec)')
ylabel('Position (mm)')

figure;
subplot(3,1,1);
plot(t,(Velocity(1,:)))
title("Vx Vs Time")
xlabel('Time (sec)')
ylabel('V (mm/sec)')
xlim([0 totaltime]);

subplot(3,1,2); 
plot(t,(Velocity(2,:)))
title("Vy Vs Time")
xlabel('Time (sec)')
ylabel('V (mm/sec)')
xlim([0 totaltime]);


subplot(3,1,3);
plot(t,(Velocity(3,:)))
title("Vz Vs Time")
xlim([0 totaltime]);
xlabel('Time (sec)')
ylabel('V (mm/sec)')
figure;

subplot(3,1,1);
plot(t,accel(1,:))
title("Ax Vs Time")
xlim([0 totaltime]);
xlabel('Time (sec)')
ylabel('A (mm/sec^2)')
subplot(3,1,2); 
plot(t,accel(2,:))
title("Ay Vs Time")
xlim([0 totaltime]);
xlabel('Time (sec)')
ylabel('A (mm/sec^2)')

subplot(3,1,3);
plot(t,accel(3,:))
title("Az Vs Time")
xlim([0 totaltime]);
xlabel('Time (sec)')
ylabel('A (mm/sec^2)')
end