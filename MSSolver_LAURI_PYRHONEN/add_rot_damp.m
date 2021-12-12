function mbs = add_rot_damp(mbs, joint_name, c)
if isempty(mbs.C)
    mbs.C=zeros(mbs.nq);
end
joint_id=get_joint_id(mbs.joints.revolute,joint_name);
b1_ind=mbs.joints.revolute(joint_id).body1;
b2_ind=mbs.joints.revolute(joint_id).body2;
theta1_ind=b1_ind*3;
theta2_ind=b2_ind*3;
mbs.C(theta1_ind,theta1_ind)=mbs.C(theta1_ind,theta1_ind)-c;
mbs.C(theta1_ind,theta2_ind)=mbs.C(theta1_ind,theta2_ind)+c;
mbs.C(theta2_ind,theta1_ind)=mbs.C(theta2_ind,theta1_ind)+c;
mbs.C(theta2_ind,theta2_ind)=mbs.C(theta2_ind,theta2_ind)-c;
end