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
% Step equations forward in time
for n = 1:N_t
    v(n+1) = v(n) - dt*omega^2*u(n);
    u(n+1) = u(n) + dt*v(n+1);
end
figure
plot(t,u)
hold on
plot(t,v)
legend('u','v')
title('Euler-Cromer')

[E_k,E_p]=osc_energy(u, v, omega);
E_bal=E_k+E_p;

figure
plot(t,E_bal);
title('Energy balance')