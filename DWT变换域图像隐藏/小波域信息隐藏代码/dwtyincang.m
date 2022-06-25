clc
clear all
close all
%%%%%%小波信息隐藏


file_name='测试用例9.bmp';%载体图像
im=imread(file_name);
[n1,n2,n3]=size(im);
if n3==3
im=rgb2gray(im);
end
save('im','im');

cover_object=double(im);
figure(1)
imshow(cover_object,[])
title('原始图像')

mc=size(cover_object,1);
nc=size(cover_object,2);
file_name='隐藏信息.bmp';%隐藏的信息图像
message=double(imread(file_name));

figure(2)
imshow(message,[])
title('隐藏信息')
mm=size(message,1);
nm=size(message,2);
[ca,ch,cv,cd]=dwt2(cover_object,'haar');
ca1=ca;
% m=moviein(30);
qiangdu=1;
% for qiangdu=1:30
for i=1:nm
    for j=1:nm
        if(message(i,j)==0)
            ca1(i,j)=ca(i,j)+qiangdu;
        end
    end
end
watermarked_image=idwt2(ca1,ch,cv,cd,'haar');
watermarked_image_round=round(watermarked_image);
watermarked_image_uint8=uint8(watermarked_image_round);

figure(3)
imshow(watermarked_image_uint8,[])
title('信息隐藏后的图像')
imwrite(watermarked_image_uint8,'信息隐藏后.bmp','bmp');
%读取隐藏后图像的PSNR
xsz=mc*nc*max(max(cover_object.^2))/sum(sum((cover_object-watermarked_image_round).^2));
psnr=10*log10(xsz)




