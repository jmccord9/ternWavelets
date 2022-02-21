clear all; close all; clc
% Multi-scale analysis code for CDF 9/7

% if ~isfolder('./results/groundtruth/')
%     mkdir './results/groundtruth/';
% end
% 
% % Can add these options to fminsearch.
options = optimset('PlotFcns',@optimplotfval);
% 
% % % Create output file.
% % first_line = ["Image", "Coef. value", "MS-SSIM","Converged"];
% % output_name = ['./results/cdf_',num2str(ssI),'_MS-SSIM.csv'];
% 
% % Define structural similarity index list
% for  ssI = [0.95]
%     % Set lower bound for differing initializing loop
%     low_bound = 0.99*ssI;
%     for wav = [convertCharsToStrings('cdf'),convertCharsToStrings('tern1'),convertCharsToStrings('tern2')]
%         output_name = ['./results/groundtruth/',convertStringsToChars(wav),'_',num2str(ssI),'_MS-SSIM.csv'];
%         writematrix(first_line,output_name);
%         folders = dir('./photos');
%         % Iterate through all image folders
%         for i=4:length(folders)
%                 sub_folder = dir(['./photos/greenland/']);
%                 % Iterate through all images in each folder
%                 for j=4:length(sub_folder)
%                     converged = 1;
%                     image_file = ['./photos/greenland/',sub_folder(j).name];
%                     image_name = ['greenland_',sub_folder(j).name];
%                     disp('-------------------------------------------');
%                     disp(['Current image: ',image_name]);
%                     disp('Solving for compression ratio...')
%                     Iref = double(imread(image_file));
%                     fcn = @(b) (multi(b,Iref,wav)-ssI);
%                     init = 0.00001;
%                     val = fminsearch(fcn,init);
%                     m = multi(val,Iref,wav);
%                     % Enter new loop when main function fails to converge.
%                     if m < low_bound
%                         count = 1;
%                         while m < low_bound
%                             init = 10*init;
%                             disp(['Did not converge...initializing with ',num2str(init)])
%                             val = fminsearch(fcn,init);
%                             m = multi(val,Iref,wav);
%                             count = count + 1;
%                             if m > low_bound
%                                 disp('Converged! Exiting...');
%                                 break
%                             elseif count > 3
%                                 disp('Could not converge...');
%                                 converged = 0;
%                                 break
%                             else
%                                 continue
%                             end
%                         end
%                     else
%                         disp('Converged!')
%                     end
%                 disp(['Compression ratio: ',num2str(val)]);
%                 disp(['SSIM: ',num2str(m)]);
%                 data = [convertCharsToStrings(image_name), val, m, converged];
%                 writematrix(data,output_name,'WriteMode','append');

% ssI = 0.98;
% low_bound = 0.999*ssI;
% up_bound = 1.001*ssI;
% first_line = ["Image", "Coef. value", "MS-SSIM","Converged"];
% for wav = [convertCharsToStrings('tern2')] % convertCharsToStrings('cdf'),convertCharsToStrings('tern1'),
%     output_name = ['./results/large/',convertStringsToChars(wav),'_',num2str(ssI),'_MS-SSIM.csv'];
% %     writematrix(first_line,output_name);
%     folders = dir('./photos/large/');
%     for i=9:length(folders)
%         converged = 1;
%         image_file = ['./photos/large/',folders(i).name];
%         image_name = ['large_',folders(i).name];
%         disp('-------------------------------------------');
%         disp(['Current image: ',image_name]);
%         disp('Solving for compression ratio...')
%         Iref = double(imread(image_file));
%         fcn = @(b) (multi(b,Iref,wav)-ssI).^4;
%         init = 0.0001;
%         val = fminsearch(fcn,init);
%         m = multi(val,Iref,wav);
%         if m < low_bound | m > up_bound
%             count = 1;
%             while m < low_bound | m > up_bound
%                 init = init+0.0002;
% %                 init = 10*init;
%                 disp(['Did not converge...initializing with ',num2str(init)])
%                 val = fminsearch(fcn,init);
%                 m = multi(val,Iref,wav);
%                 count = count + 1;
%                 if m > low_bound && m < up_bound
%                     disp('Converged! Exiting...');
%                     break
%                 elseif count > 20
%                     disp('Could not converge...');
%                     converged = 0;
%                     break
%                 else
%                     continue
%                 end
%             end
%         else
%             disp('Converged!')
%         end
%         disp(['Compression ratio: ',num2str(val)]);
%         disp(['SSIM: ',num2str(m)]);
%         data = [convertCharsToStrings(image_name), val, m, converged];
%         writematrix(data,output_name,'WriteMode','append');
%     end
% end

wav = 'tern2';
Iref = double(imread('./photos/large/IMG_7510.jpeg'));
fcn = @(b) (multi(b,Iref,wav)-0.95).^2;
init = 0.000117;
% val = fminsearch(fcn,init,options)
m = multi(init,Iref,wav)

%--------------------------------------------------------------------------

function x = multi(b,image,wav)
%     if wav == 'cdf'
%         I = cdfTransform(image,b);
%     elseif wav == 'tern1'
%         I = mainImageTern1(image,b);
%     elseif wav == 'tern2'
%         I = mainImageTern2(image,b);
%     end
    I = mainImageTern2(image,b);
    s = size(image,3);
    if s == 3
        x = mean([multissim(I(:,:,1),image(:,:,1),'DynamicRange',255),multissim(I(:,:,2),image(:,:,2),'DynamicRange',255),multissim(I(:,:,3),image(:,:,3),'DynamicRange',255)]);
    elseif s == 2
        x = mean([multissim(I(:,:,1),image(:,:,1),'DynamicRange',255),multissim(I(:,:,2),image(:,:,2),'DynamicRange',255)]);
    elseif s == 1
        x = multissim(I,image,'DynamicRange',255);
    end
end

%--------------------------------------------------------------------------