function [X,Trajectory] = ValidationPlotter(Lambda,pars,epsi,ToF_h)

LambdaX = Lambda(1:7);
Lambda0 = Lambda(8);

mi = pars.Starlink.mi;
RVi = pars.Orbit.RVi;

ToF_E = ToF_h*3600;
ToF = ToF_E/pars.Unit.TU;

%% ODE
X_Int = [RVi;mi;LambdaX];
t_ODE = linspace(0,1,1001);

opt = odeset('RelTol',3e-12,'AbsTol',1e-14);
[t_Traj,X] = ode113(@(t,Xaug)DynamicEquations(t,Xaug,epsi,Lambda0,ToF,pars),t_ODE,X_Int,opt);

%% COE
COE = zeros(length(X),6);
for i = 1:length(X)
    [COE(i,:)] = RV2COE(X(i,:),pars);
end

%% SF,u,alpha and Hamiltonian
[SF,u,alpha,H] = EnergyHamiltonian(X,Lambda0,epsi,pars);

%% Assign Values
Trajectory.Time = t_Traj;
Trajectory.SF = SF;
Trajectory.u = u;
Trajectory.alpha = alpha;
Trajectory.H = H;
Trajectory.COE = COE;
Trajectory.ToF = ToF;
end