%% Exercise 4.4
close all
clear all
f = @(u, t) 0.1*(1 - u/500)*u;
U_0 = 100;
dt = 10;
T = 60;
[u_prev, t_prev] = ode_FE(f, U_0, dt, T);
dt=dt/2;
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
        dt=dt/2;
        t_prev=t;
        u_prev=u;
        close all
    else
        return
    end
end