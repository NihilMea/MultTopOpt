function [e] = young_module(TopOptsolution)
e = (TopOptsolution.x.^3)*TopOptsolution.E0;
end