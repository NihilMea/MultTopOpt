function nodes_numbers = nodesNearPoint(mesh,x_y)

delta = 0.05;
nodes_numbers = zeros(size(x_y,1),1);
for i = 1:size(x_y,1)
    posible_node = find(mesh.node_coords(:,1)<x_y(i,1)+delta & mesh.node_coords(:,1)>x_y(i,1)-delta);
    nodes_numbers(i) = posible_node(mesh.node_coords(posible_node,2)<=x_y(i,2)+delta ...
        & mesh.node_coords(posible_node,2)>=x_y(i,2)-delta);
end

end