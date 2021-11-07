clear all
close all
dt=0.001;
T_end=10;
t=0:dt:T_end;
omega=5;
N_t=length(t)-1;
u = zeros(N_t+1,1);
v = zeros(N_t+1,1);
% Initial condition
u(1) = 2;
v(1) = 0;
U_0=[u(1),v(1)];
% Step equations forward in time
f=@(X,t) [X(2); -omega^2*X(1)];
[Y,t]=ode_FE(f, U_0, dt, T_end);
u=Y(1,:);
v=Y(2,:);

figure
plot(t,u)
hold on
plot(t,v)
legend('u','v')
title('Forward Euler')

[E_k,E_p]=osc_energy(u, v, omega);
E_bal=E_k+E_p;

figure
plot(t,E_bal);
title('Energy balance')