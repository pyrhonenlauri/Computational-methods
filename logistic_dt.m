%% Exercise 4.4
close all
clear all
r=0.1;                        %Slope at start relative to U0
f = @(u, t) r*(1 - u/500)*u;  %Definition of logistic model
U_0 = 100;                    %Initial value of u
dt = 10;                      %Time step in the beginning
T = 60;                       %End of evaluation time period
[u_prev, t_prev] = ode_FE(f, U_0, dt, T);
dt=dt/2;                      %time step is halved
while 1
    [u, t] = ode_FE(f, U_0, dt, T);
    %%plot
    plot(t_prev, u_prev, 'b-');
    hold on
    plot(t,u,'r--')
    xlabel('t'); ylabel('N(t)');
    lgd=legend(['dt=' num2str(dt)],['dt=' num2str(2*dt)]);
    lgd.Location='northwest';
    %%user input
    str = input('If you want to calculate again, press y. If you want to quit, press q.','s');
    if str=='y'
        dt=dt/2; %time step is halved
        t_prev=t; %Current data converted as comparison data for next iteration
        u_prev=u;   %Current data converted as comparison data for next iteration
        close all
    else
        return
    end
end