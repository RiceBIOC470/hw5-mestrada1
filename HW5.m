%HW5

% N.B. Received extension on this homework assignment

% Note. You can use the code readIlastikFile.m provided in the repository to read the output from
% ilastik into MATLAB.

%% Problem 1. Starting with Ilastik

% Part 1. Use Ilastik to perform a segmentation of the image stemcells.tif
% in this folder. Be conservative about what you call background - i.e.
% don't mark something as background unless you are sure it is background.
% Output your mask into your repository. What is the main problem with your segmentation?  

img1 = imread('stemcells.tif');
imshow(img1, []);
mask = readIlastikFile('stemcells_Simple Segmentation.h5');
imshow(mask, []);
imwrite(mask, 'stemcells_mask.tif');
% See repository for .h5 extension file

% The main problems with this segmentation are that some cells still appear 
% "connected" and the distinction between the background and the cells 
% could be better (this is due to the fact that that I was conservative in 
% defining the background in Ilastik). 

% Part 2. Read you segmentation mask from Part 1 into MATLAB and use
% whatever methods you can to try to improve it. 

seg_mask = imread('stemcells_mask.tif');
imshow(seg_mask, []);
mask1 = imopen(seg_mask, strel('disk', 10));
mask1 = imerode(mask1, strel('disk', 5));
mask1 = imfilter(mask1, fspecial('gaussian',4,2));
imshow(mask1, []);

% Part 3. Redo part 1 but now be more aggresive in defining the background.
% Try your best to use ilastik to separate cells that are touching. Output
% the resulting mask into the repository. What is the problem now?

seg_mask2 = readIlastikFile('stemcells_Simple Segmentation2.h5');
imshow(seg_mask2, []);
imwrite(seg_mask2, 'stemcells_mask2.tif');
% See repository for .h5 extension file

% The problem now is that some cells are slightly eroded. This more
% aggresive segmentation looks better than the conservative segmentation
% from the last part however. 

% Part 4. Read your mask from Part 3 into MATLAB and try to improve
% it as best you can.

seg_mask2 = imread('stemcells_mask2.tif');
imshow(seg_mask2, []);
mask2 = edge(seg_mask2, 'canny', []);
mask2 = imclose(mask2, strel('disk', 3));
mask2 = imfill(mask2, 'holes');
imshow(mask2, []);
% Fixed erosion problem, but lost a little bit of segmentation

%% Problem 2. Segmentation problems.

% The folder segmentationData has 4 very different images. Use
% whatever tools you like to try to segement the objects the best you can. Put your code and
% output masks in the repository. If you use Ilastik as an intermediate
% step put the output from ilastik in your repository as well as an .h5
% file. Put code here that will allow for viewing of each image together
% with your final segmentation. 

% Bacteria Image

bacteria = imread('bacteria.tif');
imshow(bacteria, []);

% Used Ilastik to segment

bacteria_mask = h5read('bacteria_Simple Segmentation.h5', '/exported_data');
bacteria_mask = squeeze(bacteria_mask);
imshow(bacteria_mask, []);
bacteria_mask = imcomplement(bacteria_mask);
bacteria_mask = bacteria_mask';
imshow(bacteria_mask, []);
imwrite(bacteria_mask, 'bacteria_mask.tif');
% See .h5 file in repository

bacteria_mask = imread('bacteria_mask.tif');
imshow(bacteria_mask, []);

bacteria_mask = imdilate(bacteria_mask, strel('disk', 5));
imshow(bacteria_mask, []);
imwrite(bacteria_mask, 'bacteria_mask2.tif');
% Ilastik segmented bacteria very well, so cleanup of mask was minimal

bacteria = imread('bacteria.tif');
bacteria_mask2 = imread('bacteria_mask2.tif');
figure;
subplot(1,2,1);
imshow(bacteria,[]);
subplot(1,2,2);
imshow(bacteria_mask2, []);

% Yeast Image

yeast = imread('yeast.tif');
imshow(yeast, []);

% Used Ilastik to segment

yeast_mask = h5read('yeast_Simple Segmentation.h5', '/exported_data');
yeast_mask = squeeze(yeast_mask);
yeast_mask = yeast_mask';
yeast_mask = imcomplement(yeast_mask);
imshow(yeast_mask, []);
imwrite(yeast_mask, 'yeast_mask.tif');
% See .h5 file in repository

yeast_mask = imread('yeast_mask.tif');
yeast_mask = imerode(yeast_mask, strel('disk', 5));
imshow(yeast_mask, []);
yeast_mask = imdilate(yeast_mask, strel('disk', 8));
imshow(yeast_mask, []);
imwrite(yeast_mask, 'yeast_mask2.tif');
% Ilastik segmented yeast decently well, clean up not too intensive

yeast = imread('yeast.tif');
yeast_mask2 = imread('yeast_mask2.tif');
figure;
subplot(1,2,1);
imshow(yeast,[]);
subplot(1,2,2);
imshow(yeast_mask2, []);

% Cell Phase Contrast Image

cellphase = imread('cellPhaseContrast.png');
imshow(cellphase, []);

% Used Ilastik to segment

cellphase_mask = h5read('cellPhaseContrast_Simple Segmentation.h5', '/exported_data');
cellphase_mask = squeeze(cellphase_mask);
cellphase_mask = cellphase_mask';
cellphase_mask = imcomplement(cellphase_mask);
imshow(cellphase_mask, []);
imwrite(cellphase_mask, 'cellphase_mask.tif'); 
% See .h5 file in repository

cellphase_mask = imread('cellphase_mask.tif');
imshow(cellphase_mask, []);
cellphase_mask = imopen(cellphase_mask, strel('disk', 1));
imshow(cellphase_mask2, []);
cellphase_mask = edge(cellphase_mask, 'canny', []);
imshow(cellphase_mask, []);
cellphase_mask = imfill(cellphase_mask, 'holes');
imshow(cellphase_mask, []);
imwrite(cellphase_mask, 'cellphase_mask2.tif');
% Ilastik segmented decently well, but due to small nature of the cells, it
% was difficult to segment everything

cellphase = imread('cellPhaseContrast.png');
cellphase_mask2 = imread('cellphase_mask2.tif');
figure;
subplot(1,2,1);
imshow(cellphase,[]);
subplot(1,2,2);
imshow(cellphase_mask2, []);

% Worms Image

worms = imread('worms.tif');
imshow(worms, []);

% Used Ilastik to segment

worms_mask = h5read('worms_Simple Segmentation.h5', '/exported_data');
worms_mask = squeeze(worms_mask);
worms_mask = worms_mask';
worms_mask = imcomplement(worms_mask);
imshow(worms_mask, []);
imwrite(worms_mask, 'worms_mask.tif');
% See .h5 file in repository

worms_mask = imread('worms_mask.tif');
imshow(worms_mask, []);

worms_mask = imerode(worms_mask, strel('disk', 2));
imshow(worms_mask, []);
worms_mask = imdilate(worms_mask, strel('disk', 3));
imshow(worms_mask, []);
imwrite(worms_mask, 'worms_mask2.tif');
% Ilastik segmented this image very well and was even able to remove plate 
% outline; minimal clean up was necessary

worms = imread('worms.tif');
worms_mask2 = imread('worms_mask2.tif');
figure;
subplot(1,2,1);
imshow(worms,[]);
subplot(1,2,2);
imshow(worms_mask2, []);