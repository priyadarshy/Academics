%Graph Cut Segmentation of Myocytes
%
%(Run compile.mat first)
%
%
%Code based on Shai Bagon's Graph Cut Matlab Wrapper
%www.wisdom.weizmann.ac.il/~bagon, December 2006.


clear all
close all

%read in appropriate image
[file path]=uigetfile('*.tif','Please select the image to analyze');
im=im2double(imread(file));

%perform full-contrast histogram stretch
im=imadjust(im);

%--------------------------------------------------------------------------
%- Calculate Data Term
%--------------------------------------------------------------------------

%cluster grayscale values into 3 regions (roughly Gaussian-shaped
%histogram, cluster into thirds)
k = 3;
imsize=size(im);
data=reshape(im,[prod(imsize(1:2)) 1]);
%seed the inital centroid locations
%[idx c]=kmeans(data,k,'maxiter',200,'start',[.05;.5;.95]);
[idx c]=kmeans(data,k,'maxiter',200,'start','uniform');
%sort regions in ascending order
[ignore sortidx]=sort(c);

%calculate each data cost relative to each cluster center
datacost = zeros([imsize(1:2) k],'single');
for i=1:k
    %find covariance of data in this cluster
    clustcov=cov(data(idx==i,:));
    %calculate all distances from cluster center
    dist=data-c(i);
    %determine cost penalty based on rough likelihood for each pixel to
    %belong to this cluster (by intensity)
    datacost(:,:,i)=reshape((dist./clustcov).*dist./2,imsize);
end

%--------------------------------------------------------------------------
%- Calculate Region Term
%--------------------------------------------------------------------------

%constant portion -- Sc(i,j) corresponds to cost of assigning label j to a
%neighbor given that this pixel has label i
Sc =ones(k)-eye(k);

%spatially-varying portion (region similarity)

%find vertical slope of main lobe of 2d-Gaussian
gauss=fspecial('gauss',[13 13],sqrt(13));
dy=fspecial('sobel');
kern=conv2(gauss,dy,'valid');

vertcost=zeros(imsize);
horzcost=vertcost;

%vertical spatial term
vertcost=max(vertcost,abs(imfilter(im(:,:,1),kern,'symmetric')));
%horizontal spatial term
horzcost=max(horzcost,abs(imfilter(im(:,:,1),kern','symmetric')));

%--------------------------------------------------------------------------
%- Construct and Cut Graph
%--------------------------------------------------------------------------

%initialize graph structure
gch=GraphCut('open',datacost,10*Sc,exp(-vertcost*5),exp(-horzcost*5));

%minimize energy
[gch L]=GraphCut('expand',gch);

%close graph
gch=GraphCut('close',gch);

%--------------------------------------------------------------------------
%- Display Results
%--------------------------------------------------------------------------

%locate foreground (cut region based on darkest centroid clustering)
foreground=L==(sortidx(1)-1);
outline=bwperim(foreground);

%count regions segmented (cells in this case)
[labels numcells]=bwlabel(foreground,8);

%show original image
figure
imshow(im)
title('Original Image')

%construct segmentation overlay
imrgb=im;
imrgb(outline)=0;
blue=imrgb;
blue(outline)=160;
imrgb=cat(3,imrgb,imrgb,blue);
figure
imshow(imrgb)
title(sprintf('Graph Cut Cell Segmentation -- %i cells detected',numcells))
