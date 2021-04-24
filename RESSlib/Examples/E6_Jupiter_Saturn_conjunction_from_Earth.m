% Sergi Berdor December 2020
% Manel Soria April 2021
% 1-Plot the angle formed by Jupiter and Saturn seen from Earth from 1850
% to 2250
% 2-Find the minimum angle and zoom around it

% Note that a significant part of the code is repeated, this is a bad
% practice. It has to be improved, creating a function that is called
% twice.
% Also, fminunc could be used to find the minmum. 

close all;
clear;

% List of the kernels URL:
METAKR={ 'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls', ...
 'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/de430.bsp', ...
 'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/pck/Gravity.tpc' };
initSPICEv(fullK(METAKR)); % Init SPICE and load the kernels, if needed

utctime0='2000-01-01'; % Our starting date
et0 = cspice_str2et ( utctime0 ); % Call SPICE to convert it to ET0
utctime1='2030-01-01'; % Our end date
et1 = cspice_str2et ( utctime1 ); % Call SPICE to convert it to ET1
et=linspace(et0,et1,10000); % Vector of instants

frame = 'ECLIPJ2000'; % Referece frames
abcorr = 'NONE'; % No corrections
observer = '0'; %  It doesn't matter

[dearth,lt] = cspice_spkpos('399',et,frame,abcorr,observer); % Pos Earth
[djup, lt] = cspice_spkpos('5',et,frame,abcorr,observer); % Pos Jupiter
[dsat, lt] = cspice_spkpos('6',et,frame,abcorr,observer); % Pos Saturn

a = djup - dearth;      % Vector from Earth to Jupiter
b = dsat - dearth;      % Vector from Earth to Saturn

for i=1:numel(et)
    dateAux = cspice_et2utc(et(i), 'C', 0);    % Date in Calendar format
    stringDate = append(dateAux(1:4),'-',lower(dateAux(6:8)),'-',dateAux(10:11)); % Date in 'InputFormat'
    dates(i) = datetime(stringDate,'InputFormat','yyyy-MMM-dd');  % Dates in datetime
    norma(i) = norm(a(:,i));    % Norm of each vector
    normb(i) = norm(b(:,i));
    angle(i) = rad2deg(acos((dot(a(:,i),b(:,i)))/(norma(i)*normb(i)))); % Angle at each instant
end
figure(1);
set(findall(gcf,'-property','FontSize'),'FontSize',13)
plot(dates,angle);
xlabel('date');
ylabel('degrees');
title(sprintf('Angular distance between Jupiter and Saturn seen from Earth'))
set(findall(gcf,'-property','FontSize'),'FontSize',13)

% Find the minimum
mina = min(angle);
[df, mindate] = find(angle==mina);

etmin=et(mindate);

fprintf('Approximate conjunction UTC = %s Angular distance = %f deg\n',cspice_et2utc(etmin, 'C', 0),mina);

% Refine the search around the approx min
et0=etmin-3600*20;
et1=etmin+3600*20; 
et=linspace(et0,et1,1000);
[dearth,lt] = cspice_spkpos('399',et,frame,abcorr,observer); % Pos Earth
[djup, lt] = cspice_spkpos('5',et,frame,abcorr,observer); % Pos Jupiter
[dsat, lt] = cspice_spkpos('6',et,frame,abcorr,observer); % Pos Saturn
a = djup - dearth;      % Vector from Earth to Jupiter
b = dsat - dearth;      % Vector from Earth to Saturn

angle=[];
for i=1:numel(et)
    norma(i) = norm(a(:,i));    % Norm of each vector
    normb(i) = norm(b(:,i));
    angle(i) = rad2deg(acos((dot(a(:,i),b(:,i)))/(norma(i)*normb(i)))); % Angle at each instant
end

figure(2);
set(findall(gcf,'-property','FontSize'),'FontSize',18)
plot(et,angle,'-');
xlabel('et');
ylabel('degrees');
title(sprintf('Angular distance between Jupiter and Saturn seen from Earth %s',cspice_et2utc(etmin, 'C', 0)))
set(findall(gcf,'-property','FontSize'),'FontSize',18)

mina = min(angle);
[df, mindate] = find(angle==mina);
etmin=et(mindate);
fprintf('Refined conjunction UTC = %s Angular distance = %f deg\n',cspice_et2utc(etmin, 'C', 0),mina);

% References
% http://nightskyonline.info/wp-content/uploads/2016/10/2020_Jupiter_Saturn_close_encounter_poster_A3_size.pdf

endSPICE; % Unload the kernels 