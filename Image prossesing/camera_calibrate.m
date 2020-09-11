function [Center_point]=camera_calibrate()
cam = webcam('C670i FHD Webcam')
cam.Resolution=cam.AvailableResolutions{22};
%%
imshow(snapshot(cam))
%%
RGB=(snapshot(cam));
%RGB = imread('picpic.jpeg');
%RGB=snapshot(cam);
I=rgb2hsv(RGB);
% Define thresholds for 'Hue'. Modify these values to filter out different range of colors.
channel1Min = 0.17;
channel1Max = 0.3;
% Define thresholds for 'Saturation'
channel2Min = 0.18;
channel2Max = 0.32;
% Define thresholds for 'Value'
channel3Min = 0.8;
channel3Max = 1;
% Create mask based on chosen histogram thresholds
BW = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
% Initialize output masked image based on input image.
maskedRGBImage = RGB;
se = strel('disk',10);
closeBW = imclose(BW,se);
BW=closeBW ;
 openBW=imopen(BW,se);
 BW=openBW;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
subplot(1,2,1);imshow(I);title('Original Image');
%subplot(1,3,2);imshow(BW);title('Mask');
subplot(1,2,2);imshow(maskedRGBImage);title('Filtered Image');
%% find center of mass
labeledImage = bwlabel(BW);
Center_point=regionprops(BW, 'Centroid')
%Center_point=cell2mat(struct2cell(measurements));