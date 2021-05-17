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

% Data bands 2005
b2005 = zeros(,, 6)
b2005(:, :, 1) = imread(''); % Blue band
b2005(:, :, 2) = imread(''); %
b2005(:, :, 3) = imread(''); %
b2005(:, :, 4) = imread(''); %
b2005(:, :, 5) = imread(''); %
b2005(:, :, 6) = imread(''); % b10 temp

file_b3_2005 = ''; b3 = imread(file_b3_2005); % Greenband
file_b4_2005 = ''; b4 = imread(file_b4_2005); % Red band
file_b4_2005 = ''; b4 = imread(file_b4_2005);
file_b5_2005 = ''; b5 = imread(file_b5_2005);
file_b10_2005 = ''; b10 = imread(file_b10_2005);
file_QA_2005 = ''; QA = imread(file_QA_2005);

% Data bands 2010

b2010 = zeros(1, 6)
b2010(:, :, 1) = imread(''); % Blue band
b2010(:, :, 2) = imread(''); %
b2010(:, :, 3) = imread(''); %
b2010(:, :, 4) = imread(''); %
b2010(:, :, 5) = imread(''); %
b2010(:, :, 6) = imread(''); % b10 temp

file_b2_2010 = ''; b2 = imread(file_b2_2010); % Blue band
file_b3_2010 = ''; b3 = imread(file_b3_2010); % Greenband
file_b4_2010 = ''; b4 = imread(file_b4_2010); % Red band
file_b4_2010 = ''; b4 = imread(file_b4_2010);
file_b5_2010 = ''; b5 = imread(file_b5_2010);
file_b10_2010 = ''; b10 = imread(file_b10_2010);
file_QA = ''; QA = imread(file_QA);

% Data bands 2015

b2015 = zeros(1, 6)
b2015(:, :, 1) = imread(''); % Blue band
b2015(:, :, 2) = imread(''); %
b2015(:, :, 3) = imread(''); %
b2015(:, :, 4) = imread(''); %
b2015(:, :, 5) = imread(''); %
b2015(:, :, 6) = imread(''); % b10 temp

file_b2_2015 = ''; b2 = imread(file_b2_2015); % Blue band
file_b3_2015 = ''; b3 = imread(file_b3_2015); % Greenband
file_b4_2015 = ''; b4 = imread(file_b4_2015); % Red band
file_b4_2015 = ''; b4 = imread(file_b4_2015);
file_b5_2015 = ''; b5 = imread(file_b5_2015);
file_b10_2015 = ''; b10 = imread(file_b10_2015);
file_QA_2015 = ''; QA = imread(file_QA_2015);

% Data bands 2020

b2020 = zeros(1, 6)
b2020(:, :, 1) = imread(''); % Blue band
b2020(:, :, 2) = imread(''); %
b2020(:, :, 3) = imread(''); %
b2020(:, :, 4) = imread(''); %
b2020(:, :, 5) = imread(''); %
b2020(:, :, 6) = imread(''); % b10 temp

file_b2_2020 = ''; b2 = imread(file_b2_2020); % Blue band
file_b3_2020 = ''; b3 = imread(file_b3_2020); % Greenband
file_b4_2020 = ''; b4 = imread(file_b4_2020); % Red band
file_b4_2020 = ''; b4 = imread(file_b4_2020);
file_b5_2020 = ''; b5 = imread(file_b5_2020);
file_b10_2020 = ''; b10 = imread(file_b10_2020);
file_QA_2020 = ''; QA = imread(file_QA_2020);

%% Temperatura

%% Turbidity

%% Chlorofil

%% Zone

% 2010

% 2015

% 2020
