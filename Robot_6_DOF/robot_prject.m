clear all;
clc;
mainprogram;

function mainprogram
global userchoice;                                                          %define the global variable userchoice so it could be use in this function
userchoice.option='f';                                                      %put an initial value to the userchoice.option cell
mainmenu;                                                                   %call mainmenu (menu pops and activated)
%wait for the user to choose an option
while (userchoice.option=='f')
    pause(0.1);
end
%call the game option functions accordint to user's choice
switch userchoice.option
    case 'e'
    case 's'
        simulation
end
end

function mainmenu

global userchoice;                                                          %difined a global struct which would store the user choices
userchoice.speed=1;                                                         %determine defult speed choice

%create a figure which includs the menu and define it's design
fmenu = figure('name','MAIN MENU','NumberTitle','off','WindowStyle',...
    'modal','pos',[520 190 350 400],'color',[0.55 0.5 0.3]);
headline=annotation('textbox',[.28 .75 .2 .2],'string',...
    '!! ROBOTIC ARM !!','FitBoxToText','on');
headline.FontSize=12;


% Create a push button for starting simulation
 uicontrol('Style', 'pushbutton', 'String',...            %button design, location and fuction link
    'SIMULATION','Position', [120 300 120 40],'Callback', @simulationgame);

% Create a multiply scrolled option menu
 uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'insert time in [sec]'},...
    'Position', [120 260 120 20],'Callback', @speedset);

annotation('textbox',[.18 .40 .2 .2],'string',...
    'Start','FitBoxToText','on');
% Create a multiply scrolled option menu
uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'x'},...
    'Position', [70 180 40 20],'Callback', @xss);
% Create a multiply scrolled option menu
uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'y'},...
    'Position', [70 150 40 20],'Callback', @yss);
% Create a multiply scrolled option menu
uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'z'},...
    'Position', [70 120 40 20],'Callback', @zss);

annotation('textbox',[.42 .40 .2 .2],'string',...
    'end','FitBoxToText','on');
% Create a multiply scrolled option menu
uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'x'},...
    'Position', [150 180 40 20],'Callback', @xee);
% Create a multiply scrolled option menu
uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'y'},...
    'Position', [150 150 40 20],'Callback', @yee);
% Create a multiply scrolled option menu
uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'z'},...
    'Position', [150 120 40 20],'Callback', @zee);

annotation('textbox',[.66 .40 .2 .2],'string',...
    'Orientation','FitBoxToText','on');

% Create a multiply scrolled option menu
uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'Roll'},...
    'Position', [250 180 40 20],'Callback', @xorint);
% Create a multiply scrolled option menu
uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'pitch'},...
    'Position', [250 150 40 20],'Callback', @yorint);
% Create a multiply scrolled option menu
uicontrol('Style', 'edit',...                                %scrolled menu design, location and fuction link
    'String', {'Yaw'},...
    'Position', [250 120 40 20],'Callback', @zorint);


% Create an exit button
exitbutton = uicontrol('Style', 'pushbutton', 'String', 'EXIT',...          %button design, location and fuction link
    'Position', [120 40 120 50],'Callback', @exitgame);
%when user push the start button- put 'g' to userchoice.option
    function startgame(source,event)
        userchoice.option='g';
        close(gcf);                                                         %close figure
    end
%when user choose speed- update the userchoice.speed value
    function speedset(source,event)
        userchoice.speed=source.String;
    end
    function xss(source,event)
        userchoice.xss=source.String;
    end
    function yss(source,event)
        userchoice.yss=source.String;
    end
    function zss(source,event)
        userchoice.zss=source.String;
    end
    function xee(source,event)
        userchoice.xee=source.String;
    end
    function yee(source,event)
        userchoice.yee=source.String;
    end
    function zee(source,event)
        userchoice.zee=source.String;
    end

    function xorint(source,event)
        userchoice.xori=source.String;
    end
    function yorint(source,event)
        userchoice.yori=source.String;
    end
    function zorint(source,event)
        userchoice.zori=source.String;
    end

%when user push the simulation button- put 's' to userchoice.option
    function simulationgame(source,event)
        userchoice.option='s';
        close(gcf);                                                         %close figure
    end
    function exitgame(source,event)
        userchoice.option='e';
        close(gcf);                                                         %close figure
    end
end

function simulation
global userchoice; 
linecolors=['y','g','m'];
t(1)=0;%difined a global struct which would store the user choices
q=[0 0 0 1]';
h=5;
L6 = 10;
pason=false;
Ax =@(t) [ 1, 0,        0,       0;...
           0, cosd(t), -sind(t), 0;...
           0, sind(t),  cosd(t), 0;...
           0, 0,        0,       1];

Rx=@(t) [  1, 0,        0       ;...
           0, cosd(t), -sind(t);...
           0, sind(t),  cosd(t)]    
       
Ay =@(t) [  cosd(t), 0, sind(t), 0;...
           0,        1, 0,       0;...
           -sind(t), 0, cosd(t), 0;...
           0,        0,       0, 1];

Ry =@(t) [  cosd(t), 0, sind(t) ;...
           0,        1, 0       ;...
           -sind(t), 0, cosd(t)]
       
Az =@(t) [ cosd(t), -sind(t), 0, 0;...
           sind(t),  cosd(t), 0, 0;...
           0,        0,       1, 0;...
           0,        0,       0, 1];
 
Rz =@(t) [ cosd(t), -sind(t), 0;...
           sind(t),  cosd(t), 0;...
           0,        0,       1;];      


Ad = @(x,y,z) [1, 0, 0, x;...
               0, 1, 0, y;...
               0, 0, 1, z;...
               0, 0, 0, 1];
 
totaltime=str2double(cell2mat(userchoice.speed));           

 [line,Velocity,accel]= getline([str2double(cell2mat(userchoice.xss)),str2double(cell2mat(userchoice.yss)),str2double(cell2mat(userchoice.zss))]...
     ,[str2double(cell2mat(userchoice.xee)),str2double(cell2mat(userchoice.yee)),str2double(cell2mat(userchoice.zee))]...
     ,totaltime);
   
x=line(1,:);
y=line(2,:);
z=line(3,:);
pol=polyfit(x,y,1)
if( abs(pol(2))<10^-5)
 pason=true;   
end


%time=str2double(cell2mat(userchoice.speed))/442;
%time=0.5;
ori=[str2double(cell2mat(userchoice.xori)) str2double(cell2mat(userchoice.yori)) str2double(cell2mat(userchoice.zori))];     %final orientation matrix

for i=1:length(x)
point=[x(i) y(i) z(i)];     
A06=Ax(ori(1))*Ay(ori(2))*Az(ori(3));
Pc = Ad(point(1),point(2),point(3))*A06*[0,0,-L6,1]';

R06 = A06(1:3,1:3);


t1=atan2d(Pc(1),Pc(2));
A01=Az(-t1)*Ad(0, 0 ,5);
t2=atan2d(norm([Pc(1),Pc(2)]),(Pc(3)-h));
teta(2,i)=-t2;
R03 = Rz(-t1)*Rx(-t2);
teta(1,i)=-t1;
line0=[0 0 0 0]';
line1=A01*q;
xyz(1,:,:,i)=setxyz(Az(-t1));
xyz(2,:,:,i)=setxyz(A01*Ax(-t2));

d=norm(Pc(1:3)-line1(1:3));
teta(3,i)=d;
A12=Ax(-t2)*Ad(0,0,d);
line2=A01*A12*q;
A02=A01*A12;


R36=R03'*R06;
st5=sind(sqrt(R36(1,3)^2+R36(2,3)^2));

if(st5>0)
    t5=atan2d(sqrt(R36(1,3)^2+R36(2,3)^2),-R36(3,3));
    t4=atan2d(R36(2,3)/st5,R36(1,3)/st5);
    t6=atan2d(-R36(3,2)/st5,R36(3,1)/st5);
elseif(st5<0)
    st5=-st5;
    t5=atan2d(-sqrt(R36(1,3)^2+R36(2,3)^2),-R36(3,3));
    t4=atan2d(R36(2,3)/st5,R36(1,3)/st5);
    t6=atan2d(-R36(3,2)/st5,R36(3,1)/st5);
else
    if(i==1)
    t4=rand(1)*90;
    else
        t4=teta(4,i-1);
    end
    t5=0;
    t6=atan2d(R36(2,1),R36(1,1))-t4
end

 teta(4,i)=t4;
 teta(5,i)=t5;
 teta(6,i)=t6;
if(pason)
 teta(4,i)=abs(t4);
 teta(5,i)=t5;
 teta(6,i)=t6;
end



A34=A02*Az(t4);
line3=A34*q;
xyz(3,:,:,i)=setxyz(A34);

A45=A34*Ax(90)*Az(t5);
line4=A45*q;

xyz(4,:,:,i)=setxyz(A45);

xyz(5,:,:,i)=setxyz(A45*Ax(90)*Az(t6));

A56=A45*Ax(90)*Az(t6)*Ad(0,0,10);
line5=A56*q;
xyz(6,:,:,i)=setxyz(A56);

all(:,:,i)=[line0(1:3) line1(1:3) line2(1:3) line3(1:3) line4(1:3) line5(1:3) ];
end

figure(1);
h=plot3([0 0],[0 ,0],[0,0]);
h2=plot3([0 0],[0 ,0],[0,0]);
plot3([x(1) x(length(x))],[y(1) y(length(y))],[z(1) z(length(z))],'r')
xlabel("X");
ylabel("Y");
zlabel("Z");

%  xlim([-100 100]);
%  ylim([-100 100]);
%  zlim([-100 100]);
hold on;
grid on;

for j=1:length(all)
t(j)=0.01*j;
delete(h);
delete(h2);
for i=1:5
h(i)=plot3([all(1,i,j),all(1,i+1,j)],[all(2,i,j),all(2,i+1,j)],[all(3,i,j),all(3,i+1,j)],'b','LineWidth',1);

end
for i=1:6
for k=1:3
h2(k,i)= plot3([all(1,i,j) xyz(i,1,k,j)],[all(2,i,j) xyz(i,2,k,j)],[all(3,i,j) xyz(i,3,k,j)],linecolors(k),'LineWidth',2);
end
end
title(sprintf('Time: %.1f [sec]', 0.01*(j-1)));
drawnow;
end

%  workspaseplot(t,[x;y;z],totaltime)
 jointsplot(t,teta,totaltime);
 endplot(t,line,Velocity,accel,totaltime);
end
