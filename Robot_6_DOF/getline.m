function [line,Velocity,accel]= getline(p_start,p_end,total_time)

dt=0.01;
N=total_time/dt;

N=total_time/dt;
T=(1:N)*dt;
T0=[0 T];
T1 = 0.2*total_time;
T2 = 0.8*total_time;
T3 = total_time;

mechane = -0.5*(T3^2)+T3*(T1+T2)+T1*T2-0.5*(T1^2)+0.5*(T2^2)-T2*(T1+T2);
a_i = (p_end-p_start) / mechane;
v_i=a_i*T1;
S1=@(t) p_start + 0.5*a_i*(t^2);
S2=@(t) S1(T1) + v_i*(t-T1);
S3=@(t) p_start+a_i*(-0.5*((t).^2)+(T1+T2)*(t)+(T1*T2)-0.5*(T1^2)+0.5*(T2^2)-T2*(T1+T2));

for i = 0:dt:(T1-dt)
    n = int16(i/dt+1);
    line(:,n) = p_start + 0.5*a_i*(i^2);
    Velocity(:,n)= a_i*i;  
    accel(:,n)= a_i; 
end

for i = T1:dt:(T2-dt)
    n = int16(i/dt+1);
    line(:,n) = S2(i);
    Velocity(:,n)= a_i*T1;
    accel(:,n)= 0; 
    
 for i = T2:dt:T3
    n = int16(i/dt+1);
    line(:,n) = S3(i);
    Velocity(:,n)= a_i*(T1-(i-T2)); 
    accel(:,n)= -a_i;
end
end
end