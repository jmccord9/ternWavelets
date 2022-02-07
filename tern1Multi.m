clear all; close all; clc
% Multi-scale analysis code for Ternary Type I

options = optimset('PlotFcns',@optimplotfval);
data = ["Image", "Coef. val", "score"];
ssI = 0.9;
files = dir('../../images/fingerprints/8/*.tif');
for i= 1:length(files)
    Iref = double(imread([files(i).folder,'/',files(i).name]));
    fcn = @(b) (multi(b,Iref)-ssI).^2;
    val = fminsearch(fcn,0.0001,options);
    m = multi(val,Iref);
    if m < 0.89
        val = fminsearch(fcn,0.001,options);
        m = multi(val,Iref);
    end
    if m < 0.89
        val = fminsearch(fcn,0.01,options);
        m = multi(val,Iref);
    end
    if m < 0.89
        val = fminsearch(fcn,0.1,options);
        m = multi(val,Iref);
    end
    m
    data = [data; convertCharsToStrings(files(i).name), val, m];
end
writematrix(data,'../../data/typeI/multi9/typeI-fingerprints8.csv');

function x = multi(b,image)
    s = size(image,3);
    if s == 3
        I = mainImageTern(image,b);
        x = mean([multissim(I(:,:,1),image(:,:,1)),multissim(I(:,:,2),image(:,:,2)),multissim(I(:,:,3),image(:,:,3))]);
    elseif s == 2
        I = mainImageTern(image,b);
        x = mean([multissim(I(:,:,1),image(:,:,1)),multissim(I(:,:,2),image(:,:,2))]);
    elseif s == 1
        I = mainImageTern(image,b);
        x = multissim(I,image);
    end
end

% aerials/*.tiff
% australia/*.jpg
% barcelona/*.jpg
% campusinfall/*.jpg
% cannonbeach/*.jpg
% cherries/*.jpg
% columbiagorge/*.JPG
% fingerprints/1/*.tif
% fingerprints/2/*.tif
% fingerprints/3/*.tif
% fingerprints/4/*.tif
% football/*.jpg
% geneva/*.jpg
% greenlake/*.jpg
% indonesia/*.jpg
% iran/*.jpg
% italy/*.jpg
% japan/*.jpg
% leaflesstrees/*.jpg
% misc/*.tiff
% old/*.png
% sanjuans/*.jpg
% springflowers/*.jpg
% standard_test_images/*.tif
% swissmountains/*.jpg
% textures/*.tiff
% yellowstone/*.jpg

%----------------------------------------------------------------------------------