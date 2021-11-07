%% osc_BE
clear all
close all
%% User input
w=2; %omega
num_of_periods=5;
steps_per_period=2000;
u0=1;
v0=2;

%% Preprocess and simulation
P=2*pi/w;   %length of one period in time
t_span=[0 P*num_of_periods];    %simulation time
t_step=P/steps_per_period;      %time increment
t=t_span(1):t_step:t_span(end); %time vector
u=zeros(1,length(t));           %initialization of u
v=zeros(1,length(t));           %initialization of v

u(1)=u0;                        
v(1)=v0;

for ind=2:length(t)     %evaluation of u and v over time vector t
    u(ind)=(t_step*v(ind-1)+u(ind-1))/(1+t_step^2*w^2);
    v(ind)=v(ind-1)-t_step*w^2*u(ind);
end

%% Values for 20
% A0=1.41;
% b=0.29;
% damp=A0*exp(-b*t);

%% Values for 2000
A0=1.41;
b=0.0029;
damp=A0*exp(-b*t);

%% Create plots
figure
plot(t,u)
hold on
plot(t,v)
plot(t,damp,'g--')
legend('u','v')
