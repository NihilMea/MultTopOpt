function [func,df_dphi] = eval_func_grad_compl(mesh,FEMsolution,TopOptsolution)

uKu = sum((FEMsolution.Ue(mesh.active_elements,:)*mesh.Ke*TopOptsolution.h).*FEMsolution.Ue(mesh.active_elements,:),2);
func = sum(TopOptsolution.E(mesh.active_elements).*uKu);

df_drhon = -TopOptsolution.q*TopOptsolution.rho_n(mesh.active_elements,:).^(TopOptsolution.q-1).*TopOptsolution.E0'.*uKu;
drhon_drho = (sum(TopOptsolution.rho,2)-TopOptsolution.rho)./(sum(TopOptsolution.rho,2).^2);
drho_dmu = TopOptsolution.beta*exp(-TopOptsolution.mu*TopOptsolution.beta)+exp(-TopOptsolution.beta);
df_dmu = df_drhon.*drhon_drho.*drho_dmu;

df_dphi = zeros(numel(mesh.nodes_in_neighborhoods),TopOptsolution.p);
for i = 1:numel(mesh.nodes_in_neighborhoods)
    [~,ind] = ismember(mesh.nodes_in_neighborhoods{i},mesh.active_elements);
    df_dphi(i,:) = sum(df_dmu(ind,:).*(mesh.nodes_weight{i}./mesh.sum_weight(ind)),1);
end



end