%% Ciaran O'Brien - 6714221
%  Low-Thrust Trajectory Design for Satellite Mega-Constellation Deployment
%  Optimal Transfer Validation
clear;
clc;
close all;
format longG;

%% Inputs
[inp,pars] = Constants;

r2d = 180/pi;
Re = inp.Earth.Re;

%% e = 1 (Energy Optimal)
e1 = 1;
Lambda1 = [0.052951601484711,-0.433729510633226,-0.074297601939783,-0.010802687297949,-0.286576792311210,0.487455447725607,0.013437745295469,0.695354847104579]';
ToF1 = 8.931708362514050;
t_1 = linspace(0,ToF1,1001);
[X1,Trajectory1] = ValidationPlotter(Lambda1,pars,e1,ToF1);

%% e = 0.8
e08 = 0.8;
Lambda08 = [0.050882143194070,-0.420537676877164,-0.079422418864296,-0.016197499000627,-0.272215596661602,0.480402326138806,0.013037689909964,0.713394058606491]';
ToF08 = 8.931708362514050;
t_08 = linspace(0,ToF08,1001);
[X08,Trajectory08] = ValidationPlotter(Lambda08,pars,e08,ToF08);

%% e = 0.6
e06 = 0.6;
Lambda06 = [0.046613069603988,-0.404072448059724,-0.087377491423800,-0.022607411890590,-0.252441258020173,0.473620549499254,0.012624179259634,0.733624136612541]';
ToF06 = 8.931708362514050;
t_06 = linspace(0,ToF06,1001);
[X06,Trajectory06] = ValidationPlotter(Lambda06,pars,e06,ToF06);

%% e = 0.4
e04 = 0.4;
Lambda04 = [0.039403348032695,-0.383649814810395,-0.097097966371287,-0.028451702429235,-0.227218343524590,0.465216876045541,0.012166011873518,0.756848566147266]';
ToF04 = 8.931708362514050;
t_04 = linspace(0,ToF04,1001);
[X04,Trajectory04] = ValidationPlotter(Lambda04,pars,e04,ToF04);

%% e = 0.2
e02 = 0.2;
Lambda02 = [0.029239753809010,-0.357363352653626,-0.106377812180640,-0.032607992846307,-0.196770528577284,0.451425630398956,0.011635805452918,0.785122804527631]';
ToF02 = 8.931708362514050;
t_02 = linspace(0,ToF02,1001);
[X02,Trajectory02] = ValidationPlotter(Lambda02,pars,e02,ToF02);

%% e = 0 (Fuel Optimal)
e0 = 0;
Lambda0 =[0.022014257918561,-0.335439605397943,-0.112049974579854,-0.030092526068178,-0.173238983161717,0.432929967806845,0.011228738205019,0.809918946423966]';
ToF0 = 8.931708362514050;
t_0 = linspace(0,ToF0,1001);
[X0,Trajectory0] = ValidationPlotter(Lambda0,pars,e0,ToF0);

%% Inital and Final Orbits
Xi = inp.Orbits.Inital;
Xf = inp.Orbits.Target;

%% Extract u

u1 = Trajectory1.u;
u08 = Trajectory08.u;
u06 = Trajectory06.u;
u04 = Trajectory04.u;
u02 = Trajectory02.u;
u0 = Trajectory0.u;

%% Extract Mass
m1 = 260-X1(:,7).*pars.Unit.MU;
m08 = 260-X08(:,7).*pars.Unit.MU;
m06 = 260-X06(:,7).*pars.Unit.MU;
m04 = 260-X04(:,7).*pars.Unit.MU;
m02 = 260-X02(:,7).*pars.Unit.MU;
m0 = 260-X0(:,7).*pars.Unit.MU;

Md = (X0(end,7)*pars.Unit.MU)-(X1(end,7)*pars.Unit.MU);

%% Extract Hamiltonian
H1 = Trajectory1.H;
H08 = Trajectory08.H;
H06 = Trajectory06.H;
H04 = Trajectory04.H;
H02 = Trajectory02.H;
H0 = Trajectory0.H;

%% Extract Switching Function
S1 = Trajectory1.SF;
S08 = Trajectory08.SF;
S06 = Trajectory06.SF;
S04 = Trajectory04.SF;
S02 = Trajectory02.SF;
S0 = Trajectory0.SF;

%% Plots
figure('Name','Deployment Orbit','NumberTitle','off')
plot3(Xi(1,:),Xi(2,:),Xi(3,:),'k')
hold on
plot3(Xi(1,1), Xi(2,1), Xi(3,1), '+r', 'LineWidth', 2)
% Plot Earth
[Xe,Ye,Ze] = sphere(50);
surf(Re*Xe, Re*Ye, Re*Ze, 'EdgeColor', 'none', 'FaceColor', '#56AC6E','FaceAlpha',0.5); 
axis equal;
grid on
box on
xlabel('X (km)'); ylabel('Y (km)'); zlabel('Z (km)')
title('Falcon 9 Upper Stage Orbit')
legend('Deployment Orbit','Transfer Starting Position','Earth')

figure('Name','Target Orbit','NumberTitle','off')
plot3(Xf(1,:),Xf(2,:),Xf(3,:),'k')
hold on
hold on
plot3(Xf(1,1), Xf(2,1), Xf(3,1), '+r', 'LineWidth', 2)
% Plot Earth
[Xe,Ye,Ze] = sphere(50);
surf(Re*Xe, Re*Ye, Re*Ze, 'EdgeColor', 'none', 'FaceColor', '#56AC6E'); hold on; axis equal;
grid on
box on
xlabel('X (km)'); ylabel('Y (km)'); zlabel('Z (km)')
title('Starlink-2398 Orbit')
legend('Starlink-2398','Transfer Target Position','Earth')

figure('Name','Both Orbits','NumberTitle','off')
plot3(Xi(1,:),Xi(2,:),Xi(3,:))
hold on
plot3(Xf(1,:),Xf(2,:),Xf(3,:))
xlabel('X (km)'); ylabel('Y (km)'); zlabel('Z (km)')
title('Initial Orbit and Target Orbit')
legend('Deployment Orbit','Starlink-2398')
grid on
box on

figure('Name','u','NumberTitle','off')
plot(t_1,u1,'b','LineWidth',0.5)
hold on
plot(t_08,u08,'-.','Color','#FF57C7','LineWidth',0.5)
plot(t_06,u06,'--','LineWidth',0.5)
plot(t_04,u04,'--','Color','#0ee1b9','LineWidth',0.5)
plot(t_02,u02,'-.','LineWidth',0.5)
plot(t_0,u0,'r','LineWidth',0.5)
grid on
ylim([-0.1 1.1])
legend([char(949) '=1'],[char(949) '=0.8'],[char(949) '=0.6'],[char(949) '=0.4'],[char(949) '=0.2'],[char(949) '=0'],'Location','bestoutside')
ylabel('Engine Thrust Ratio'); xlabel('Time (Hours)') ; title('Engine Thrust Ratio')

figure('Name','Mass','NumberTitle','off')
plot(t_1,m1,'b')
hold on
plot(t_08,m08,'Color','#FF57C7')
plot(t_06,m06)
plot(t_04,m04,'Color','#0ee1b9')
plot(t_02,m02)
plot(t_0,m0,'r')
grid on
legend([char(949) '=1'],[char(949) '=0.8'],[char(949) '=0.6'],[char(949) '=0.4'],[char(949) '=0.2'],[char(949) '=0'],'Location','bestoutside')
ylabel('Mass of Fuel Burnt (kg)'); xlabel('Time (Hours)'); title('Starlink Mass During Transfer')

figure('Name','Hamiltonian','NumberTitle','off')
plot(t_1,H1,'b','LineWidth',0.5)
hold on
plot(t_08,H08,'-.','Color','#FF57C7','LineWidth',0.5)
plot(t_06,H06,'--','LineWidth',0.5)
plot(t_04,H04,'--','Color','#0ee1b9','LineWidth',0.5)
plot(t_02,H02,'-.','LineWidth',0.5)
plot(t_0,H0,'r','LineWidth',0.5)
grid on
legend([char(949) '=1'],[char(949) '=0.8'],[char(949) '=0.6'],[char(949) '=0.4'],[char(949) '=0.2'],[char(949) '=0'],'Location','bestoutside')% or best outside
ylabel('Hamiltonian (CU/TU)'); xlabel('Time (Hours)'); title('Control Hamiltonian During Transfer')

figure('Name','Switching Function','NumberTitle','off')
plot(t_1,S1,'b','LineWidth',0.5)
hold on
plot(t_08,S08,'-.','Color','#FF57C7','LineWidth',0.5)
plot(t_06,S06,'--','LineWidth',0.5)
plot(t_04,S04,'--','Color','#0ee1b9','LineWidth',0.5)
plot(t_02,S02,'-.','LineWidth',0.5)
plot(t_0,S0,'r','LineWidth',0.5)
grid on
legend([char(949) '=1'],[char(949) '=0.8'],[char(949) '=0.6'],[char(949) '=0.4'],[char(949) '=0.2'],[char(949) '=0'],'Location','bestoutside')
ylabel('Switching Function'); xlabel('Time (Hours)'); title('Switching Function During Transfer')

%% Outputs
fprintf('Final Mass of Starlink (\x3B5 = 1): %f kg \n',X1(end,7)*pars.Unit.MU)
fprintf('Final Mass of Starlink (\x3B5 = 0.8): %f kg \n',X08(end,7)*pars.Unit.MU)
fprintf('Final Mass of Starlink (\x3B5 = 0.6): %f kg \n',X06(end,7)*pars.Unit.MU)
fprintf('Final Mass of Starlink (\x3B5 = 0.4): %f kg \n',X04(end,7)*pars.Unit.MU)
fprintf('Final Mass of Starlink (\x3B5 = 0.2): %f kg \n',X02(end,7)*pars.Unit.MU)
fprintf('Final Mass of Starlink (\x3B5 = 0): %f kg \n',X0(end,7)*pars.Unit.MU)
fprintf('\n')
fprintf('Mass of Fuel Used (\x3B5 = 1): %f kg \n',m1(end))
fprintf('Mass of Fuel Used (\x3B5 = 0.8): %f kg \n',m08(end))
fprintf('Mass of Fuel Used (\x3B5 = 0.6): %f kg \n',m06(end))
fprintf('Mass of Fuel Used (\x3B5 = 0.4): %f kg \n',m04(end))
fprintf('Mass of Fuel Used (\x3B5 = 0.2): %f kg \n',m02(end))
fprintf('Mass of Fuel Used (\x3B5 = 0): %f kg \n',m0(end))
fprintf('\n')
fprintf('Difference Between Energy & Fuel Optimal: %g kg \n',Md)
fprintf('\n')
fprintf('Money Saved on Transfer: $%g \n',Md*2720)
fprintf('\n')
fprintf('Total Money Saved on Launch: $%f \n',Md*2720*60)
