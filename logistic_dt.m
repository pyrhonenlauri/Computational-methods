%% Exercise 4.4
f = @(u, t) 0.1*(1 - u/500)*u;
U_0 = 100;
dt = 0.5; T = 60;
[u, t] = ode_FE(f, U_0, dt, T);
plot(t, u, 'b-');
xlabel('t'); ylabel('N(t)');