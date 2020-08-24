try
delete(instrfindall);
catch
end
%hw.set_position( 1,0); %run by tiks [0,1022]=[0,299] deg 
%pause(1);
ard=serial_matlab("COM3",1)

%hw.set_mode_wheel(1)
while(1==1)
    data=serial_matlab("COM17",0,ard);
    disp(data);
end


