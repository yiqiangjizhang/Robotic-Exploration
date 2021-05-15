
%% IO-NH

% Minimum distance date between IO and New Horizons 
min_dist_time_NHIO = linspace(etJ(I),etJ(I),1);

% IO's position in minimum distance date
[dio_t,lt] = cspice_spkezr('501',min_dist_time_NHIO,frame,abcorr,observer);

% Distance vector between IO and New Horizons
v1 = [PosMin_NhIo(1,1)/scale PosMin_NhIo(1,2)/scale PosMin_NhIo(1,3)/scale];
v2 = [dio_t(1,1)/scale dio_t(2,1)/scale dio_t(3,1)/scale];
v  = [v2;v1];
D  = v2 - v1;
% Plot New Horizons Flyby on IO
LW = 1; % LineWidth specification
plot_pdf7 = figure(7);
set(plot_pdf7,'Position',[5 500 800 500])
plot3(dnh(1,:)/scale,dnh(2,:)/scale,dnh(3,:)/scale,'g','LineWidth',LW);
hold on;
plot3(PosMin_NhIo(1,1)/scale,PosMin_NhIo(1,2)/scale,PosMin_NhIo(1,3)/scale,'b*','LineWidth',6)
plot3(dio_t(1,1)/scale,dio_t(2,1)/scale,dio_t(3,1)/scale,'m*','LineWidth',3);
plot3(v(:,1),v(:,2),v(:,3),'r')
quiver3( v1(1), v1(2),v1(3), D(1), D(2),D(3),0, 'Color',[0 0 0]);

% annotation('textbox', [0.75, 0.35, .19, .1], 'string', sprintf('Min dist NH-Jup: %.4f [km]',MinNhJup))
% annotation('textbox', [0.75, 0.25, .19, .1], 'string', sprintf('Date: %s',convertCharsToStrings(utcstrNhJup)))

legend('New Horizons', 'Minimum Distance Position', 'IO', 'Minimum Distance');
xlabel('x JR');
ylabel('y JR');
zlabel('z JR');
axis equal;
% title("\textbf{New Horizons' flyby across Jupiter. Observer: Jupiter barycenter}");
grid on;
grid minor;


%% Europe-NH
% Minimum distance date between Europe and New Horizons 
min_dist_time_NHEU = linspace(etJ(E),etJ(E),1);

% IO's position in minimum distance date
[deur_t,lt] = cspice_spkezr('502',min_dist_time_NHEU,frame,abcorr,observer);

% Distance vector between Europa and New Horizons
v1 = [PosMin_NhEuropa(1,1)/scale PosMin_NhEuropa(1,2)/scale PosMin_NhEuropa(1,3)/scale];
v2 = [deur_t(1,1)/scale deur_t(2,1)/scale deur_t(3,1)/scale];
v  = [v2;v1];
D  = v2 - v1;
% Plot New Horizons Flyby on Europe
LW = 1; % LineWidth specification
plot_pdf8 = figure(8);
set(plot_pdf8,'Position',[5 500 800 500])
plot3(dnh(1,:)/scale,dnh(2,:)/scale,dnh(3,:)/scale,'g','LineWidth',LW);
hold on;
plot3(PosMin_NhEuropa(1,1)/scale,PosMin_NhEuropa(1,2)/scale,PosMin_NhEuropa(1,3)/scale,'b*','LineWidth',6)
plot3(deur_t(1,1)/scale,deur_t(2,1)/scale,deur_t(3,1)/scale,'m*','LineWidth',3);
plot3(v(:,1),v(:,2),v(:,3),'r')
quiver3( v1(1), v1(2),v1(3), D(1), D(2),D(3),0, 'Color',[0 0 0]);

% annotation('textbox', [0.75, 0.35, .19, .1], 'string', sprintf('Min dist NH-Jup: %.4f [km]',MinNhJup))
% annotation('textbox', [0.75, 0.25, .19, .1], 'string', sprintf('Date: %s',convertCharsToStrings(utcstrNhJup)))

legend('New Horizons', 'Minimum Distance Position', 'Europe', 'Minimum Distance');
xlabel('x JR');
ylabel('y JR');
zlabel('z JR');
axis equal;
% title("\textbf{New Horizons' flyby across Jupiter. Observer: Jupiter barycenter}");
grid on;
grid minor;



%% Ganymede-NH
% Minimum distance date between Ganymede and New Horizons 
min_dist_time_NHG = linspace(etJ(G),etJ(G),1);

% IO's position in minimum distance date
[dgan_t,lt] = cspice_spkezr('503',min_dist_time_NHG,frame,abcorr,observer);

% Distance vector between Ganymede and New Horizons
v1 = [PosMin_NhGanymede(1,1)/scale PosMin_NhGanymede(1,2)/scale PosMin_NhGanymede(1,3)/scale];
v2 = [dgan_t(1,1)/scale dgan_t(2,1)/scale dgan_t(3,1)/scale];
v  = [v2;v1];
D  = v2 - v1;
% Plot New Horizons Flyby on Ganymede
LW = 1; % LineWidth specification
plot_pdf9 = figure(9);
set(plot_pdf9,'Position',[5 500 800 500])
plot3(dnh(1,:)/scale,dnh(2,:)/scale,dnh(3,:)/scale,'g','LineWidth',LW);
hold on;
plot3(PosMin_NhGanymede(1,1)/scale,PosMin_NhGanymede(1,2)/scale,PosMin_NhGanymede(1,3)/scale,'b*','LineWidth',6)
plot3(dgan_t(1,1)/scale,dgan_t(2,1)/scale,dgan_t(3,1)/scale,'m*','LineWidth',3);
plot3(v(:,1),v(:,2),v(:,3),'r')
quiver3( v1(1), v1(2),v1(3), D(1), D(2),D(3),0, 'Color',[0 0 0]);

% annotation('textbox', [0.75, 0.35, .19, .1], 'string', sprintf('Min dist NH-Jup: %.4f [km]',MinNhJup))
% annotation('textbox', [0.75, 0.25, .19, .1], 'string', sprintf('Date: %s',convertCharsToStrings(utcstrNhJup)))

legend('New Horizons', 'Minimum Distance Position', 'Ganymede', 'Minimum Distance');
xlabel('x JR');
ylabel('y JR');
zlabel('z JR');
axis equal;
% title("\textbf{New Horizons' flyby across Jupiter. Observer: Jupiter barycenter}");
grid on;
grid minor;

%% Callisto-NH
% Minimum distance date between Callisto and New Horizons 
min_dist_time_NHG = linspace(etJ(C),etJ(C),1);

% IO's position in minimum distance date
[dcal_t,lt] = cspice_spkezr('504',min_dist_time_NHG,frame,abcorr,observer);

% Distance vector between Callisto and New Horizons
v1 = [PosMin_NhCallisto(1,1)/scale PosMin_NhCallisto(1,2)/scale PosMin_NhCallisto(1,3)/scale];
v2 = [dcal_t(1,1)/scale dcal_t(2,1)/scale dcal_t(3,1)/scale];
v  = [v2;v1];
D  = v2 - v1;
% Plot New Horizons Flyby on Callisto
LW = 1; % LineWidth specification
plot_pdf10 = figure(10);
set(plot_pdf10,'Position',[5 500 800 500])
plot3(dnh(1,:)/scale,dnh(2,:)/scale,dnh(3,:)/scale,'g','LineWidth',LW);
hold on;
plot3(PosMin_NhCallisto(1,1)/scale,PosMin_NhCallisto(1,2)/scale,PosMin_NhCallisto(1,3)/scale,'b*','LineWidth',6)
plot3(dcal_t(1,1)/scale,dcal_t(2,1)/scale,dcal_t(3,1)/scale,'m*','LineWidth',3);
plot3(v(:,1),v(:,2),v(:,3),'r')
quiver3( v1(1), v1(2),v1(3), D(1), D(2),D(3),0, 'Color',[0 0 0]);

% annotation('textbox', [0.75, 0.35, .19, .1], 'string', sprintf('Min dist NH-Jup: %.4f [km]',MinNhJup))
% annotation('textbox', [0.75, 0.25, .19, .1], 'string', sprintf('Date: %s',convertCharsToStrings(utcstrNhJup)))

legend('New Horizons', 'Minimum Distance Position', 'Callisto', 'Minimum Distance');
xlabel('x JR');
ylabel('y JR');
zlabel('z JR');
axis equal;
% title("\textbf{New Horizons' flyby across Jupiter. Observer: Jupiter barycenter}");
grid on;
grid minor;