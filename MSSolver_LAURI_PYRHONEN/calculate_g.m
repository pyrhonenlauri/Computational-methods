function g = calculate_g(mbs,q,dq,t)
%CALCULATE_G Summary of this function goes here
%   Detailed explanation goes here
g = zeros(mbs.nc, 1);
c_idx = 0;

for rj = mbs.joints.revolute
    q1 = q(body_idx(rj.body1));
    q2 = q(body_idx(rj.body2));
    dq1 = dq(body_idx(rj.body1));
    dq2 = dq(body_idx(rj.body2));
    dphi1=dq1(3);
    dphi2=dq2(3);
    A1 = rot(q1(3));
    A2 = rot(q2(3));
    g(c_idx + (1:2)) = A1 * rj.s1 * dphi1^2 - A2 * rj.s2*dphi2^2;
    c_idx = c_idx + 2;
end

for sj = mbs.joints.simple
    g(c_idx + 1) = 0;
    c_idx = c_idx + 1;
end


for tj=mbs.joints.translational
    q1 = q(body_idx(rj.body1));
    q2 = q(body_idx(rj.body2));
    dq1 = dq(body_idx(rj.body1));
    dq2 = dq(body_idx(rj.body2));
    r1 = q1(1:2);
    r2 = q2(1:2);
%     phi1=q1(3);
%     phi2=q2(3);
    dr1 = dq1(1:2);
    dr2 = dq2(1:2);
    dphi1=dq1(3);
    dphi2=dq2(3);

    A1 = rot(q1(3));
    A2 = rot(q2(3));
    k_AB=r1+A1*tj.s1O-r2-A2*tj.s2P;
    h_B=A2*(tj.s2P-tj.s2Q);
    dk_AB=dr1+Omega*A1*tj.s1O*dphi1-dr2-Omega*A2*tj.s2P*dphi2;
    dh_B=Omega*A2*(tj.s2P-tj.s2Q)*dphi2;
    % 'dash' terms without accelerations
    ddk_AB_dash=-A1*tj.s1O*dphi1^2+A2*tj.s2P*dphi2^2;
    ddh_B_dash=-A2*(tj.s2P-tj.s2Q)*dphi2^2;
    g(c_idx+1)=-(ddh_B_dash'*k_AB+2*dh_B'*dk_AB+h_B'*ddk_AB_dash);
    g(c_idx+2)=0;
    c_idx = c_idx + 2;
end


for dj = mbs.joints.driving
    g(c_idx + 1) = dj.cfun_ddt(t);
    c_idx = c_idx + 1;
end
end

