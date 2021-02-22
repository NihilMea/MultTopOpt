function FEMsolution=solveFEM(TopOptsolution,mesh)

ind = mesh.DOFs(reshape(mesh.element_has_nodes',numel(mesh.element_has_nodes),1),:)'; 
row_ind = repelem(ind(:),size(mesh.Ke,1));
col_ind = reshape(repmat(reshape(ind,size(mesh.Ke,1),numel(ind)/size(mesh.Ke,1)),size(mesh.Ke,1),1),numel(ind)*size(mesh.Ke,1),1);
sparseK = reshape(TopOptsolution.h*mesh.Ke(:).*TopOptsolution.E',numel(ind)*size(mesh.Ke,1),1);
K = sparse(row_ind,col_ind,sparseK,numel(mesh.DOFs),numel(mesh.DOFs));
K = (K+K')/2;
FEMsolution.sparseK = sparseK; 
FEMsolution.U = zeros(numel(mesh.DOFs),1);
FEMsolution.U(mesh.free_DOFs) = K(mesh.free_DOFs,mesh.free_DOFs)\mesh.F(mesh.free_DOFs);

FEMsolution.Ue = reshape(FEMsolution.U(ind(:)),8,numel(mesh.elements))';

FEMsolution.sigma = (mesh.DB*FEMsolution.Ue')'.*TopOptsolution.E;
FEMsolution.sigma_VM = [sqrt(FEMsolution.sigma(:,1).^2+FEMsolution.sigma(:,2).^2-FEMsolution.sigma(:,1).*FEMsolution.sigma(:,2)+3*FEMsolution.sigma(:,3).^2) ...
    sqrt(FEMsolution.sigma(:,4).^2+FEMsolution.sigma(:,5).^2-FEMsolution.sigma(:,4).*FEMsolution.sigma(:,5)+3*FEMsolution.sigma(:,6).^2) ...
    sqrt(FEMsolution.sigma(:,7).^2+FEMsolution.sigma(:,8).^2-FEMsolution.sigma(:,7).*FEMsolution.sigma(:,8)+3*FEMsolution.sigma(:,9).^2) ...
    sqrt(FEMsolution.sigma(:,10).^2+FEMsolution.sigma(:,11).^2-FEMsolution.sigma(:,10).*FEMsolution.sigma(:,11)+3*FEMsolution.sigma(:,12).^2)];


FEMsolution.sigma_e = [accumarray(mesh.element_has_nodes(:),reshape(FEMsolution.sigma(:,1:3:10),numel(mesh.elements)*4,1))...
    accumarray(mesh.element_has_nodes(:),reshape(FEMsolution.sigma(:,2:3:11),numel(mesh.elements)*4,1))...
    accumarray(mesh.element_has_nodes(:),reshape(FEMsolution.sigma(:,3:3:12),numel(mesh.elements)*4,1))]./accumarray(mesh.element_has_nodes(:),1);
FEMsolution.sigma_e_VM = sqrt(FEMsolution.sigma_e(:,1).^2+FEMsolution.sigma_e(:,2).^2-FEMsolution.sigma_e(:,1).*FEMsolution.sigma_e(:,2)+3*FEMsolution.sigma_e(:,3).^2);
end