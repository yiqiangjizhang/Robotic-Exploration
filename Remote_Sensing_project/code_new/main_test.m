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

if (~isfile('data.mat'))
    %
    % %% SUMMER 2005
    %
    b2005_s1 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B1.tif');
    b2005_s2 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B2.tif'); %
    b2005_s3 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B3.tif'); %
    b2005_s4 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B4.tif'); %
    b2005_s5 = imread('LT05_L2SP_092074_20050104_20200902_02_T1_SR_B5.tif'); %
    b2005_sQA = imread('LT05_L2SP_092074_20050104_20200902_02_T1_QA_PIXEL.tif'); %
    file_2005_sQA = 'LT05_L2SP_092074_20050104_20200902_02_T1_QA_PIXEL.tif';
    UL_2005_sQA = [108300.000, -2135100.000];
    LR_2005_sQA = [342300.000, -2342100.000];

    %
    % %% WINTER 2005
    %
    b2005_w1 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B1.tif');
    b2005_w2 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B2.tif'); %
    b2005_w3 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B3.tif'); %
    b2005_w4 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B4.tif'); %
    b2005_w5 = imread('LT05_L2SP_092074_20050715_20200902_02_T1_SR_B5.tif'); %
    b2005_wQA = imread('LT05_L2SP_092074_20050715_20200902_02_T1_QA_PIXEL.tif'); %
    file_2005_wQA = 'LT05_L2SP_092074_20050715_20200902_02_T1_QA_PIXEL.tif';
    UL_2005_wQA = [108300.000, -2135100.000];
    LR_2005_wQA = [342300.000, -2342100.000];

    %
    % %% SUMMER 2010
    %
    b2010_s1 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B1.tif');
    b2010_s2 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B2.tif'); %
    b2010_s3 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B3.tif'); %
    b2010_s4 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B4.tif'); %
    b2010_s5 = imread('LT05_L2SP_092074_20091201_20200825_02_T1_SR_B5.tif'); %
    b2010_sQA = imread('LT05_L2SP_092074_20091201_20200825_02_T1_QA_PIXEL.tif'); %
    file_2010_sQA = 'LT05_L2SP_092074_20091201_20200825_02_T1_QA_PIXEL.tif';
    UL_2010_sQA = [106500.000, -2136300.000];
    LR_2010_sQA = [343500.000, -2343300.000];

    %
    % %% WINTER 2010
    %
    b2010_w1 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B1.tif');
    b2010_w2 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B2.tif'); %
    b2010_w3 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B3.tif'); %
    b2010_w4 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B4.tif'); %
    b2010_w5 = imread('LT05_L2SP_092074_20100814_20200823_02_T1_SR_B5.tif'); %
    b2010_wQA = imread('LT05_L2SP_092074_20100814_20200823_02_T1_QA_PIXEL.tif'); %
    file_2010_wQA = 'LT05_L2SP_092074_20100814_20200823_02_T1_QA_PIXEL.tif';
    UL_2010_wQA = [110100.000, -2136000.000];
    LR_2010_wQA = [346200.000, -2343300.000];

    %
    % %% SUMMER 2015
    %
    b2015_s1 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B1.tif');
    b2015_s2 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B2.tif'); %
    b2015_s3 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B3.tif'); %
    b2015_s4 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B4.tif'); %
    b2015_s5 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_SR_B5.tif'); %
    b2015_s10 = imread('LC08_L2SP_092074_20141215_20200910_02_T1_ST_B10.tif'); %
    b2015_sQA = imread('LC08_L2SP_092074_20141215_20200910_02_T1_QA_PIXEL.tif'); %
    file_2015_sQA = 'LC08_L2SP_092074_20141215_20200910_02_T1_QA_PIXEL.tif';
    UL_2015_sQA = [106500.000, -2136300.000];
    LR_2015_sQA = [343500.000, -2343300.000];

    %
    % %% WINTER 2015
    %
    b2015_w1 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B1.tif');
    b2015_w2 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B2.tif'); %
    b2015_w3 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B3.tif'); %
    b2015_w4 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B4.tif'); %
    b2015_w5 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_SR_B6.tif'); %
    b2015_w10 = imread('LC08_L2SP_092074_20150812_20200908_02_T1_ST_B10.tif'); %
    b2015_wQA = imread('LC08_L2SP_092074_20150812_20200908_02_T1_QA_PIXEL.tif'); %
    file_2015_wQA = 'LC08_L2SP_092074_20150812_20200908_02_T1_QA_PIXEL.tif';
    UL_2015_wQA = [114600.000, -2124000.000];
    LR_2015_wQA = [342300.000, -2354700.000];

    %
    % %% SUMMER 2020
    %
    b2020_s1 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B1.tif');
    b2020_s2 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B2.tif'); %
    b2020_s3 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B3.tif'); %
    b2020_s4 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B4.tif'); %
    b2020_s5 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_SR_B5.tif'); %
    b2020_s10 = imread('LC08_L2SP_092074_20200114_20200823_02_T1_ST_B10.tif'); %
    b2020_sQA = imread('LC08_L2SP_092074_20200114_20200823_02_T1_QA_PIXEL.tif'); %
    file_2020_sQA = 'LC08_L2SP_092074_20200114_20200823_02_T1_QA_PIXEL.tif';
    UL_2020_sQA = [116700.000, -2124000.000];
    LR_2020_sQA = [344100.000, -2354700.000];

    %% WINTER 2020

    b2020_w1 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B1.tif');
    b2020_w2 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B2.tif'); %
    b2020_w3 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B3.tif'); %
    b2020_w4 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B4.tif'); %
    b2020_w5 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_SR_B5.tif'); %
    b2020_w10 = imread('LC08_L2SP_092074_20200809_20200917_02_T1_ST_B10.tif'); %
    b2020_wQA = imread('LC08_L2SP_092074_20200809_20200917_02_T1_QA_PIXEL.tif'); %
    file_2020_wQA = 'LC08_L2SP_092074_20200809_20200917_02_T1_QA_PIXEL.tif';
    UL_2020_wQA = [115800.000, -2124000.000];
    LR_2020_wQA = [343200.000, -2354700.000];

else
    load('data.mat')
end

exit_status = false;

while (exit_status == false)
    disp("0. Close all figures");
    disp("1. Natural");
    disp("2. Infrared");
    disp("3. NDVI");
    disp("4. Rrs");
    disp("5. Turbidity");
    disp("6. Geographical map");
    disp("7. Clorophyll");
    disp("8. Temperature");
    disp("9. Water mask");
    disp("'2005S'. 2005 Summer data")
    disp("'2005W'. 2005 Winter data")
    disp("'2010S'. 2010 Summer data")
    disp("'2010W'. 2010 Winter data")
    disp("'2015S'. 2015 Summer data")
    disp("'2015W'. 2015 Winter data")
    disp("'2020S'. 2020 Summer data")
    disp("'2020W'. 2020 Winter data")

    disp("10. E X I T");

    n = input("Enter an number (1, 2, 3 ...) (write '10' to exit or '0' to close figures):");

    switch n
        case 0
            close all;
        case 1
            disp('Displaying Natural')

            % Natural
            main_natural_2(b2005_s2, b2005_s3, b2005_s4);
            main_natural_2(b2005_w2, b2005_w3, b2005_w4);
            main_natural_2(b2010_s2, b2010_s3, b2010_s4);
            main_natural_2(b2010_w2, b2010_w3, b2010_w4);
            main_natural_2(b2015_s2, b2015_s3, b2015_s4);
            main_natural_2(b2015_w2, b2015_w3, b2015_w4);
            main_natural_2(b2020_w2, b2020_w3, b2020_w4);
        case 2
            disp('Displaying Infrared')
            % InfraRed
            main_IR_2(b2005_s2, b2005_s3, b2005_s4);
            main_IR_2(b2005_w2, b2005_w3, b2005_w4);
            main_IR_2(b2010_s2, b2010_s3, b2010_s4);
            main_IR_2(b2010_w2, b2010_w3, b2010_w4);
            main_IR_2(b2015_s2, b2015_s3, b2015_s4);
            main_IR_2(b2015_w2, b2015_w3, b2015_w4);
            main_IR_2(b2020_s2, b2020_s3, b2020_s4);
            main_IR_2(b2020_w2, b2020_w3, b2020_w4);
        case 3
            disp('Displaying NDVI')
            % NDVI
            main_NDVI_2(b2005_s4, b2005_s5);
            main_NDVI_2(b2005_w4, b2005_w5);
            main_NDVI_2(b2010_s4, b2010_s5);
            main_NDVI_2(b2010_w4, b2010_w5);
            main_NDVI_2(b2015_s4, b2015_s5);
            main_NDVI_2(b2015_w4, b2015_w5);
            main_NDVI_2(b2020_s4, b2020_s5);
            main_NDVI_2(b2020_w4, b2020_w5);
        case 4
            disp('Displaying Rrs')
            % Rrs
            main_Rrs_2(b2005_s1);
            main_Rrs_2(b2005_w1);
            main_Rrs_2(b2010_s1);
            main_Rrs_2(b2010_w1);
            main_Rrs_2(b2015_s1);
            main_Rrs_2(b2015_w1);
            main_Rrs_2(b2020_s1);
            main_Rrs_2(b2020_w1);
        case 5
            disp('Displaying Turbidity')
            % Turbidity
            main_turbidity_2(b2005_s4, b2005_s5, b2005_sQA, file_2005_sQA, UL_2005_sQA, LR_2005_sQA);
            main_turbidity_2(b2005_w4, b2005_w5, b2005_wQA, file_2005_wQA, UL_2005_wQA, LR_2005_wQA);
            main_turbidity_2(b2010_s4, b2010_s5, b2010_sQA, file_2010_sQA, UL_2010_sQA, LR_2010_sQA);
            main_turbidity_2(b2010_w4, b2010_w5, b2010_wQA, file_2010_wQA, UL_2010_wQA, LR_2010_wQA);
            main_turbidity_2(b2015_s4, b2015_s5, b2015_sQA, file_2015_sQA, UL_2015_sQA, LR_2015_sQA);
            main_turbidity_2(b2015_w4, b2015_w5, b2015_wQA, file_2015_wQA, UL_2015_wQA, LR_2015_wQA);
            main_turbidity_2(b2020_s4, b2020_s5, b2020_sQA, file_2020_sQA, UL_2020_sQA, LR_2020_sQA);
            main_turbidity_2(b2020_w4, b2020_w5, b2020_wQA, file_2020_wQA, UL_2020_wQA, LR_2020_wQA);
        case 6
            disp('Displaying Geotemperature map')
            % Geo Map
            main_geo_temp_map_2(b2015_s10, b2015_sQA, file_2015_sQA, UL_2015_sQA, LR_2015_sQA);
            main_geo_temp_map_2(b2015_w10, b2015_wQA, file_2015_wQA, UL_2015_wQA, LR_2015_wQA);
            main_geo_temp_map_2(b2020_s10, b2020_sQA, file_2020_sQA, UL_2020_sQA, LR_2020_sQA);
            main_geo_temp_map_2(b2020_w10, b2020_wQA, file_2020_wQA, UL_2020_wQA, LR_2020_wQA);

        case 7
            disp('Displaying Clorophyll')
            % Clorophyll
            main_clorophyll_2(b2005_s1, b2005_s2, b2005_s3, b2005_sQA, file_2005_sQA, UL_2005_sQA, LR_2005_sQA);
            main_clorophyll_2(b2005_w1, b2005_w2, b2005_w3, b2005_wQA, file_2005_wQA, UL_2005_wQA, LR_2005_wQA);
            main_clorophyll_2(b2010_s1, b2010_s2, b2010_s3, b2010_sQA, file_2010_sQA, UL_2010_sQA, LR_2010_sQA);
            main_clorophyll_2(b2010_w1, b2010_w2, b2010_w3, b2010_wQA, file_2010_wQA, UL_2010_wQA, LR_2010_wQA);
            main_clorophyll_2(b2015_s1, b2015_s2, b2015_s3, b2015_sQA, file_2015_sQA, UL_2015_sQA, LR_2015_sQA);
            main_clorophyll_2(b2015_w1, b2015_w2, b2015_w3, b2015_wQA, file_2015_wQA, UL_2015_wQA, LR_2015_wQA);
            main_clorophyll_2(b2020_s1, b2020_s2, b2020_s3, b2020_sQA, file_2020_sQA, UL_2020_sQA, LR_2020_sQA);
            main_clorophyll_2(b2020_w1, b2020_w2, b2020_w3, b2020_wQA, file_2020_wQA, UL_2020_wQA, LR_2020_wQA);

        case 8
            disp('Displaying Temperature')
            % Temperature
            main_temp_2(b2015_s10);
            main_temp_2(b2015_w10);
            main_temp_2(b2020_s10);
            main_temp_2(b2020_w10);
        case 9
            disp('Displaying Water mask')
            % Water Mask
            main_water_mask_2(b2015_s10, b2015_sQA);
            main_water_mask_2(b2015_w10, b2015_wQA);
            main_water_mask_2(b2020_s10, b2020_sQA);
            main_water_mask_2(b2020_w10, b2020_wQA);
        case 10
            exit_status = true;
            %break;

        case '2005S'
            disp('Displaying: S U M M E R 2005')
            % Year 2005 Summer
            %Natural
            main_natural_2(b2005_s2, b2005_s3, b2005_s4)
            %InfraRed
            main_IR_2(b2005_s2, b2005_s3, b2005_s4)
            %NVDI
            main_NDVI_2(b2005_s4, b2005_s5)
            %Rrs
            main_Rrs_2(b2005_s1) %turbo?
            %Turbidity
            main_turbidity_2(b2005_s4, b2005_s5, b2005_sQA, file_2005_sQA, UL_2005_sQA, LR_2005_sQA) %?
            %Clorophyll
            main_clorophyll_2(b2005_s1, b2005_s2, b2005_s3, b2005_sQA, file_2005_sQA, UL_2005_sQA, LR_2005_sQA)

        case '2005W'
            disp('Displaying: W I N T E R 2005')
            % Year 2005 Winter
            %Natural
            main_natural_2(b2005_w2, b2005_w3, b2005_w4)
            %InfraRed
            main_IR_2(b2005_w2, b2005_w3, b2005_w4)
            %NVDI
            main_NDVI_2(b2005_w4, b2005_w5)
            %Rrs
            main_Rrs_2(b2005_w1) %turbo?
            %Turbidity
            main_turbidity_2(b2005_w4, b2005_w5, b2005_wQA, file_2005_wQA, UL_2005_wQA, LR_2005_wQA) %?
            %Clorophyll
            main_clorophyll_2(b2005_w1, b2005_w2, b2005_w3, b2005_wQA, file_2005_wQA, UL_2005_wQA, LR_2005_wQA)

        case '2010S'
            disp('Displaying: S U M M E R 2010')
            % Year 2010 Summer

            %Natural
            main_natural_2(b2010_s2, b2010_s3, b2010_s4)
            %InfraRed
            main_IR_2(b2010_s2, b2010_s3, b2010_s4)
            %NVDI
            main_NDVI_2(b2010_s4, b2010_s5)
            %Rrs
            main_Rrs_2(b2010_s1) %turbo?
            %Turbidity
            main_turbidity_2(b2010_s4, b2010_s5, b2010_sQA, file_2010_sQA, UL_2010_sQA, LR_2010_sQA) %?
            %Clorophyll
            main_clorophyll_2(b2010_s1, b2010_s2, b2010_s3, b2010_sQA, file_2010_sQA, UL_2010_sQA, LR_2010_sQA)

        case '2010W'
            disp('Displaying: W I N T E R 2010')
            % Year 2010 Winter

            %Natural
            main_natural_2(b2010_w2, b2010_w3, b2010_w4)
            %InfraRed
            main_IR_2(b2010_w2, b2010_w3, b2010_w4)
            %NVDI
            main_NDVI_2(b2010_w4, b2010_w5)
            %Rrs
            main_Rrs_2(b2010_w1) %turbo?
            %Turbidity
            main_turbidity_2(b2010_w4, b2010_w5, b2010_wQA, file_2010_wQA, UL_2010_wQA, LR_2010_wQA) %?
            %Clorophyll
            main_clorophyll_2(b2010_w1, b2010_w2, b2010_w3, b2010_wQA, file_2010_wQA, UL_2010_wQA, LR_2010_wQA)

        case '2015S'
            disp('Displaying: S U M M E R 2015')
            % Year 2015 Summer

            %Natural
            main_natural_2(b2015_s2, b2015_s3, b2015_s4)
            %InfraRed
            main_IR_2(b2015_s2, b2015_s3, b2015_s4)
            %NVDI
            main_NDVI_2(b2015_s4, b2015_s5)
            %Rrs
            main_Rrs_2(b2015_s1) %turbo?
            %Turbidity
            main_turbidity_2(b2015_s4, b2015_s5, b2015_sQA, file_2015_sQA, UL_2015_sQA, LR_2015_sQA) %?
            %Geo Map
            main_geo_temp_map_2(b2015_s10, b2015_sQA, file_2015_sQA, UL_2015_sQA, LR_2015_sQA)
            %Clorophyll
            main_clorophyll_2(b2015_s1, b2015_s2, b2015_s3, b2015_sQA, file_2015_sQA, UL_2015_sQA, LR_2015_sQA)
            %Temperature
            main_temp_2(b2015_s10)
            %Water Mask
            main_water_mask_2(b2015_s10, b2015_sQA)
        case '2015W'
            disp('Displaying: W I N T E R 2015')
            % Year 2015 Winter

            %Natural
            main_natural_2(b2015_w2, b2015_w3, b2015_w4)
            %InfraRed
            main_IR_2(b2015_w2, b2015_w3, b2015_w4)
            %NVDI
            main_NDVI_2(b2015_w4, b2015_w5)
            %Rrs
            main_Rrs_2(b2015_w1) %turbo?
            %Turbidity
            main_turbidity_2(b2015_w4, b2015_w5, b2015_wQA, file_2015_wQA, UL_2015_wQA, LR_2015_wQA) %?
            %Geo Map
            main_geo_temp_map_2(b2015_w10, b2015_wQA, file_2015_wQA, UL_2015_wQA, LR_2015_wQA)
            %Clorophyll
            main_clorophyll_2(b2015_w1, b2015_w2, b2015_w3, b2015_wQA, file_2015_wQA, UL_2015_wQA, LR_2015_wQA)
            %Temperature
            main_temp_2(b2015_w10)
            %Water Mask
            main_water_mask_2(b2005_w10, b2005_wQA)
        case '2020S'
            disp('Displaying: S U M M E R 2020')
            % Year 2020 Summer

            %Natural
            main_natural_2(b2020_s2, b2020_s3, b2020_s4)
            %InfraRed
            main_IR_2(b2020_s2, b2020_s3, b2020_s4)
            %NVDI
            main_NDVI_2(b2020_s4, b2020_s5)
            %Rrs
            main_Rrs_2(b2020_s1) %turbo?
            %Turbidity
            main_turbidity_2(b2020_s4, b2020_s5, b2020_sQA, file_2020_sQA, UL_2020_sQA, LR_2020_sQA) %?
            %Geo Map
            main_geo_temp_map_2(b2020_s10, b2020_sQA, file_2020_sQA, UL_2020_sQA, LR_2020_sQA)
            %Clorophyll
            main_clorophyll_2(b2020_s1, b2020_s2, b2020_s3, b2020_sQA, file_2020_sQA, UL_2020_sQA, LR_2020_sQA)
            %Temperature
            main_temp_2(b2020_s10)
            %Water Mask
            main_water_mask_2(b2020_s10, b2020_sQA)

        case '2020W'
            disp('Displaying: W I N T E R 2020')
            % Year 2020 Winter

            %Natural
            main_natural_2(b2020_w2, b2020_w3, b2020_w4)
            %InfraRed
            main_IR_2(b2020_w2, b2020_w3, b2020_w4)
            %NVDI
            main_NDVI_2(b2020_w4, b2020_w5)
            %Rrs
            main_Rrs_2(b2020_w1) %turbo?
            Turbidity
            main_turbidity_2(b2020_w4, b2020_w5, b2020_wQA, file_2020_wQA, UL_2020_wQA, LR_2020_wQA) %?
            %Geo Map
            main_geo_temp_map_2(b2020_w10, b2020_wQA, file_2020_wQA, UL_2020_wQA, LR_2020_wQA)
            %Clorophyll
            main_clorophyll_2(b2020_w1, b2020_w2, b2020_w3, b2020_wQA, file_2020_wQA)
            %Temperature
            main_temp_2(b2020_w10)
            %Water Mask
            main_water_mask_2(b2020_w10, b2020_wQA)
    end

end
