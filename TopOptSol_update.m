function TopOptsolution = TopOptSol_update(mesh,TopOptsolution,xval,beta,dbeta,beta_max,iter)
TopOptsolution.beta = min(TopOptsolution.beta + dbeta^iter,beta_max);
TopOptsolution.phi = reshape(xval,numel(mesh.active_nodes),TopOptsolution.p);
[TopOptsolution.rho,TopOptsolution.mu] = project(TopOptsolution.phi,mesh,beta);
TopOptsolution.rho_n(mesh.active_elements,:) = TopOptsolution.rho./vecnorm(TopOptsolution.rho,1,2);
TopOptsolution.E = young_module(TopOptsolution);

end

