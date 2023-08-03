clc;clear all;close all
%%
imgs_data = csvread('test.csv');

%%
arduinoObj = serialport("COM8",115200);
pause(1)

%%
clc;close all;
while(1)
    % View Images
    img_t = imgs_data(randi(28000),:);
    img   = reshape(img_t,28,28)';
    imshow(img,'InitialMagnification',400)
    pause(1);
    flush(arduinoObj)
    len = 784;
    for i=1:len
        write(arduinoObj,img_t(i),"uint8");
    end
% Recieving the Prediction
    write(arduinoObj,128,"uint8");
    % For Neural Network
    rec_img = uint8(arduinoObj.read(1,"uint8"));
    
    rec_time = uint8(arduinoObj.read(1,"uint8"));
    rec_time2 = uint8(arduinoObj.read(1,"uint8"));
    rec_time3 = uint8(arduinoObj.read(1,"uint8"));
    rec_time4 = uint8(arduinoObj.read(1,"uint8"));
    
    disp("Predicted Digit is: "+num2str(rec_img))
    disp("Time Taken: "+num2str(40e-9*(double(rec_time)+double(rec_time2)*256+double(rec_time3)*256*256+double(rec_time4)*256*256*256)));
    pause(2);
    close all;
end