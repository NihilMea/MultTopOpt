function [fval,dfdx] = constraints_grad(mesh,FEMsolution,TopOptsolution,parameters)
fval = sum(TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1),1)'...
    -TopOptsolution.v(1:TopOptsolution.p-1).*numel(mesh.active_elements); % volume constraints



% [sigma_sorted,ind] = sort(FEMsolution.sigma_e_VM(mesh.active_elements), 'descend');
sigma_act_elements = FEMsolution.sigma_e_VM(mesh.active_elements);
num = 10; % number of clusters
idx = kmeans(sigma_act_elements,num);

cluster_sizes = accumarray(idx,1);
sigma_max = sigma_max_interpolation(TopOptsolution.x(mesh.active_elements,:),parameters);
fval = [fval; (accumarray(idx,(sigma_act_elements-sigma_max).^8)./cluster_sizes).^(1/8)];
fval = [fval; (accumarray(idx,(sum(TopOptsolution.x(mesh.active_elements,:),2)-(1+1e-9)).^8)./cluster_sizes).^(1/8);
    (accumarray(idx,(-sum(TopOptsolution.x(mesh.active_elements,:),2)+1-1e-9).^8)./cluster_sizes).^(1/8)];



dfdx = kron(eye(TopOptsolution.p-1),ones(1,numel(mesh.active_elements))); % volume constraints gradient


end