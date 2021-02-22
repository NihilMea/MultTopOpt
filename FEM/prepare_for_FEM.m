% подготовка матрицы Ke
function mesh = prepare_for_FEM(mesh,forces,fixed_DOFs)

mesh = createKe(mesh);

[~,force_DOF] = find(forces(:,3:4));
forces_DOFs = mesh.DOFs(nodesNearPoint(mesh,forces(:,1:2)),force_DOF);
forces_DOFs = diag(forces_DOFs);
forces = forces(:,3:4)';
mesh.F = sparse(forces_DOFs,1,forces(forces~=0),numel(mesh.DOFs),1);


mesh.fixed_DOFs = mesh.DOFs(nodesNearPoint(mesh,fixed_DOFs(:,1:2)),fixed_DOFs(:,3));
mesh.fixed_DOFs = diag(mesh.fixed_DOFs);
mesh.free_DOFs  = setdiff(reshape(mesh.DOFs',numel(mesh.DOFs),1),mesh.fixed_DOFs);

end
