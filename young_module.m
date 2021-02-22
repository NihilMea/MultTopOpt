function [e] = young_module(TopOptsolution,parameters)
e = (TopOptsolution.x.^3)*parameters.E0;
end