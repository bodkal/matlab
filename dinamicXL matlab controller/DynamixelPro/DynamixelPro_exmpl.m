%% Close and Clear all
clear all;
close all;
try
instrreset;
catch
end
%% Open Connection
DynamixelProLibPath = '\Dynamixel-Pro-Library-for-Matlab-master\';
addpath( [pwd, DynamixelProLibPath] );
Mport = 'COM3';                 % motor port
M = serial(Mport);              % for the motor
set(M,'Baudrate',57600);        % set speed of communication at 1'000'000 bps
set(M,'StopBits',1);            % specify number of bits used to indicate end of byte
set(M,'DataBits',8);            % number of data bits to transmit (we use 8 bit data)
set(M,'Parity','none');         % no parity
fopen(M);                               % Connect serial port
run('Control_Table_Constants_XM')       % Load the control table constants


Angle_Measure = 1024:3072;
servo_ID_350 = 1;           
operation_mode = 1;             % [0,1,3,4,5,16] = [Current, Vel ,postion(0-360), position (multi-tum), current, PWM]
enable = 1;                     % enable torque
goal_vel = 20;            % from 0 to 4094

DynamixelPro_write(servo_ID_350,ADDRESS_OPERATING_MODE,operation_mode,BYTES_OPERATING_MODE,M);  % Set operation Mode
DynamixelPro_write(servo_ID_350,ADDRESS_TORQUE_ENABLE,enable,BYTES_TORQUE_ENABLE,M);            % set torque
DynamixelPro_write(servo_ID_350,ADDRESS_GOAL_VEL,goal_vel,BYTES_GOAL_VEL,M);               % Set position




enable = 0;
DynamixelPro_write(servo_ID_350,ADDRESS_TORQUE_ENABLE,enable,BYTES_TORQUE_ENABLE,M);            % set torque
fclose(M);              % close down motor
delete(M);              % close down motor

