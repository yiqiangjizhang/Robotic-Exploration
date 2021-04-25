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
NDAYS = 12; %study time

et1 = et0 + 24*3600*NDAYS; % end of query time
et12 = et02 + 24*3600*NDAYS; % end of query time

et=linspace(et0,et1,10000);
et2=linspace(et02,et12,10000);

LW=3; % LineWidth of the plots

frame = 'ECLIPJ2000';
abcorr = 'NONE';

% The same but the observer now will be Jupiter barycenter
observer = 'SUN'; % Jupiter barycenter (not Jupiter system barycenter)
scale = 149597871; % Jupiter polar radius (km) 

[djup,lt] = cspice_spkezr('599',et,frame,abcorr,observer); % jupiter 
[dio, lt] = cspice_spkezr('501',et,frame,abcorr,observer); % io
[deu, lt] = cspice_spkezr('502',et,frame,abcorr,observer); % europa
[dv1, lt] = cspice_spkezr('VG1',et,frame,abcorr,observer); % voyager1
[dv2, lt] = cspice_spkezr('VG2',et2,frame,abcorr,observer); % voyager2
[dsun, lt] = cspice_spkezr('10',et2,frame,abcorr,observer); 

Pos1=zeros(1,3);
Pos2=zeros(1,3);
Dist1=zeros(1,10000);
Dist2=zeros(1,10000);

Dist1(1,1)= sqrt(   (djup(1,1)-dv1(1,1))^2 + (djup(2,1)-dv1(2,1))^2 + (djup(3,1)-dv1(3,1))^2  ); 
Dist2(1,1)= sqrt(   (djup(1,1)-dv2(1,1))^2 + (djup(2,1)-dv2(2,1))^2 + (djup(3,1)-dv2(3,1))^2  );
for i=2:10000
    
   Dist1(1,i)= sqrt(   (djup(1,i)-dv1(1,i))^2 + (djup(2,i)-dv1(2,i))^2 + (djup(3,i)-dv1(3,i))^2  );
  
   Dist2(1,i)= sqrt(   (djup(1,i)-dv2(1,i))^2 + (djup(2,i)-dv2(2,i))^2 + (djup(3,i)-dv2(3,i))^2  );
   if (Dist1(1,i) < Dist1(1,i-1))
    Pos1(1,1)=dv1(1,i);
    Pos1(1,2)=dv1(2,i);
    Pos1(1,3)=dv1(3,i);
    a=i;
   else
   end
    if (Dist2(1,i) < Dist2(1,i-1))
    Pos2(1,1)=dv2(1,i);
    Pos2(1,2)=dv2(2,i);
    Pos2(1,3)=dv2(3,i);
    b=i;
   else
   end 
   Min1= sqrt(   (djup(1,i)-Pos1(1,1))^2 + (djup(2,i)-Pos1(1,2))^2 + (djup(3,i)-Pos1(1,3))^2  );
   Min2= sqrt(   (djup(1,i)-Pos2(1,1))^2 + (djup(2,i)-Pos2(1,2))^2 + (djup(3,i)-Pos2(1,3))^2  );
end

figure(3);



plot3(Pos1(1,1)/scale,Pos1(1,2)/scale,Pos1(1,3)/scale,'g*','LineWidth',6)
hold on
plot3(Pos2(1,1)/scale,Pos2(1,2)/scale,Pos2(1,3)/scale,'r*','LineWidth',6)
plot3(dsun(1,:)/scale,dsun(2,:)/scale,dsun(3,:)/scale,'p','LineWidth',LW)
xlabel('AU');
ylabel('AU');
zlabel('AU');
xlim([-4 4])
ylim([-4 6])
% axis('equal');
legend({'PosV1','PosV2','SUN'});
title('Jupiter Voyager 1 and 2 flyby. Obs: Sun');
grid
set(findall(gcf,'-property','FontSize'),'FontSize',18);

endSPICE