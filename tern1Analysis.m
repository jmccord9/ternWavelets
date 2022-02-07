clear all; close all; clc
% Analysis code for Ternary Type I

options = optimset('PlotFcns',@optimplotfval);
data = ["Image", "30 PSNR", "40 PSNR"];
files = dir('../../images/fingerprints/8/*.tif');
for i=1:length(files)
    I = double(imread([files(i).folder,'/',files(i).name]));
    image = @(b) mainImageTern(I,b);
    fcn30 = @(b) (-10*log10(mean((I(:) - reshape(image(b),[],1)).^2) / (max(I(:)) - min(I(:)))^2) - 30).^2;
    fcn40 = @(b) (-10*log10(mean((I(:) - reshape(image(b),[],1)).^2) / (max(I(:)) - min(I(:)))^2) - 40).^2;
    convertCharsToStrings(files(i).name)
    s30 = fminsearch(fcn30,[0.00000],options)
    s40 = fminsearch(fcn40,[s30],options)
    data = [data; convertCharsToStrings(files(i).name), s30, s40];
end
% writematrix(data,'../../data/typeI/PSNR/typeI-fingerprints8.csv');

%----------------------------------------------------------------------------------
%                             Check (if needed)
%----------------------------------------------------------------------------------

% I = double(imread('../../images/italy/Image01.jpg'));
% tic
% [Itrans] = mainImageTern(I,0.04375);
% toc
% PSNR = -10*log10(mean((I(:) - Itrans(:)).^2) / (max(I(:)) - min(I(:)))^2)
% imshow(uint8([Itrans]));

%----------------------------------------------------------------------------------