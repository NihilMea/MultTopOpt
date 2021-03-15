function [e] = young_module(TopOptsolution)
e = (TopOptsolution.rho_n.^TopOptsolution.q)*TopOptsolution.E0;
end