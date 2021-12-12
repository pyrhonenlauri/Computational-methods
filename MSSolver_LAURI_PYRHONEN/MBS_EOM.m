function dydt = MBS_EOM(t,y,mbs,alpha,beta)
%MBS_EOM Summary of this function goes here
%   Detailed explanation goes here
q=y(1:mbs.nq);
dq=y(mbs.nq+1:end);
g=calculate_g(mbs,q,dq,t);
Cq=constraints_dq(mbs,q);
C=constraints(mbs,q,t);
Ct=constraints_dt(mbs, t);
C_dot=Cq*dq+Ct;
g_hat=g-2*alpha*C_dot-beta^2*C;
F = forces(mbs, q, dq);
M = mass_matrix(mbs);
sys=[M, Cq';
    Cq, zeros(mbs.nc)];
ddq_lamda=sys\[F;g_hat];
ddq=ddq_lamda(1:mbs.nq);
dydt=[dq;ddq];
end

