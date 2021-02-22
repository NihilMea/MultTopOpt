function [TopOptsolution,parameters] = createTopOpt(mesh,E0,sigma_max,v,p,h,epsilon,zeta)
TopOptsolution.x = ones(numel(mesh.elements),p).*v';
TopOptsolution.x(mesh.passive_elements,:) = repmat([0,0,1],numel(mesh.passive_elements),1);
TopOptsolution.x(mesh.fixed_elements,:) = repmat([1,0,0],numel(mesh.fixed_elements),1);
parameters.E0 = E0;
parameters.sigma_max = sigma_max;
TopOptsolution.h = h;
TopOptsolution.p = p;
TopOptsolution.v = v;
TopOptsolution.epsilon = epsilon;
TopOptsolution.zeta = zeta;
TopOptsolution.E = young_module(TopOptsolution,parameters);

end

