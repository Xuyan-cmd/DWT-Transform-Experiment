%%%%%%%%%%%

clc;
clear all;
close all

%��Ϣ������ȡ

file_name='������Ϣ.bmp';
message=double(imread(file_name));
mm=size(message,1);
nm=size(message,2);
%%%%%%%%%%%



file_name='��Ϣ���غ�.bmp';
watermarked_image=imread(file_name);

figure;
imshow(watermarked_image);
title('������Ϣ��ͼ��')
mw=size(watermarked_image,1);
nw=size(watermarked_image,2);

%��ͼ�����������У�������Ϣ�ָ����
watermarked_image(80:60,80:80)=255;
watermarked_image(130:150,130:150)=255;
figure;
imshow(watermarked_image);
title('���к��������Ϣͼ��')


watermarked_image=double(watermarked_image);
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
title('�ָ�����������Ϣ')

%����ָ������Ϣͼ����ԭ��Ϣͼ������ܲ�����
file_name='������Ϣ.bmp';%���ص���Ϣͼ��
message=double(imread(file_name));
xsz=mm*mm*max(max(message.^2))/sum(sum((message-watermark).^2));
psnr=10*log10(xsz)
MSE=sum(sum((message-watermark).^2))/mm/mm




