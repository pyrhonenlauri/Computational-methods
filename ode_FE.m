function [sol, time] = ode_FE(f, Y_0, dt, T)
%% Initialization
    N_t = floor(T/dt);
    y = zeros(length(Y_0),N_t+1);
    t = linspace(0, N_t*dt, length(y(1,:)));
    y(:,1) = Y_0;
%% Forward Euler integration
    for n = 1:N_t   
        y(:,n+1) = y(:,n) + dt*f(y(:,n), t(n));
    end
%% Solution
    sol = y;
    time = t;
end