close all;
clear; 

%Test Git
% Recall that RESSlib should be in Matlab Path 

showImages=1; 

load('CassiniAll.mat'); % All Cassini spk kernels are obtained from
                        % exercise 3 (E3_Cassini Trajectory)
                        
spacecraftid='CASSINI';
encounter='SATURN';

L=getAllLists(spacecraftid,encounter); % get summary files

% Load time kernel

MK{end+1}='https://naif.jpl.nasa.gov/pub/naif/generic_kernels/lsk/naif0012.tls';
initSPICEv(fullK(MK)); % fullK forms the full list needed by initSPICEv


% Time of all images
et=zeros(L.nd,1);
for i=1:L.nd
    et(i)=cspice_str2et(L.timestr{i});
end

onlyRHEA=find(strcmp(L.target,"RHEA")); % Indices of all Rhea images NOT sorted by time

% Sort by et
[~,indx]=sort(et(onlyRHEA));
onlyRHEA=onlyRHEA(indx);

%%

% A-Download and represent some images (arbitrarily selected)

for i=3400:3400 
    fprintf('Rhea Image %d/%d <%s>\n',i,numel(onlyRHEA),L.timestr{onlyRHEA(i)});
    a=getVoyagerCassiniImage(L,onlyRHEA(i),'CALIB');
    if showImages==1
        figure
        imshow(a);
    end
end

% B-Plot the distance from Rhea to Cassini for each image; download and
% represent the 10 images taken from shorter distance. Print their time
% WARNING: ALL CASSINI KERNELS SHOULD BE LOADED TO RUN THIS 

et_Rhea=et(onlyRHEA); % Time only of the images correspondent to Rhea
et_Rhea=et_Rhea.'; 
 
% Computation of the distance

frame = 'ECLIPJ2000';
abcorr = 'NONE';
observer='SUN';

[dCassini,lt]=cspice_spkezr('CASSINI',et_Rhea,frame,abcorr,observer);
[dRhea,lt]=cspice_spkezr('RHEA',et_Rhea,frame,abcorr,observer);
d=dCassini-dRhea; 
d=d(1:3,:); 
nd=vecnorm(d); % [km]

% Plots

image_number=1:length(onlyRHEA);

figure(1)
plot(image_number,nd,'k')
% set(figure(1),'Renderer', 'painters', 'Position', [400 400 500 350]);
set(gca,'TickLabelInterpreter','latex','fontsize',10)
xlabel('Number of the image','interpreter','latex','FontSize',12);
ylabel('Distance from Rhea to Cassini','interpreter','latex','FontSize',12);
grid

figure(2)
plot(et_Rhea,nd,'k')
set(gca,'TickLabelInterpreter','latex','fontsize',10)
xlabel('ET','interpreter','latex','FontSize',12);
ylabel('Distance from Rhea to Cassini','interpreter','latex','FontSize',12);
grid

% Representation of the 10 images taken from the the shorter distance

[Min_nd,Pos_Min]=sort(nd);

for i=1:10
    fprintf('Rhea Image %d/%d <%s>\n',Pos_Min(i),numel(onlyRHEA),L.timestr{onlyRHEA(Pos_Min(i))});
    a=getVoyagerCassiniImage(L,onlyRHEA(Pos_Min(i)),'CALIB');
    imshow(a)
end



