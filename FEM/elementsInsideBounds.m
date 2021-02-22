function logic_array = elementsInsideBounds(bottom_left_points,top_right_points,mesh)
logic_array = zeros(size(mesh.elements));
for i = 1:size(bottom_left_points,1)
   logic_array = logic_array + ismember(mesh.elements,mesh.elements((mesh.element_coords(:,1) > bottom_left_points(i,1) & mesh.element_coords(:,1) < top_right_points(i,1)) ...
        & (mesh.element_coords(:,2) > bottom_left_points(i,2) & mesh.element_coords(:,2) < top_right_points(i,2))));
end
logic_array = logical(logic_array);
end

