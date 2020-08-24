function  workspaseplot(t,teta,totaltime)
figure;

subplot(3,1,1);
plot(t,teta(1,:))
title("X Vs Time")
xlim([0 totaltime]);

subplot(3,1,2); 
plot(t,teta(2,:))
title("Y Vs Time")
xlim([0 totaltime]);

subplot(3,1,3);
plot(t,teta(3,:))
title("Z Vs Time")
xlim([0 totaltime]);

end