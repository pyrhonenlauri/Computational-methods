
%% SYMBOLIC CALCULATIONS 

% syms a b d phi theta omega dtheta dd
% C=[a*cos(phi)+b*cos(theta)-d;
%     a*sin(phi)-b*sin(theta)];
% Cx=[-b*sin(theta),-1;
%     -b*cos(theta),0];
% Ct=[-a*sin(phi)*omega;
%     a*cos(phi)*omega];
% dC=Cq*[dtheta; dd]+Ct
% dC=[- a*dtheta*sin(phi) - b*dd*sin(theta) - a*omega*sin(phi);
%   a*omega*cos(phi) + a*dtheta*cos(phi) - b*dd*cos(theta)];

%% START OF ACTUAL CODE
%% SIMULATION PARAMETERS
t=linspace(0,1,101);
max_iter=10;
tol=[1;1]*1e-8;

%% SYSTEM PARAMETERS
a=0.1;
b=0.2;
omega=1;
%% SIMULATION
x_init=[pi/6;1]; %initial condition
x=zeros(2,length(t));   %initialization of x
dx=x;                   %initialization of dx
for ind=1:length(t)     %loop over time
    phi=pi/6+omega*t(ind);
    C=[a*cos(phi)+b*cos(x_init(1))-x_init(2); %constraint eq for new phi
       a*sin(phi)-b*sin(x_init(1))];
    Cx=[-b*sin(x_init(1)),-1;       %jacobian for new phi
        -b*cos(x_init(1)),0];
    iter=0;
    x(:,ind)=x_init;
    while iter<max_iter && sum(tol<abs(C))>0    %newton-rhapson iteration
        x(:,ind)=x(:,ind)-Cx\C; %newton-rhapson update
            C=[a*cos(phi)+b*cos(x(1,ind))-x(2,ind); %update C for new x
               a*sin(phi)-b*sin(x(1,ind))];
            Cx=[-b*sin(x(1,ind)),-1; %update Cx for new x
                -b*cos(x(1,ind)),0];
        iter=iter+1;
    end
    x_init=x(:,ind);
    Ct=[-a*sin(phi)*omega;
         a*cos(phi)*omega];
    dx(:,ind)=Cx^-1*(-Ct); %solve velocities
end

close all

figure
yyaxis left
plot(t,x(1,:),'-b')
ylabel('rad')
hold on
yyaxis right
plot(t,x(2,:),'--r')
ylabel('m')
legend('theta','d')
xlabel('t [s]')

figure
yyaxis left
plot(t,dx(1,:),'-b')
ylabel('rad/s')
hold on
yyaxis right
plot(t,dx(2,:),'--r')
ylabel('m/s')
legend('d(theta)/dt','d(d)/dt')
xlabel('t [s]')