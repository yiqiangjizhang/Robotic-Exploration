% Manel Soria July 2019
% Simple example to start with SPICE
% Plot the position of Jupiter, Io, Europa and VG1 during VG1 flyby
% Use ECLIPJ2000 and the SS barycenter as observer, then Jupiter barycenter
% as observer

close all; 

clear; 

% Recall that RESSlib should be in Matlab Path 

% From kernels we get the desired data.
METAKR={'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls', ... % leap seconds
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr1_jup230.bsp',... % kernel of voyager 1's flyby of Jupiter 
        'https://naif.jpl.nasa.gov/pub/naif/VOYAGER/kernels/spk/vgr2_jup230.bsp',... % kernel of voyager 2's flyby of Jupiter 
        'https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/satellites/jup365.bsp' }; % Jupiter system

v=initSPICEv(fullK(METAKR));

fprintf('RESSLIB version %s \n',v);

utctime='1979-03-03 T00:00:00'; %1979-03-03 T00:00:00
utctime2='1979-07-07 T00:00:00';
et0 = cspice_str2et ( utctime ); %converts time (is a string )to a number
et02 = cspice_str2et ( utctime2 ); %converts time (is a string )to a number
NDAYS = 9; %study time

et1 = et0 + 24*3600*NDAYS; % end of query time
et12 = et02 + 24*3600*NDAYS; % end of query time

et=linspace(et0,et1,10000);
et2=linspace(et02,et12,10000);

LW=3; % LineWidth of the plots

frame = 'ECLIPJ2000';
abcorr = 'NONE';

% figure(1);
% 
% observer = '0'; % Solar System  barycenter. %Observer is the position.
% scale = 149597871 ; % AU (km) 
% 
% %https://nssdc.gsfc.nasa.gov/planetary/factsheet/jupiterfact.html
% 
% [djup,lt] = cspice_spkezr('599',et,frame,abcorr,observer); % jupiter % 
% [dio, lt] = cspice_spkezr('501',et,frame,abcorr,observer); % io
% [deu, lt] = cspice_spkezr('502',et,frame,abcorr,observer); % europa
% [dv1, lt] = cspice_spkezr('VG1',et,frame,abcorr,observer); % voyager1
% plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'r','LineWidth',LW)
% hold on
% plot3(dio(1,:)/scale,dio(2,:)/scale,dio(3,:)/scale,'g','LineWidth',LW)
% plot3(deu(1,:)/scale,deu(2,:)/scale,deu(3,:)/scale,'b','LineWidth',LW)
% plot3(dv1(1,:)/scale,dv1(2,:)/scale,dv1(3,:)/scale,'k','LineWidth',LW)
% xlabel('AU');
% ylabel('AU');
% zlabel('AU');
% axis('equal');
% legend({'J','I','E','V1'});
% title('Jupiter Voyager 1 flyby. Obs: SS barycenter');
% grid
% set(findall(gcf,'-property','FontSize'),'FontSize',18);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure(2);
% 
% observer = '0'; % Solar System  barycenter. %Observer is the position.
% scale = 149597871 ; % AU (km) 
% 
% %https://nssdc.gsfc.nasa.gov/planetary/factsheet/jupiterfact.html
% 
% [djup,lt] = cspice_spkezr('599',et2,frame,abcorr,observer); % jupiter % 
% [dio, lt] = cspice_spkezr('501',et2,frame,abcorr,observer); % io
% [deu, lt] = cspice_spkezr('502',et2,frame,abcorr,observer); % europa
% [dv2, lt] = cspice_spkezr('VG2',et2,frame,abcorr,observer); % voyager2
% plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'r','LineWidth',LW)
% hold on
% plot3(dio(1,:)/scale,dio(2,:)/scale,dio(3,:)/scale,'g','LineWidth',LW)
% plot3(deu(1,:)/scale,deu(2,:)/scale,deu(3,:)/scale,'b','LineWidth',LW)
% plot3(dv2(1,:)/scale,dv2(2,:)/scale,dv2(3,:)/scale,'y','LineWidth',LW)
% xlabel('AU');
% ylabel('AU');
% zlabel('AU');
% axis('equal');
% legend({'J','I','E','V2'});
% title('Jupiter Voyager 2 flyby. Obs: SS barycenter');
% grid
% set(findall(gcf,'-property','FontSize'),'FontSize',18);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The same but the observer now will be Jupiter barycenter
observer = '5'; % Jupiter barycenter (not Jupiter system barycenter)
scale =66854; % Jupiter polar radius (km) 149597871; %

[djup,lt] = cspice_spkezr('599',et,frame,abcorr,observer); % jupiter 
[dio, lt] = cspice_spkezr('501',et2,frame,abcorr,observer); % io
[deu, lt] = cspice_spkezr('502',et2,frame,abcorr,observer); % europa
[dv1, lt] = cspice_spkezr('VG1',et,frame,abcorr,observer); % voyager1
[dv2, lt] = cspice_spkezr('VG2',et2,frame,abcorr,observer); % voyager2

Pos1=zeros(1,3);
Pos2=zeros(1,3);
Dist1=zeros(1,10000);
Dist2=zeros(1,10000);

Dist1(1,1)= sqrt(   (djup(1,1)-dv1(1,1))^2 + (djup(2,1)-dv1(2,1))^2 + (djup(3,1)-dv1(3,1))^2  ); 
Dist2(1,1)= sqrt(   (djup(1,1)-dv2(1,1))^2 + (djup(2,1)-dv2(2,1))^2 + (djup(3,1)-dv2(3,1))^2  );
for i=2:10000
    
   Dist1(1,i)= sqrt(   (djup(1,i)-dv1(1,i))^2 + (djup(2,i)-dv1(2,i))^2 + (djup(3,i)-dv1(3,i))^2  ); %Calculate distance V1-Jupiter
   Dist2(1,i)= sqrt(   (djup(1,i)-dv2(1,i))^2 + (djup(2,i)-dv2(2,i))^2 + (djup(3,i)-dv2(3,i))^2  ); %Calculate distance V2-Jupiter
   if (Dist1(1,i) < Dist1(1,i-1)) %Check current distance with past value
    Pos1(1,1)=dv1(1,i); %If true, save position X Y Z of V1
    Pos1(1,2)=dv1(2,i);
    Pos1(1,3)=dv1(3,i);
    Min1=Dist1(1,i)/scale;    %If true, save Distance between V1-JUP
    a=i;                %If true, save column's index where condition is satisfied
   end
    if (Dist2(1,i) < Dist2(1,i-1)) %Check current distance with past value
    Pos2(1,1)=dv2(1,i); %If true, save position X Y Z of V2
    Pos2(1,2)=dv2(2,i);
    Pos2(1,3)=dv2(3,i);
    Min2=Dist2(1,i)/scale;   %If true, save Distance between V2-JUP
    b=i;               %If true, save column's index where condition is satisfied
   end 
end
utcstrV1= cspice_et2utc( et(a), 'C', 5 ); %Convert ephemeris time into UTC format C calendar. Date of the closest position to saturn.v1
utcstrV2= cspice_et2utc( et2(b), 'C', 5 ); %Convert ephemeris time into UTC format C calendar. Date of the closest position to saturn.v2

figure(3);

plot3(djup(1,:)/scale,djup(2,:)/scale,djup(3,:)/scale,'r','LineWidth',LW)
hold on
plot3(dio(1,:)/scale,dio(2,:)/scale,dio(3,:)/scale,'g','LineWidth',LW)
plot3(deu(1,:)/scale,deu(2,:)/scale,deu(3,:)/scale,'b','LineWidth',LW)
plot3(dv1(1,:)/scale,dv1(2,:)/scale,dv1(3,:)/scale,'k','LineWidth',LW)
plot3(dv2(1,:)/scale,dv2(2,:)/scale,dv2(3,:)/scale,'y','LineWidth',LW)
plot3(Pos1(1,1)/scale,Pos1(1,2)/scale,Pos1(1,3)/scale,'g*','LineWidth',6)
plot3(Pos2(1,1)/scale,Pos2(1,2)/scale,Pos2(1,3)/scale,'r*','LineWidth',6)

text(Pos1(1,1)/scale,-20,Pos1(1,3)/scale,'V1-JP = 5.2187 JR')
text(-10,-20,Pos1(1,3)/scale,'V1-JP 1979 MAR 05 12:04:32.18718')

text(-35,-25,Pos2(1,3)/scale,'V2-JP = 10.7919 JR')
text(-45,-25,Pos2(1,3)/scale,'V2-JP 1979 JUL 09 22:29:16.25571')

xlabel('JR');
ylabel('JR');
zlabel('JR');
axis('equal');
legend({'Jupiter','Io','E','V1','V2','Pos1','Pos2'});
title('Jupiter Voyager 1 and 2 flyby. Obs: Jupiter barycenter');
grid
% set(findall(gcf,'-property','FontSize'),'FontSize',18);

endSPICE