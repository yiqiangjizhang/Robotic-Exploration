%-------------------------------------------------------------------------------------------------------%
% PROJECT: Landsat Coral reef
%-------------------------------------------------------------------------------------------------------%

% Date: 17/05/2021
% Author/s: Group 1
%   Rita Fardilha
%   Yi Qiang Ji
%   Èric Montserrat
%   Iván Sermanoukian

% Subject: Robotic Exploration of the Solar Systemw
% Professor: Manel Soria & Arnau Miro & Elena Terzic

% Clear workspace, command window and close windows
clear;
close all;
clc;

% Set interpreter to latex
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaulttextinterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

%% SUMMER 2005
b2005_s1 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B1.tif');
b2005_s2 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B2.tif'); %
b2005_s3 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B3.tif'); %
b2005_s4 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B4.tif'); %
b2005_s5 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B5.tif'); %
b2005_s6 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B6.tif'); %
b2005_sQA = imread('LT05_L2SP_092074_20050104_20200902_02_T1_QA_PIXEL.tif'); %
file_2005_sQA = 'LT05_L2SP_092074_20050104_20200902_02_T1_QA_PIXEL.tif';

%Natural
main_natural_2(b2005_s2, b2005_s3, b2005_s4)
%InfraRed
main_IR_2(b2005_s2, b2005_s3, b2005_s4)
%NVDI
main_NDVI_2(b2005_s4, b2005_s5)
%Rrs
main_Rrs_2(b2005_s1) %turbo?
%Turbidity
main_turbidity_2(b2005_s4, b2005_s5, b2005_sQA, file_2005_sQA) %?
%Geo Map
% main_geo_temp_map_2(b2005_s10,b2005_sQA, file_2005_sQA)
%Clorophyll
main_clorophyll_2(b2005_s1, b2005_s2, b2005_s3, b2005_sQA, file_2005_sQA)
%Temperature
% main_temp_2(b2005_s10)
%Water Mask
% main_water_mask_2(b2005_s10,b2005_sQA)

%% wINTER 2005
b2005_w1 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B1.tif');
b2005_w2 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B2.tif'); %
b2005_w3 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B3.tif'); %
b2005_w4 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B4.tif'); %
b2005_w5 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B5.tif'); %
b2005_w6 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B6.tif'); %
b2005_wQA = imread('LT05_L2SP_092074_20050715_20200902_02_T1_QA_PIXEL.tif'); %
file_2005_wQA = 'LT05_L2SP_092074_20050715_20200902_02_T1_QA_PIXEL.tif';

%Natural
main_natural_2(b2005_w2, b2005_w3, b2005_w4)
%InfraRed
main_IR_2(b2005_w2, b2005_w3, b2005_w4)
%NVDI
main_NDVI_2(b2005_w4, b2005_w5)
%Rrs
main_Rrs_2(b2005_w1) %turbo?
%Turbidity
main_turbidity_2(b2005_w4, b2005_w5, b2005_wQA, file_2005_wQA) %?
%Geo Map
% main_geo_temp_map_2(b2005_w10,b2005_wQA, file_2005_wQA)
%Clorophyll
main_clorophyll_2(b2005_w1, b2005_w2, b2005_w3, b2005_wQA, file_2005_wQA)
%Temperature
% main_temp_2(b2005_w10)
%Water Mask
% main_water_mask_2(b2005_w10,b2005_wQA)

%% SUMMER 2010

b2010_s1 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B1.tif');
b2010_s2 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B2.tif'); %
b2010_s3 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B3.tif'); %
b2010_s4 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B4.tif'); %
b2010_s5 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B5.tif'); %
b2010_s6 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B6.tif'); %
b2010_sQA = imread('LT05_L2SP_092074_20091201_20200825_02_T1_QA_PIXEL.tif'); %
file_2010_sQA = 'LT05_L2SP_092074_20091201_20200825_02_T1_QA_PIXEL.tif';

%Natural
main_natural_2(b2010_s2, b2010_s3, b2010_s4)
%InfraRed
main_IR_2(b2010_s2, b2010_s3, b2010_s4)
%NVDI
main_NDVI_2(b2010_s4, b2010_s5)
%Rrs
main_Rrs_2(b2010_s1) %turbo?
%Turbidity
main_turbidity_2(b2010_s4, b2010_s5, b2010_sQA, file_2010_sQA) %?
%Geo Map
% main_geo_temp_map_2(b2010_s10,b2010_sQA, file_2010_sQA)
%Clorophyll
main_clorophyll_2(b2010_s1, b2010_s2, b2010_s3, b2010_sQA, file_2010_sQA)
%Temperature
% main_temp_2(b2010_s10)
%Water Mask
%main_water_mask_2(b2010_s10,b2010_sQA)

%% WINTER 2010
b2010_w1 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B1.tif');
b2010_w2 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B2.tif'); %
b2010_w3 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B3.tif'); %
b2010_w4 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B4.tif'); %
b2010_w5 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B5.tif'); %
b2010_w6 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B6.tif'); %
b2010_wQA = imread('LT05_L2SP_092074_20100814_20200823_02_T1_QA_PIXEL.tif'); %
file_2010_wQA = 'LT05_L2SP_092074_20100814_20200823_02_T1_QA_PIXEL.tif';

%Natural
main_natural_2(b2010_w2, b2010_w3, b2010_w4)
%InfraRed
main_IR_2(b2010_w2, b2010_w3, b2010_w4)
%NVDI
main_NDVI_2(b2010_w4, b2010_w5)
%Rrs
main_Rrs_2(b2010_w1) %turbo?
%Turbidity
main_turbidity_2(b2010_w4, b2010_w5, b2010_wQA, file_2010_wQA) %?
%Geo Map
% main_geo_temp_map_2(b2010_w10,b2010_wQA, file_2010_wQA)
%Clorophyll
main_clorophyll_2(b2010_w1, b2010_w2, b2010_w3, b2010_wQA, file_2010_wQA)
%Temperature
% main_temp_2(b2010_w10)
%Water Mask
%main_water_mask_2(b2010_w10,b2010_wQA)

%% SUMMER 2015

b2015_s1 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B1.tif');
b2015_s2 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B2.tif'); %
b2015_s3 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B3.tif'); %
b2015_s4 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B4.tif'); %
b2015_s5 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B5.tif'); %
b2015_s10 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_ST_B10.tif'); %
b2015_sQA = imread('LC08_L2SP_092074_20141215_20200910_02_T1_QA_PIXEL.tif'); %
file_2015_sQA = 'LC08_L2SP_092074_20141215_20200910_02_T1_QA_PIXEL.tif';

%Natural
main_natural_2(b2015_s2, b2015_s3, b2015_s4)
%InfraRed
main_IR_2(b2015_s2, b2015_s3, b2015_s4)
%NVDI
main_NDVI_2(b2015_s4, b2015_s5)
%Rrs
main_Rrs_2(b2015_s1) %turbo?
%Turbidity
main_turbidity_2(b2015_s4, b2015_s5, b2015_sQA, file_2015_sQA) %?
%Geo Map
main_geo_temp_map_2(b2015_s10, b2015_sQA, file_2015_sQA)
%Clorophyll
main_clorophyll_2(b2015_s1, b2015_s2, b2015_s3, b2015_sQA, file_2015_sQA)
%Temperature
main_temp_2(b2015_s10)
%Water Mask
main_water_mask_2(b2015_s10, b2015_sQA)

%% WINTER 2015

b2015_w1 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B1.tif');
b2015_w2 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B2.tif'); %
b2015_w3 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B3.tif'); %
b2015_w4 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B4.tif'); %
b2015_w5 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B6.tif'); %
b2015_w10 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_ST_B10.tif'); %
b2015_wQA = imread('LC08_L2SP_092074_20150812_20200908_02_T1_QA_PIXEL.tif'); %
file_2015_wQA = 'LC08_L2SP_092074_20150812_20200908_02_T1_QA_PIXEL.tif';

%Natural
main_natural_2(b2015_w2, b2015_w3, b2015_w4)
%InfraRed
main_IR_2(b2015_w2, b2015_w3, b2015_w4)
%NVDI
main_NDVI_2(b2015_w4, b2015_w5)
%Rrs
main_Rrs_2(b2015_w1) %turbo?
%Turbidity
main_turbidity_2(b2015_w4, b2015_w5, b2015_wQA, file_2015_wQA) %?
%Geo Map
main_geo_temp_map_2(b2015_w10, b2015_wQA, file_2015_wQA)
%Clorophyll
main_clorophyll_2(b2015_w1, b2015_w2, b2015_w3, b2015_wQA, file_2015_wQA)
%Temperature
main_temp_2(b2015_w10)
%Water Mask
main_water_mask_2(b2005_w10, b2005_wQA)

%% SUMMER 2020

b2020_s1 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B1.tif');
b2020_s2 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B2.tif'); %
b2020_s3 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B3.tif'); %
b2020_s4 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B4.tif'); %
b2020_s5 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B5.tif'); %
b2020_s10 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_ST_B10.tif'); %
b2020_sQA = imread('LC08_L2SP_092074_20200114_20200823_02_T1_QA_PIXEL.tif'); %
file_2020_sQA = 'LC08_L2SP_092074_20200114_20200823_02_T1_QA_PIXEL.tif';

%Natural
main_natural_2(b2020_s2, b2020_s3, b2020_s4)
%InfraRed
main_IR_2(b2020_s2, b2020_s3, b2020_s4)
%NVDI
main_NDVI_2(b2020_s4, b2020_s5)
%Rrs
main_Rrs_2(b2020_s1) %turbo?
%Turbidity
main_turbidity_2(b2020_s4, b2020_s5, b2020_sQA, file_2020_sQA) %?
%Geo Map
main_geo_temp_map_2(b2020_s10, b2020_sQA, file_2020_sQA)
%Clorophyll
main_clorophyll_2(b2020_s1, b2020_s2, b2020_s3, b2020_sQA, file_2020_sQA)
%Temperature
main_temp_2(b2020_s10)
%Water Mask
main_water_mask_2(b2020_s10, b2020_sQA)

%% WINTER 2020

b2020_w1 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B1.tif');
b2020_w2 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B2.tif'); %
b2020_w3 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B3.tif'); %
b2020_w4 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B4.tif'); %
b2020_w5 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B5.tif'); %
b2020_w10 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_ST_B10.tif'); %
b2020_wQA = imread('LC08_L2SP_092074_20200809_20200917_02_T1_QA_PIXEL.tif'); %
file_2020_wQA = 'LC08_L2SP_092074_20200809_20200917_02_T1_QA_PIXEL.tif';

%Natural
main_natural_2(b2020_w2, b2020_w3, b2020_w4)
%InfraRed
main_IR_2(b2020_w2, b2020_w3, b2020_w4)
%NVDI
main_NDVI_2(b2020_w4, b2020_w5)
%Rrs
main_Rrs_2(b2020_w1) %turbo?
%Turbidity
main_turbidity_2(b2020_w4, b2020_w5, b2020_wQA, file_2020_wQA) %?
%Geo Map
main_geo_temp_map_2(b2020_w10, b2020_wQA, file_2020_wQA)
%Clorophyll
main_clorophyll_2(b2020_w1, b2020_w2, b2020_w3, b2020_wQA, file_2020_wQA)
%Temperature
main_temp_2(b2020_w10)
%Water Mask
main_water_mask_2(b2020_w10, b2020_wQA)
