function mbs = add_translational(mbs, name, body1_name, s1O, body2_name, s2P, s2Q, c)
%  ADD_TRANSLATIONAL Function that adds translational joints.
% 
% Translational joint definition: name, body names, point O in body 1 that slides through the point P in body 2
% while vector QP is perpendicular to the sliding direction,
% c is the fixed angle between the body coordinate systems.
p = inputParser;
is_2vec = @(x) isvector(x) && length(x) == 2;
is_scalar = @(x) isscalar(x);
addRequired(p,'name', @isstring);
addRequired(p, 'body1_name', @isstring);
addRequired(p, 's1O', is_2vec);
addRequired(p, 'body2_name', @isstring);
addRequired(p, 's2P', is_2vec);
addRequired(p, 's2Q', is_2vec);
addRequired(p, 'c',is_scalar);
parse(p, name, body1_name, s1O, body2_name, s2P, s2Q,c);
% Get bodies ids
b1 = get_body_id(mbs, body1_name);
b2 = get_body_id(mbs, body2_name);
trans = struct("name", name, "body1", b1, "s1O", s1O(:), "body2", b2, "s2P", s2P(:),"s2Q",s2Q(:),"c",c);
mbs.joints.translational = [mbs.joints.translational, trans];
mbs.nc = mbs.nc + 2;
end

