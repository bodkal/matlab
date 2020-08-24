function  velplot(dt,t,teta)
for i=2:length(teta)
    v(:,i-1)=abs(teta(:,6,i)-teta(:,6,i-1))./dt(i-1);
end
for i=2:length(v)
    a(:,i)=(v(:,i)-v(:,i-1))./dt(i-1);
end


figure;
subplot(3,1,1);
plot(t,[0 v(1,:)])
title("Vx Vs Time")

subplot(3,1,2); 
plot(t,[0 v(2,:)])
title("Vy Vs Time")


subplot(3,1,3);
plot(t,[0 v(3,:)])
title("Vz Vs Time")

figure;

subplot(3,1,1);
plot(t,[0 a(1,:)])
title("ax Vs Time")

subplot(3,1,2); 
plot(t,[0 a(2,:)])
title("ay Vs Time")


subplot(3,1,3);
plot(t,[0 a(3,:)])
title("az Vs Time")

end