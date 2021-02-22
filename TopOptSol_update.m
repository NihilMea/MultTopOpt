function TopOptsolution = TopOptSol_update(mesh,TopOptsolution,xval)
TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1) = ...
reshape(xval,numel(mesh.active_elements),2);
TopOptsolution.x(mesh.active_elements,TopOptsolution.p) = 1-sum(TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1),2);
TopOptsolution.E = young_module(TopOptsolution);

end

