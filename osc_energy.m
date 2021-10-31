function [E_k,E_p]=osc_energy(u, v, omega)
E_k=0.5*omega.^2*u.^2;
E_p=0.5*v.^2;
end