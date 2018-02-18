function [ imInput ] = importImageSeries( infoStruct )
% IMPORTIMAGESERIES 
% Imports a 3 dimensional stack of images specified in the infoStruct
% Inputs:
% infoStruct - Structure of parameters generated by getTimeSeriesInfo.m
% Outputs:
% 3D double array of size ny X nx X numFrames. nx and ny are the number of
% pixels in the x and y dimensions and numFrames is the number of images in
% the stack. Array values are from 0 to 1, where 1 is the largest value
% that occurs in the stack.

% Get info
numImages = infoStruct.numFrames;
xInput = infoStruct.xPixels;
yInput = infoStruct.yPixels;
fullPath = infoStruct.fullPath;
% Set up matrix
imInput = double(zeros(yInput,xInput,numImages));
% Read images into stack
hWait = waitbar(0, sprintf('Importing %d images...',numImages));
for ii = 1:numImages
    imInput(:,:,ii) = double(imread(fullPath,'tif',ii));
    waitbar(ii/numImages,hWait);
end
close(hWait);
% Rescale from 0 to 1
imInput = imInput./max(imInput(:));

end

