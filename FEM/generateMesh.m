function mesh = generateMesh(size_x,size_y,passive_bottom_left_points,...
    passive_top_right_points,fixed_bottom_left_points,fixed_top_right_points,element_size_x,element_size_y,rmin)
mesh.element_size_x = element_size_x;
mesh.element_size_y = element_size_y;
mesh.num_elements_x = floor(size_x/element_size_x);
mesh.num_elements_y = floor(size_y/element_size_y);
mesh.nodes = 1:(mesh.num_elements_x+1)*(mesh.num_elements_y+1);
mesh.node_coords = [element_size_x*floor((mesh.nodes-1)/(mesh.num_elements_y+1)); element_size_y*mod((mesh.nodes-1),(mesh.num_elements_y+1))]';
mesh.elements = 1:mesh.num_elements_x*mesh.num_elements_y;

mesh.element_has_nodes = [mesh.elements + floor((mesh.elements-1)/mesh.num_elements_y)
                mesh.elements + floor((mesh.elements-1)/mesh.num_elements_y) + (mesh.num_elements_y+1) 
                mesh.elements + floor((mesh.elements-1)/mesh.num_elements_y) + (mesh.num_elements_y+1) + 1
                mesh.elements + floor((mesh.elements-1)/mesh.num_elements_y) + 1]';
                    
mesh.element_coords = [mesh.node_coords(mesh.element_has_nodes(:,1),1)+element_size_x/2, mesh.node_coords(mesh.element_has_nodes(:,1),2)+element_size_y/2];

passive = elementsInsideBounds(passive_bottom_left_points,passive_top_right_points,mesh);
mesh.passive_elements = mesh.elements(passive);

fixed = elementsInsideBounds(fixed_bottom_left_points,fixed_top_right_points,mesh);
mesh.fixed_elements = mesh.elements(fixed);

mesh.active_elements = setdiff(mesh.elements,mesh.fixed_elements);
mesh.active_elements = setdiff(mesh.active_elements,mesh.passive_elements);

mesh.active_nodes = unique(mesh.element_has_nodes(mesh.active_elements,:));
[mesh.neighborhoods,mesh.weight,mesh.sum_weight,mesh.nodes_in_neighborhoods,mesh.nodes_weight] = nodesInsideCircle(mesh.element_coords(mesh.active_elements,:),rmin,mesh);


mesh.DOFs = [2*mesh.nodes-1;2*mesh.nodes]'; 

end