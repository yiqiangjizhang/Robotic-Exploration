%-------------------------------------------------------------------------------------------------------%
% PROJECT
%-------------------------------------------------------------------------------------------------------%

% Date: 15/05/2021
% Author/s: Group 1
%   Rita Fardilha
%   Yi Qiang Ji
%   Èric Montserrat
%   Iván Sermanoukian
% Subject: Robotic Exploration of the Solar System
% Professor: Manel Soria & Arnau Miro

% Clear workspace, command window and close windows
clear all;
close all;
clc;

% Set interpreter to latex
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaulttextinterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

% % Recall that RESSlib should be in Matlab Path
% % Addpath Yi Qiang
% addpath 'C:\Users\yiqia\Documents\Spice_Doc\RESSlib'
% % Addpath Iván
% addpath('D:\HDD_Data\Iván\Workload\Q8-GRETA\Robotic_Exploration_of_the_Solar_System\RESSlib')
% % Addpath Èric
% addpath('F:\RESSoptativa\Resslib')
% % Addpath Rita
% addpath('C:\Users\Rita Fardilha\Desktop\RESSlib/');

if (~isfile('C1648109_RAW.IMG'))
    url = 'https://pds-rings.seti.org/holdings/volumes/COISS_1xxx/COISS_1002/data/1351738505_1351858128/N1351738505_2.IMG';
    filename = 'N1351738505_2.IMG';
    outfilename = websave(filename, url);
end

img = vicarread5('N1351738505_2.IMG');
imshow(img);

class(img) % data type
size(img) % size (TY,TX, number of channels)
% Matlab can manipulate images based on different data types
% The most usual are:
% uint8: 8 bits (0 to 255)
% uint16: 16 bits (0 to 65535)
% single, double: floating point images (0 to 1)

% figure(1);
% imshow(img);
% title('Original')

METAKR = {'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ck/00275_01001rc.bc', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ck/cas_cda_20070309.bc', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ck/cas_lemms_00306_00335_v2.bc', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/fk/cas_dyn_v03.tf', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/fk/cas_mimi_v202.tf', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/fk/cas_rocks_v18.tf', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/fk/cas_v41.tf', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_caps_v03.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_cda_v01.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_cirs_v09.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_inms_v02.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_iss_v10.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_mag_v01.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_mimi_v11.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_radar_v11.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_rpws_v01.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_rss_v03.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_sru_v02.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/ik/cas_vims_v06.ti', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/lsk/naif0012.tls', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/pck/pck00010.tpc', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/sclk/cas00172.tsc', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/spk/140809BP_IRRE_00256_25017.bsp', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/spk/180927AP_RE_90165_18018.bsp', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/spk/co_1999312_01066_o_cru_v1.bsp', ...
        'https://naif.jpl.nasa.gov/pub/naif/pds/data/co-s_j_e_v-spice-6-v1.0/cosp_1000/data/spk/sat359_97288_04003.bsp'};
initSPICEv(fullK(METAKR)); % Init SPICE and load the kernels, if needed

f_INS = 'CASSINI_ISS_NAC';
% SPICE name of the instrument that recorded the image to be processed
% gipool returns the value of an integer kernel variable (scalar or array) from the kernel pool
% In this case, we want to query the number of pixels of the sensor
% this would be equivalent to read the file
% https://naif.jpl.nasa.gov/pub/naif/CASSINI/kernels/ik/cas_iss_v10.ti
% and look for INS-82360_PIXEL_SAMPLES and INS-82360_PIXEL_LINES
[NPX, f] = cspice_gipool('INS-82360_PIXEL_SAMPLES', 1, 1); % number of pixels in X (number of columns)
[NPY, f] = cspice_gipool('INS-82360_PIXEL_LINES', 1, 1); % number of pixels in Y (number of rows)
[code_inst, found] = cspice_bodn2c(f_INS); % translates the name of a body or object to the corresponding SPICE integer ID code

if (~found)
    txt = sprintf('Unable to determine ID for instrument: %d', name);
    error(txt)
end

% Field-of-view parameters
room = 4; % Number of 3 components vectors we expect to receive in bounds
% 4 is ok for a rectangle
[shape, iframe, bsight, bounds] = cspice_getfov(code_inst, room);

c1 = bounds(:, 1); c2 = bounds(:, 2);
c3 = bounds(:, 3); c4 = bounds(:, 4);

method = 'ELLIPSOID';
target = 'JUPITER';

utctime = '2000-0306 T02:44:03.167'; % Our starting date
et = cspice_str2et (utctime);

fixref = 'IAU_JUPITER';
abcorr = 'LT';
dref = iframe;

obsrvr = 'CASSINI';
lambda_x = linspace(0, 1, NPX);
lambda_y = linspace(0, 1, NPY);

for (i = 1:1:NPX)

    for (j = 1:1:NPY)
        dvec = [c1(1) * (1 - lambda_x(i)) + c2(1) * (lambda_x(i));
            c1(2) * (1 - lambda_y(j)) + c3(2) * (lambda_y(j));
            1];

        [spoint, trgepc, srfvec, found] = cspice_sincpt(method, target, ...
            et, fixref, abcorr, ...
            obsrvr, dref, dvec);
    end

end
