function FEMsolution=solveFEM(TopOptsolution,mesh)

ind = mesh.DOFs(reshape(mesh.element_has_nodes',numel(mesh.element_has_nodes),1),:)'; 
row_ind = repelem(ind(:),size(mesh.Ke,1));
col_ind = reshape(repmat(reshape(ind,size(mesh.Ke,1),numel(ind)/size(mesh.Ke,1)),size(mesh.Ke,1),1),numel(ind)*size(mesh.Ke,1),1);
sparseK = reshape(mesh.Ke(:).*TopOptsolution.E',numel(ind)*size(mesh.Ke,1),1);
K = sparse(row_ind,col_ind,sparseK,numel(mesh.DOFs),numel(mesh.DOFs));
K = (K+K')/2;
FEMsolution.sparseK = sparseK; 
FEMsolution.U = zeros(numel(mesh.DOFs),1);
FEMsolution.U(mesh.free_DOFs) = K(mesh.free_DOFs,mesh.free_DOFs)\mesh.F(mesh.free_DOFs);
% FEMsolution.Ue = FEMsolution.U(ind(:));
FEMsolution.Ue = reshape(FEMsolution.U(ind(:)),8,numel(ind)/8)';

end