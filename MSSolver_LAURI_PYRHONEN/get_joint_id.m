function [joint_id] = get_joint_id(mbs_joint_struct,joint_name)
%GET_JOINT_ID Summary of this function goes here
%   Detailed explanation goes here
joint_id = -1;
for ii = 1 : length(mbs_joint_struct)
   if strcmpi(mbs_joint_struct(ii).name, joint_name)
       joint_id = ii;
       break;
   end
end

assert(joint_id ~= -1, "Incorrect name of the joint in get_joint_id: '%s'", ...
    joint_name);

end


