function [f0val,df0dx,fval,dfdx] = formulateOptimizationProblem(mesh,FEMsolution,TopOptsolution,parameters)

% РАСЧЕТ ЦЕЛЕВОЙ ФУНКЦИИ И ЕЁ ЧУСТВИТЕЛЬНОСТИ

[fc,gc] = eval_func_grad_compl(mesh,FEMsolution,TopOptsolution,parameters);
[fp,gp] = eval_func_grad_perim(mesh,TopOptsolution);

f0val = TopOptsolution.zeta * fp + fc;

df0dx = TopOptsolution.zeta * gp + gc;
df0dx = df0dx(1:(numel(mesh.active_elements)*(TopOptsolution.p-1)))';


nc = 100;
[fval,dfdx] = constraints_grad(mesh,FEMsolution,TopOptsolution,parameters);


%
% Вариант с граничными условиями на равенство 1 суммы переменных 
% соответствующих элементу. Вариант "ломающий" MATLAB
% fval = [-sum(TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1),2)
%     sum(TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1),2)-1
%     sum(TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1),1)'-TopOptsolution.v(1:TopOptsolution.p-1).*numel(mesh.active_elements)];
% 
% 
% dfdx = [kron([-1,-1;1,1],speye(numel(mesh.active_elements)))
%     kron(eye(TopOptsolution.p-1),ones(1,numel(mesh.active_elements)))];


end