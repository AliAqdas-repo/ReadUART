clc;clear all;close all
%%
imgs_data = csvread('test.csv');

%%
arduinoObj = serialport("COM8",115200);
pause(1)

%%

% View Images
img_t = imgs_data(212,:);
img   = reshape(img_t,28,28)';
imshow(img,'InitialMagnification',400)

%%
flush(arduinoObj)
len = 784;
for i=1:len
    write(arduinoObj,img_t(i),"uint8");
end

%%
write(arduinoObj,128,"uint8");
pause(1);

%%
% For Neural Network
rec_img = uint8(arduinoObj.read(1,"uint8"));

rec_time = uint8(arduinoObj.read(1,"uint8"));
rec_time2 = uint8(arduinoObj.read(1,"uint8"));
rec_time3 = uint8(arduinoObj.read(1,"uint8"));
rec_time4 = uint8(arduinoObj.read(1,"uint8"));

disp("Predicted Digit is: "+num2str(rec_img))
%%
% For Edge Detection
rec_img = uint8(arduinoObj.read(len,"uint8"));
imshow(reshape(rec_img,28,28)','InitialMagnification',400)