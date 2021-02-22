function [f,g] = eval_func_grad_compl(mesh,FEMsolution,TopOptsolution)

ce = sum((FEMsolution.Ue(mesh.active_elements,:)*mesh.Ke*TopOptsolution.h).*FEMsolution.Ue(mesh.active_elements,:),2);
f = sum(TopOptsolution.E(mesh.active_elements).*ce);
g = (-1.5*TopOptsolution.x(mesh.active_elements,:).^(2)).*(ce*TopOptsolution.E0');
g = g - repmat(g(:,TopOptsolution.p),1,TopOptsolution.p);

end