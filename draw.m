function fig = draw(mesh,mode,varargin)
    fig = figure('Name', 'Mesh');
    face_color = zeros(length(mesh.elements),3);
    edge_color = 'none';
    
    

    switch mode
        case 'prep'
            face_color(mesh.elements,:) = repelem([0,1,0],length(mesh.elements),1);
            face_color(ismember(mesh.elements,mesh.passive_elements),:) = repelem([1,0,0],length(mesh.passive_elements),1);
            face_color(ismember(mesh.elements,mesh.fixed_elements),:) = repelem([1,1,0],length(mesh.fixed_elements),1);
        case 'topoptresult'
            color = [0 0 0; 1 0 0; 1 1 1];
            face_color = min(max(varargin{1}.x*color(1:varargin{1}.p,:),0),1);
    end
    patch('Faces',mesh.element_has_nodes,'Vertices',mesh.node_coords,...
        'FaceVertexCData',face_color,'FaceColor','flat','LineWidth',0.01,'EdgeColor',edge_color);
    axis equal;
    axis off;
end