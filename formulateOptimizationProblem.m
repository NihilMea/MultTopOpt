function [f0val,df0dx,fval,dfdx] = formulateOptimizationProblem(mesh,FEMsolution,TopOptsolution,m,n)

% РАСЧЕТ ЦЕЛЕВОЙ ФУНКЦИИ И ЕЁ ЧУСТВИТЕЛЬНОСТИ

% [fc,gc] = eval_func_grad_compl(mesh,FEMsolution,TopOptsolution);

uKu = sum((FEMsolution.Ue(mesh.active_elements,:)*mesh.Ke*TopOptsolution.h).*FEMsolution.Ue(mesh.active_elements,:),2);
f0val = sum(TopOptsolution.E(mesh.active_elements).*uKu);

df_drhon = -TopOptsolution.q*TopOptsolution.rho_n(mesh.active_elements,:).^(TopOptsolution.q-1).*TopOptsolution.E0'.*uKu;
drhon_drho = (sum(TopOptsolution.rho,2)-TopOptsolution.rho)./(sum(TopOptsolution.rho,2).^2);
drho_dmu = TopOptsolution.beta*exp(-TopOptsolution.mu*TopOptsolution.beta)+exp(-TopOptsolution.beta);
drhon_dmu = drhon_drho.*drho_dmu;
df_dmu = df_drhon.*drhon_dmu;

df0dx = zeros(numel(mesh.nodes_in_neighborhoods),TopOptsolution.p);
for i = 1:numel(mesh.nodes_in_neighborhoods)
    [~,ind] = ismember(mesh.nodes_in_neighborhoods{i},mesh.active_elements);
    df0dx(i,:) = sum(df_dmu(ind,:).*(mesh.nodes_weight{i}./mesh.sum_weight(ind)),1);
end
df0dx = df0dx(:);

% Ограничения
fval = sum(TopOptsolution.rho_n(mesh.active_elements,:),1)'-TopOptsolution.v.*numel(mesh.active_elements);

dfdx = zeros(m,numel(mesh.nodes_in_neighborhoods));
for i = 1:numel(mesh.nodes_in_neighborhoods)
    [~,ind] = ismember(mesh.nodes_in_neighborhoods{i},mesh.active_elements);
    dfdx(:,i) = sum(drhon_dmu(ind,:).*(mesh.nodes_weight{i}./mesh.sum_weight(ind)),1)';
end
dfdx = repelem(eye(m),1,numel(mesh.nodes_in_neighborhoods)).*repmat(dfdx,1,m);

end