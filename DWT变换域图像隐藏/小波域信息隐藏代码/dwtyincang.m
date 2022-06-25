clc
clear all
close all
%%%%%%С����Ϣ����


file_name='��������9.bmp';%����ͼ��
im=imread(file_name);
[n1,n2,n3]=size(im);
if n3==3
im=rgb2gray(im);
end
save('im','im');

cover_object=double(im);
figure(1)
imshow(cover_object,[])
title('ԭʼͼ��')

mc=size(cover_object,1);
nc=size(cover_object,2);
file_name='������Ϣ.bmp';%���ص���Ϣͼ��
message=double(imread(file_name));

figure(2)
imshow(message,[])
title('������Ϣ')
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
title('��Ϣ���غ��ͼ��')
imwrite(watermarked_image_uint8,'��Ϣ���غ�.bmp','bmp');
%��ȡ���غ�ͼ���PSNR
xsz=mc*nc*max(max(cover_object.^2))/sum(sum((cover_object-watermarked_image_round).^2));
psnr=10*log10(xsz)




