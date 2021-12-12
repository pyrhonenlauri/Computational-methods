function F = forces(mbs, q, dq)

F = zeros(mbs.nq, 1);
% forces due to gravity
if ~isempty(mbs.gravity)
    q_idx = 0;
    for b = mbs.bodies
       F(q_idx + (1:2)) = b.m .* mbs.gravity;
       q_idx = q_idx + 3;
    end
end

if ~isempty(mbs.K)
    F_spring=mbs.K*q+mbs.F_spring_c;
    F=F+F_spring;
end

if ~isempty(mbs.C)
    F_damp=mbs.C*dq;
    F=F+F_damp;
end
