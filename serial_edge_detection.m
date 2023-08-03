clc;clear all;close all
%%
imgs_data = csvread('test.csv');

%%
arduinoObj = serialport("COM8",115200);
pause(1)

%%
clc;close all;
while(1)
% View and Send Image
    img_t = imgs_data(randi(28000),:);
    img   = reshape(img_t,28,28)';
    imshow(img,'InitialMagnification',400)
    pause(1);
    
    flush(arduinoObj)
    len = 784;
    for i=1:len
        write(arduinoObj,img_t(i),"uint8");
    end
% Recieve Filtered Image   
    write(arduinoObj,128,"uint8");
    rec_img = uint8(arduinoObj.read(len-7,"uint8"));
    imshow(reshape([rec_img,zeros(1,7)],28,28)','InitialMagnification',400)
    
    rec_time = uint8(arduinoObj.read(1,"uint8"));
    rec_time2 = uint8(arduinoObj.read(1,"uint8"));
    rec_time3 = uint8(arduinoObj.read(1,"uint8"));
    rec_time4 = uint8(arduinoObj.read(1,"uint8"));
    time_taken_vector = 40e-9*(double(rec_time)+double(rec_time2)*256+double(rec_time3)*256*256+double(rec_time4)*256*256*256);
    disp("Time Taken Vector: "+num2str(time_taken_vector));
    
    rec_time = uint8(arduinoObj.read(1,"uint8"));
    rec_time2 = uint8(arduinoObj.read(1,"uint8"));
    rec_time3 = uint8(arduinoObj.read(1,"uint8"));
    rec_time4 = uint8(arduinoObj.read(1,"uint8"));
    time_taken_scalar = 40e-9*(double(rec_time)+double(rec_time2)*256+double(rec_time3)*256*256+double(rec_time4)*256*256*256);
    disp("Time Taken Scalar: "+num2str(time_taken_scalar));
    disp("Speed Up of "+ num2str(time_taken_scalar/time_taken_vector) + " Times");
    pause(2);
    close all;
end