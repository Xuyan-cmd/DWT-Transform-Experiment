%%%%%%%%%%%

clc;
clear all;
close all

%信息隐藏提取

file_name1='隐藏信息.bmp';
message=double(imread(file_name1));
mm=size(message,1);
nm=size(message,2);
%%%%%%%%%%%



file_name2='信息隐藏后.bmp';
watermarked_image=double(imread(file_name2));

figure;
imshow(uint8(watermarked_image));
title('隐藏信息的图像')
mw=size(watermarked_image,1);
nw=size(watermarked_image,2);
[ca1,ch1,cv1,cd1]=dwt2(watermarked_image,'haar');

temp=load('im.mat');
cover_object=temp.im;
[ca2,ch2,cv2,cd2]=dwt2(cover_object,'haar');
watermarkr=ca1-ca2;

watermark=ones(mm);
for i=1:mm
    for j=1:nm
        if(watermarkr(i,j)~=0)
        watermark(i,j)=0;
        end
    end
end
watermark1=uint8(watermark);
figure
imshow(watermark1,[]);
title('恢复出的隐藏信息')

%计算恢复后的信息图像与原信息图像的性能参数：
file_name='隐藏信息.bmp';%隐藏的信息图像
message=double(imread(file_name));
xsz=mm*mm*max(max(message.^2))/sum(sum((message-watermark).^2));
psnr=10*log10(xsz)
MSE=sum(sum((message-watermark).^2))/mm/mm




