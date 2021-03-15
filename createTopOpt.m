function TopOptsolution = createTopOpt(mesh,E0,v,p,q,beta,h,rmin)
TopOptsolution.phi = ones(numel(mesh.active_nodes),p).*v';
[TopOptsolution.rho,TopOptsolution.mu] = project(TopOptsolution.phi,mesh,beta);
TopOptsolution.rho_n = ones(numel(mesh.elements),p);
TopOptsolution.rho_n(mesh.active_elements,:) = TopOptsolution.rho./vecnorm(TopOptsolution.rho,1,2);
TopOptsolution.rho_n(mesh.passive_elements,:) = repmat([zeros(1,p-1),1],numel(mesh.passive_elements),1);
TopOptsolution.rho_n(mesh.fixed_elements,:) = repmat([1,zeros(1,p-1)],numel(mesh.fixed_elements),1);
TopOptsolution.E0 = E0;
TopOptsolution.h = h;
TopOptsolution.rmin = rmin;
TopOptsolution.p = p;
TopOptsolution.q = q;
TopOptsolution.v = v;
TopOptsolution.beta = beta;
% TopOptsolution.epsilon = epsilon;
TopOptsolution.E = young_module(TopOptsolution);

end

