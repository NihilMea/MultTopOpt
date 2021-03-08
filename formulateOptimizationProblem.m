function [f0val,df0dx,fval,dfdx] = formulateOptimizationProblem(mesh,FEMsolution,TopOptsolution)

% РАСЧЕТ ЦЕЛЕВОЙ ФУНКЦИИ И ЕЁ ЧУСТВИТЕЛЬНОСТИ

[fc,gc] = eval_func_grad_compl(mesh,FEMsolution,TopOptsolution);
[fp,gp] = eval_func_grad_perim(mesh,TopOptsolution);

f0val = TopOptsolution.zeta * fp + fc;

df0dx = TopOptsolution.zeta * gp + gc;
df0dx = df0dx(1:(numel(mesh.active_elements)*(TopOptsolution.p-1)))';

fval = [-sum(TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1),2)
    sum(TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1),2)-1
    sum(TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1),1)'-TopOptsolution.v(1:TopOptsolution.p-1).*numel(mesh.active_elements)];

dfdx = [-speye(numel(mesh.active_elements)),-speye(numel(mesh.active_elements));
    speye(numel(mesh.active_elements)),speye(numel(mesh.active_elements));
    kron(eye(TopOptsolution.p-1),ones(1,numel(mesh.active_elements)))];

end