function [xyz]= setxyz(A)
x=[1 0 0 1];
y=[0 1 0 1];
z=[0 0 1 1];
xyz=[A*x' A*y' A*z'];
return;
end