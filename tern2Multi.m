clear all; close all; clc
% Multi-scale analysis code for Ternary Type II

if ~isfolder('./results')
    mkdir './results/';
end

% Can add these options to fminsearch.
% options = optimset('PlotFcns',@optimplotfval);

% Define structural similarity index
ssI = 0.98;

% Create output file.
first_line = ["Image", "Coef. value", "SSIM"];
output_name = ['./results/tern2_',num2str(ssI),'_SSIM.csv'];
writematrix(first_line,output_name);

% Set lower bound for differing initializing loop
low_bound = 0.99*ssI;

folders = dir('./photos');
% Iterate through all image folders
for i=4:length(folders)
    sub_folder = dir(['./photos/',folders(i).name,'/']);
    % Iterate through all images in each folder
    for j=4:length(sub_folder)
        image_file = ['./photos/',folders(i).name,'/',sub_folder(j).name];
        image_name = [folders(i).name,'_',sub_folder(j).name];
        disp('-------------------------------------------');
        disp(['Current image: ',image_name]);
        disp('Solving for compression ratio...')
        Iref = double(imread(image_file));
        fcn = @(b) (multi(b,Iref)-ssI).^2;
        init = 0.0001;
        val = fminsearch(fcn,init);
        m = multi(val,Iref);
        % Enter new loop when main function fails to converge.
        if m < low_bound
            count = 1;
            while m < low_bound
                init = 10*init;
                disp(['Did not converge...initializing with ',num2str(init)])
                val = fminsearch(fcn,init);
                m = multi(val,Iref);
                count = count + 1;
                if m > low_bound
                    disp('Converged! Exiting...');
                    break
                elseif count > 3
                    disp('Could not converge...');
                    break
                else
                    continue
                end
            end
        else
            disp('Converged!')
        end
    disp(['Compression ratio: ',num2str(val)]);
    disp(['SSIM: ',num2str(m)]);
    data = [convertCharsToStrings(image_name), val, m];
    writematrix(data,output_name,'WriteMode','append');
    end
end

% image_file = './photos/iran/Image01.jpg';
% Iref = double(imread(image_file));
% I = mainImageTern2(Iref,0.01);
% x = ssim(I,Iref)
% x = mean([multissim(I(:,:,1),Iref(:,:,1)),multissim(I(:,:,2),Iref(:,:,2)),multissim(I(:,:,3),Iref(:,:,3))])

%--------------------------------------------------------------------------

function x = multi(b,image)
    s = size(image,3);
    if s == 3
        I = mainImageTern2(image,b);
        x = mean([multissim(I(:,:,1),image(:,:,1)),multissim(I(:,:,2),image(:,:,2)),multissim(I(:,:,3),image(:,:,3))]);
    elseif s == 2
        I = mainImageTern2(image,b);
        x = mean([multissim(I(:,:,1),image(:,:,1)),multissim(I(:,:,2),image(:,:,2))]);
    elseif s == 1
        I = mainImageTern2(image,b);
        x = multissim(I,image);
    end
end

%--------------------------------------------------------------------------