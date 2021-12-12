function mbs = add_rot_spring(mbs, joint_name, theta0, k)
if isempty(mbs.K)
    mbs.K=zeros(mbs.nq);
    mbs.F_spring_c=zeros(mbs.nq,1);
end
%Definition of offset: In equilibrium (without ANY forces): theta2=theta1+theta0
joint_id=get_joint_id(mbs.joints.revolute,joint_name);
b1_ind=mbs.joints.revolute(joint_id).body1;
b2_ind=mbs.joints.revolute(joint_id).body2;
theta1_ind=b1_ind*3;
theta2_ind=b2_ind*3;
mbs.K(theta1_ind,theta1_ind)=mbs.K(theta1_ind,theta1_ind)-k;
mbs.K(theta1_ind,theta2_ind)=mbs.K(theta1_ind,theta2_ind)+k;
mbs.K(theta2_ind,theta1_ind)=mbs.K(theta2_ind,theta1_ind)+k;
mbs.K(theta2_ind,theta2_ind)=mbs.K(theta2_ind,theta2_ind)-k;
mbs.F_spring_c(theta1_ind)=mbs.F_spring_c(theta1_ind)-k*theta0;
mbs.F_spring_c(theta2_ind)=mbs.F_spring_c(theta2_ind)+k*theta0;
end