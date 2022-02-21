clear all; close all; clc

% -------------------------------------------------------------------------
% Import data
% -------------------------------------------------------------------------

groundtruth_data = importdata("./results/groundtruth_data_final.mat");
highres_data = importdata("./results/highres_data_final.mat");
ucid_data = importdata("./results/ucid_data_final.mat");

% -------------------------------------------------------------------------
% Load relevant data
% -------------------------------------------------------------------------

% CDF @ 0.95 SSIM
cdf_95_groundtruth = groundtruth_data.CDF_SSIM95_Ratio.';
cdf_95_highres = highres_data.CDF_SSIM95_Ratio.';
cdf_95_ucid = ucid_data.CDF_SSIM95_Ratio.';
cdf_95_all = [cdf_95_groundtruth; cdf_95_ucid; cdf_95_highres];

% CDF @ 0.98 SSIM
cdf_98_groundtruth = groundtruth_data.CDF_SSIM98_Ratio.';
cdf_98_highres = highres_data.CDF_SSIM98_Ratio.';
cdf_98_ucid = ucid_data.CDF_SSIM98_Ratio.';
cdf_98_all = [cdf_98_groundtruth; cdf_98_ucid; cdf_98_highres];

% CDF @ 0.99 SSIM
cdf_99_groundtruth = groundtruth_data.CDF_SSIM99_Ratio.';
cdf_99_highres = highres_data.CDF_SSIM99_Ratio.';
cdf_99_ucid = ucid_data.CDF_SSIM99_Ratio.';
cdf_99_all = [cdf_99_groundtruth; cdf_99_ucid; cdf_99_highres];

% TypeI @ 0.95 SSIM
typeI_95_groundtruth = groundtruth_data.TypeI_SSIM95_Ratio.';
typeI_95_highres = highres_data.TypeI_SSIM95_Ratio.';
typeI_95_ucid = ucid_data.TypeI_SSIM95_Ratio.';
typeI_95_all = [typeI_95_groundtruth; typeI_95_ucid; typeI_95_highres];
typeI_95_groundtruth_percent = 100*(1 - (typeI_95_groundtruth./cdf_95_groundtruth));
typeI_95_highres_percent = 100*(1 - (typeI_95_highres./cdf_95_highres));
typeI_95_ucid_percent = 100*(1 - (typeI_95_ucid./cdf_95_ucid));
typeI_95_all_percent = 100*(1 - (typeI_95_all./cdf_95_all));

% TypeI @ 0.98 SSIM
typeI_98_groundtruth = groundtruth_data.TypeI_SSIM98_Ratio.';
typeI_98_highres = highres_data.TypeI_SSIM98_Ratio.';
typeI_98_ucid = ucid_data.TypeI_SSIM98_Ratio.';
typeI_98_all = [typeI_98_groundtruth; typeI_98_ucid; typeI_98_highres];
typeI_98_groundtruth_percent = 100*(1 - (typeI_98_groundtruth./cdf_98_groundtruth));
typeI_98_highres_percent = 100*(1 - (typeI_98_highres./cdf_98_highres));
typeI_98_ucid_percent = 100*(1 - (typeI_98_ucid./cdf_98_ucid));
typeI_98_all_percent = 100*(1 - (typeI_98_all./cdf_98_all));

% TypeI @ 0.99 SSIM
typeI_99_groundtruth = groundtruth_data.TypeI_SSIM99_Ratio.';
typeI_99_highres = highres_data.TypeI_SSIM99_Ratio.';
typeI_99_ucid = ucid_data.TypeI_SSIM99_Ratio.';
typeI_99_all = [typeI_99_groundtruth; typeI_99_ucid; typeI_99_highres];
typeI_99_groundtruth_percent = 100*(1 - (typeI_99_groundtruth./cdf_99_groundtruth));
typeI_99_highres_percent = 100*(1 - (typeI_99_highres./cdf_99_highres));
typeI_99_ucid_percent = 100*(1 - (typeI_99_ucid./cdf_99_ucid));
typeI_99_all_percent = 100*(1 - (typeI_99_all./cdf_99_all));

% TypeII @ 0.95 SSIM
typeII_95_groundtruth = groundtruth_data.TypeII_SSIM95_Ratio.';
typeII_95_highres = highres_data.TypeII_SSIM95_Ratio.';
typeII_95_ucid = ucid_data.TypeII_SSIM95_Ratio.';
typeII_95_all = [typeII_95_groundtruth; typeII_95_ucid; typeII_95_highres];
typeII_95_groundtruth_percent = 100*(1 - (typeII_95_groundtruth./cdf_95_groundtruth));
typeII_95_highres_percent = 100*(1 - (typeII_95_highres./cdf_95_highres));
typeII_95_ucid_percent = 100*(1 - (typeII_95_ucid./cdf_95_ucid));
typeII_95_all_percent = 100*(1 - (typeII_95_all./cdf_95_all));

% TypeII @ 0.98 SSIM
typeII_98_groundtruth = groundtruth_data.TypeII_SSIM98_Ratio.';
typeII_98_highres = highres_data.TypeII_SSIM98_Ratio.';
typeII_98_ucid = ucid_data.TypeII_SSIM98_Ratio.';
typeII_98_all = [typeII_98_groundtruth; typeII_98_ucid; typeII_98_highres];
typeII_98_groundtruth_percent = 100*(1 - (typeII_98_groundtruth./cdf_98_groundtruth));
typeII_98_highres_percent = 100*(1 - (typeII_98_highres./cdf_98_highres));
typeII_98_ucid_percent = 100*(1 - (typeII_98_ucid./cdf_98_ucid));
typeII_98_all_percent = 100*(1 - (typeII_98_all./cdf_98_all));

% TypeII @ 0.99 SSIM
typeII_99_groundtruth = groundtruth_data.TypeII_SSIM99_Ratio.';
typeII_99_highres = highres_data.TypeII_SSIM99_Ratio.';
typeII_99_ucid = ucid_data.TypeII_SSIM99_Ratio.';
typeII_99_all = [typeII_99_groundtruth; typeII_99_ucid; typeII_99_highres];
typeII_99_groundtruth_percent = 100*(1 - (typeII_99_groundtruth./cdf_99_groundtruth));
typeII_99_highres_percent = 100*(1 - (typeII_99_highres./cdf_99_highres));
typeII_99_ucid_percent = 100*(1 - (typeII_99_ucid./cdf_99_ucid));
typeII_99_all_percent = 100*(1 - (typeII_99_all./cdf_99_all));

% -------------------------------------------------------------------------
% Display median values for each group
% -------------------------------------------------------------------------

s.typeI_95_groundtruth = median(typeI_95_groundtruth_percent);
s.typeI_95_highres = median(typeI_95_highres_percent);
s.typeI_95_ucid = median(typeI_95_ucid_percent);
s.typeI_95_all = median(typeI_95_all_percent);

s.typeI_98_groundtruth = median(typeI_98_groundtruth_percent);
s.typeI_98_highres = median(typeI_98_highres_percent);
s.typeI_98_ucid = median(typeI_98_ucid_percent);
s.typeI_98_all = median(typeI_98_all_percent);

s.typeI_99_groundtruth = median(typeI_99_groundtruth_percent);
s.typeI_99_highres = median(typeI_99_highres_percent);
s.typeI_99_ucid = median(typeI_99_ucid_percent);
s.typeI_99_all = median(typeI_99_all_percent);

s.typeII_95_groundtruth = median(typeII_95_groundtruth_percent);
s.typeII_95_highres = median(typeII_95_highres_percent);
s.typeII_95_ucid = median(typeII_95_ucid_percent);
s.typeII_95_all = median(typeII_95_all_percent);

s.typeII_98_groundtruth = median(typeII_98_groundtruth_percent);
s.typeII_98_highres = median(typeII_98_highres_percent);
s.typeII_98_ucid = median(typeII_98_ucid_percent);
s.typeII_98_all = median(typeII_98_all_percent);

s.typeII_99_groundtruth = median(typeII_99_groundtruth_percent);
s.typeII_99_highres = median(typeII_99_highres_percent);
s.typeII_99_ucid = median(typeII_99_ucid_percent);
s.typeII_99_all = median(typeII_99_all_percent);

s

% -------------------------------------------------------------------------
% Create groupings for text labeling
% -------------------------------------------------------------------------

g1 = repmat({'Groundtruth'},size(typeI_99_groundtruth,1),1);
g2 = repmat({'UCID'},size(typeI_99_ucid,1),1);
g3 = repmat({'High Res.'},size(typeI_99_highres,1),1);
g = [g1; g2; g3];

% -------------------------------------------------------------------------
% Create figure
% -------------------------------------------------------------------------

f = figure;
f.Position(3) = f.Position(3)/2;
boxplot(typeII_99_all_percent,g);
set( gca(), 'YTickLabel', [], 'XTickLabel', ["Groundtruth","UCID","High Res."] , 'FontSize', 16); % , 'YTickLabel', []
ylabel('Relative compression vs. CDF-9/7 (%)');
ylim([-25 25]);
hold on
yline(0,'--');

% -------------------------------------------------------------------------