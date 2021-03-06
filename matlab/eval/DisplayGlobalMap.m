clear all; close all; clc;
im = {};
GTGlobalmap = {};
GTLocalmap = {};

W=1500;
A=32;
scale = 0.06;
tfGM = affine2d();
FW = 250;
M = zeros(W,W);
w=5;
load(['pose/poseTBWorld' num2str(w) '.mat']);
%prefixGMP = ['/media/mengmi/TOSHIBA EXT/3DGAN/Nav3D_dataset/World' num2str(w) '/map_global/map_'];
prefixGMPR = ['/media/mengmi/TOSHIBA EXT/3DGAN/Nav3D_dataset/TBworld' num2str(w) '/map_global_all_converted/map_'];
prefixGMPR1 = ['/media/mengmi/TOSHIBA EXT/3DGAN/Nav3D_dataset/TBworld' num2str(w) '/map_global_all_converted/Mmap_'];

px = pose(:,2)/scale;
py = pose(:,3)/scale;
pw = pose(:,4); 

counter = 1;
v = VideoWriter('/home/mengmi/Desktop/IROS');
v.getProfiles()

hb = figure;
set(hb,'Position',[680         345        1228         573]);
open(v);
fontsize = 20;
for i  =1:3:1410
    i
    subplot(2,4,1);
    oriimgname = ['/media/mengmi/TOSHIBA EXT/3DGAN/Nav3D_dataset/TBworld5/camera_wd/camera_' num2str(i) '.jpg'];
    oriimg = imread(oriimgname);
    oriimg = imresize(oriimg, [300 300]);
    imshow(oriimg);
    title('camera view');
    cameraimg = oriimg;
    cameraimg = insertText(cameraimg, [1 1], ['camera'],'FontSize',fontsize,'BoxColor', 'red','BoxOpacity',0.9,'TextColor','white');
        
    
    
    img = imread(['/media/mengmi/TOSHIBA EXT/3DGAN/Nav3D_dataset/TBworld' num2str(5) '/map_converted/map_' num2str(i) '_1.jpg']);            
    img = imresize(img, [300 300]);
    img = mat2gray(img);
    img = im2bw(img, 0.6);
    subplot(2,4,2);    
    imshow(img);
    title('ground truth at current time')
    img = uint8(img)*256;
    img = cat(3, img, img, img);
    GTCurrentmap = img;
    GTCurrentmap = insertText(GTCurrentmap, [1 1], ['GTcurrent'],'FontSize',fontsize,'BoxColor', 'yellow','BoxOpacity',0.9,'TextColor','white');
        
    
    oriimgname = ['/media/mengmi/TOSHIBA EXT/3DGAN/Nav3D_dataset/TBworld5/map_global_all_converted/map_1_' num2str(i) '.jpg'];
    oriimg = imread(oriimgname);
    oriimg = imresize(oriimg, [300 300]);    
    subplot(2,4,3);    
    imshow(oriimg);
    hold on;
    plot(150,150, 'r*');
    title('ground truth local')
    oriimg = cat(3, oriimg, oriimg, oriimg);
    oriimg = flipdim(oriimg ,2);
    GTLocalmap = oriimg;
    GTLocalmap = insertText(GTLocalmap, [1 1], ['GTlocal'],'FontSize',fontsize,'BoxColor', 'blue','BoxOpacity',0.9,'TextColor','white');
     
    
    subplot(2,4,4);
    oriimgname = ['/media/mengmi/TOSHIBA EXT/3DGAN/Nav3D_dataset/TBworld5/map_global_all_converted/Mmap_1_' num2str(i) '.jpg'];
    oriimg = imread(oriimgname);
    oriimg = imresize(oriimg, [300 300]);
    oriimg = oriimg(50 :240, 100:270,:);
    oriimg = imresize(oriimg, [300 300]);
    imshow(oriimg);
    %hold on;
    %plot(150,150, 'r*');
    %hold off;
    title('ground truth global')
    oriimg = cat(3, oriimg, oriimg, oriimg);
    GTGlobalmap = oriimg;
    GTGlobalmap = insertText(GTGlobalmap, [1 1], ['GTglobal'],'FontSize',fontsize,'BoxColor', 'green','BoxOpacity',0.9,'TextColor','white');
     
    
    
    img = imread(['../results/IROSvis/local' num2str(i) '.jpg']);
    img = imresize(img, [300 300]);
    subplot(2,4,6);
    imshow(mat2gray(img));
    title(['predicted at current time']);
    img = cat(3, img, img, img);
    predCurrentmap = img;
    predCurrentmap = insertText(predCurrentmap, [1 1], ['PredCurrent'],'FontSize',fontsize,'BoxColor', 'yellow','BoxOpacity',0.9,'TextColor','white');
     
    
    img = imread(['../results/IROSvis/globallocal' num2str(i) '.jpg']);            
    img = imresize(img, [300 300]);
    %img = mat2gray(img);
    %img = im2bw(img, 0.6);
    subplot(2,4,7);    
    imshow(img);
    hold on;
    plot(150,150, 'r*');
    title('predicted local')
    %img = uint8(img)*256;
    img = cat(3, img, img, img);
    img = flipdim(img ,2);
    predLocalmap = img;
    predLocalmap = insertText(predLocalmap, [1 1], ['PredLocal'],'FontSize',fontsize,'BoxColor', 'blue','BoxOpacity',0.9,'TextColor','white');
     
    
    img = imread(['../results/IROSvis/global' num2str(i) '.jpg']);
    img = imresize(img, [300 300]);
    img = img(50 :240, 100:270,:);
    img = imresize(img, [300 300]);
    subplot(2,4,8);
    imshow(mat2gray(img));
    title(['predicted global']); 
    img = cat(3, img, img, img);
    predGlobalmap = img;
    predGlobalmap = insertText(predGlobalmap, [1 1], ['PredGlobal'],'FontSize',fontsize,'BoxColor', 'green','BoxOpacity',0.9,'TextColor','white');
     
    
    
%    tightfig;
%     width = 10;
%     swh = 300;
%     I = uint8(256*ones(swh+2*width,swh+2*width,3,7));
%     
%     I(width+1:swh+width,width+1:swh+width,:,1) = cameraimg;
%     I(width+1:swh+width,width+1:swh+width,:,2) = GTCurrentmap;
%     I(width+1:swh+width,width+1:swh+width,:,3) = GTLocalmap;
%     I(width+1:swh+width,width+1:swh+width,:,4) = GTGlobalmap;
%     I(width+1:swh+width,width+1:swh+width,:,5) = predCurrentmap;
%     I(width+1:swh+width,width+1:swh+width,:,6) = predLocalmap;
%     I(width+1:swh+width,width+1:swh+width,:,7) = predGlobalmap;
%     I = mat2gray(I);
%     figure;
%     img = montage(I,'Size', [1 7]);
%     frame = getframe(gca); 

    frame = getframe(1); 
    frame = imresize(frame2im(frame),[320 780]);
    imshow(frame);
    im{counter} = frame;
    %im{counter} = imresize(img,[480 640]);
    writeVideo(v,im{counter});
    counter = counter+1; 
%     im{i} = img;
%     subplot(2,3,4);
%     imshow(img);
    
   % pause;
    
    
end
   
close(v);
filename = '/home/mengmi/Desktop/IROS.gif'; % Specify the output file name
nImages = counter-1;
for idx = 1:nImages
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.05);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.05);
    end
end 



    