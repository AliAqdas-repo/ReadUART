
clc;clear all;close all
%%
imgs_data = csvread('test.csv');

%%

% View Images
img_t = imgs_data(241,:);
img   = reshape(img_t,28,28)';
imshow(img)

%%
% Write Images
csvwrite('test.txt',img_t);

%%
% View Images
new_img = csvread('test.txt');
% new_img = new_img(:);
img   = reshape(new_img,28,28)';
imshow(img)
