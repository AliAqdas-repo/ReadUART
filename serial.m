clc;clear all;close all

im = uint8(csvread("test.txt"));
arduinoObj = serialport("COM4",115200);
pause(1)
%%
flush(arduinoObj)
len = 784;
write(arduinoObj,im(1:len),"uint8");
pause(1)
% write(arduinoObj,128,"uint8"); rec_img = uint8(arduinoObj.read(len,"uint8"));

%%
write(arduinoObj,128,"uint8");
rec_img = uint8(arduinoObj.read(len,"uint8"));
imshow(reshape(rec_img,28,28)','InitialMagnification',400)