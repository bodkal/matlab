function []=ImageHoming()
% this function doing homing to ijig while it considered the Ijig is
% located with the fixed point infront the linear sys
%% define camera
if (exist('cam') == 0)         %check if webcam is already active
cam=webcam('C670i FHD Webcam')  % define lofitech c670 camera
end
cam.Resolution=cam.AvailableResolutions{22}; %increase the resulotion
%% void loop
x=1;% for real time homing
while (x)
 ii=1;   
 I=snapshot(cam); %take 1 frame
 matrix_point=cell2mat((struct2cell(PImage(I)))'); %use PImage to get matrix of area center of the markers
 while (length(matrix_point)~=6) % loking for 6 markers if they not exist the code will try again
 I=snapshot(cam);
 matrix_point=cell2mat((struct2cell(PImage(I)))');
 ii=ii+1;
 if ii>100 % give worning if camera cant detect 6 bodys for too long.
     disp('Worning consider calibrate the camera markers!!');
 end
 end
 %% Ijig center detection
center_image=flip(size(I(:,:,1))./2);  %detect the center of the image 
check_distance=vecnorm((matrix_point-center_image),2,2);%check the distance between all the points to the center
[val,num]=min(check_distance);% the min distace is the center of the IJIG
Ijig_center=matrix_point(num,:)%define IJIG center
matrix_point(num,:)=[];%remove IJIG center from the matrix_point
%% linear system detection by same metod
check_distance=vecnorm((matrix_point-Ijig_center),2,2);%
[val,num]=max(check_distance); % the farest point from the IJIG center is the linear sys.
Linear_sys=matrix_point(num,:)
matrix_point(num,:)=[];
%% end of finger_1 detection by same metod
check_distance=vecnorm((matrix_point-Linear_sys),2,2);
[val,num]=min(check_distance);% the closest point to the lnear system is the end of finger 1
End_fixed_finer=matrix_point(num,:)
matrix_point(num,:)=[];

%% finger_1 detection by same metod
check_distance=vecnorm((matrix_point-End_fixed_finer),2,2);
[val,num]=min(check_distance);% the closest point to end of finger1 is finger 1
Finger_1=matrix_point(num,:);
matrix_point(num,:)=[];
%% angles analize
% get the angle of the linear_system in refercnce to the center if the ijig
angle_linear=180-atan2d(Linear_sys(2)-Ijig_center(2),Linear_sys(1)-Ijig_center(1));
if angle_linear>300 %check if the angke is negative and covert it to negative if needed
    angle_linear=360-angle_linear;
end
angle_finger_1=180-atan2d(Finger_1(2)-Ijig_center(2),Finger_1(1)-Ijig_center(1));% angle of finger_1
angle_finger_1=angle_finger_1-angle_linear;% correct the angle of finger 1
matrix_point=matrix_point-Ijig_center;%Set the center of the ijig as the center of the image
angle_finger=180-atan2d(matrix_point(:,2),matrix_point(:,1))% get the angles of finger 2,3
[val,num]=sort(angle_finger);% sorting the rest fingers by the angles
angle_finger=sort(angle_finger);
angle_finger=angle_finger-angle_linear;% correct the fingers angle with in refernce to the lingear system
matrix_point=matrix_point(num,:);%sort the matrix by the index founded
matrix_point=matrix_point+Ijig_center;%Set back the center of the image
%define fingers 2,3
Finger_2=matrix_point(1,:);
Finger_3=matrix_point(2,:);
%% fingers distance
% caliberate the distance by known distance
dis_calibrate=vecnorm((Ijig_center-End_fixed_finer),2,2)
%distance by soildwotks=(378+368)/2=373
dis_ratio=373/dis_calibrate
%define finger 1,2,3 distances from the center of the Ijig
Finger_1_dis=dis_ratio*vecnorm((Finger_1-Ijig_center),2,2);
Finger_2_dis=dis_ratio*vecnorm((Finger_2-Ijig_center),2,2);
Finger_3_dis=dis_ratio*vecnorm((Finger_3-Ijig_center),2,2);
%% present the data on the image
 I=insertShape(I,'circle',[Ijig_center,35], 'Color', {'red'},'LineWidth',5);
 I=insertText(I,[Ijig_center(1),Ijig_center(2)-80],'Center IJIG');
 I=insertShape(I,'circle',[Linear_sys,35], 'Color', {'red'},'LineWidth',5);
 I=insertText(I,[Linear_sys(1),Linear_sys(2)-80],'Linear_system'); 
 I=insertShape(I,'circle',[End_fixed_finer,35], 'Color', {'red'},'LineWidth',5);
 I=insertText(I,[End_fixed_finer(1),End_fixed_finer(2)-80],'End_fixed_finger');  
 I=insertShape(I,'circle',[Finger_1,35], 'Color', {'red'},'LineWidth',5);
 I=insertText(I,[Finger_1(1),Finger_1(2)-80],'Finger_1'); 
 str_finger1 = ['angle=' num2str(angle_finger_1,'%0.2f') '[deg]|Radius='...
    num2str(Finger_1_dis,'%0.2f') '[mm]'];
 I=insertText(I,[Finger_1(1)-250,Finger_1(2)+50],str_finger1,'FontSize',18);
 I=insertShape(I,'circle',[Finger_2,35], 'Color', {'red'},'LineWidth',5);
 I=insertText(I,[Finger_2(1),Finger_2(2)-80],'Finger_2');
str_finger2 = ['angle=' num2str(angle_finger(1),'%0.2f') '[deg]|Radius='...
    num2str(Finger_2_dis,'%0.2f') '[mm]'];
 I=insertText(I,[Finger_2(1)-400,Finger_2(2)],str_finger2,'FontSize',18);
 I=insertShape(I,'circle',[Finger_3,35], 'Color', {'red'},'LineWidth',5);
 I=insertText(I,[Finger_3(1),Finger_3(2)-80],'Finger_3');
 str_finger3 = ['angle=' num2str(angle_finger(2),'%0.2f') '[deg]|Radius='...
    num2str(Finger_3_dis,'%0.2f') '[mm]'];
  I=insertText(I,[Finger_3(1)-400,Finger_3(2)],str_finger3,'FontSize',18);
imshow(I);
x=1; %% set x=0 for 1 time loop 
end
