function [f,g] = eval_func_grad_perim(mesh,TopOptsolution)
i = 2:mesh.num_elements_y+1; j = 2:mesh.num_elements_x+1; im = i-1; ip = i+1; jm = j-1; jp =j+1;
v = zeros(mesh.num_elements_y+2,mesh.num_elements_x+2,TopOptsolution.p-1);
v(i,j,:) = reshape(TopOptsolution.x(:,1:TopOptsolution.p-1),mesh.num_elements_y,mesh.num_elements_x,TopOptsolution.p-1);
v(1,:,:) = v(2,:,:); v(mesh.num_elements_y+2,:,:) = v(mesh.num_elements_y+1,:,:);
v(:,1,:) = v(:,2,:); v(:,mesh.num_elements_x+2,:) = v(:,mesh.num_elements_x+1,:);
f1 = (v(ip,j,:)-v(im,j,:)).^2 + (v(i,jp,:)-v(i,jm,:)).^2;
f2 = (TopOptsolution.x.^2).*(TopOptsolution.x - 1).^2;
f = (TopOptsolution.epsilon/8)*sum(f1(:))+(1./TopOptsolution.epsilon)*sum(f2(:));
g = (4*TopOptsolution.x(mesh.active_elements,:).^3 - 6*TopOptsolution.x(mesh.active_elements,:).^2 +...
    2*TopOptsolution.x(mesh.active_elements,:))/TopOptsolution.epsilon;
g(:,TopOptsolution.p) = 0;
end

