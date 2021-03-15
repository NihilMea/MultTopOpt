function fig = draw(mesh,TopOptsolution,mode,varargin)
i = 1;
selection = [];
while true
    switch varargin{i}
        case 'Name'
            name = varargin{i+1};
            i = i+1;
        case 'figure'
            fig = varargin{i+1};
            i = i+1;
        case 'Uy'
            U = varargin{i+1}; % FEMsolution.Ue
            U = sum(U(:,2:2:end),2)/4;
            i = i+1;
        case 'Ux'
            U = varargin{i+1}; % FEMsolution.Ue
            U = sum(U(:,1:2:end),2)/4;
            i = i+1;
        case 'Uxy'
            U = varargin{i+1}; % FEMsolution.Ue
            U = sqrt(sum(U(:,1:2:end),2).^2+sum(U(:,2:2:end),2).^2)/4;
            i = i+1;
        case 'notvoid'
            selection = mesh.elements(TopOptsolution.rho_n(:,3)>0.95);
    end
    i = i+1;
    if i == nargin-2
        break;
    end
end

face_color = zeros(length(mesh.elements),3);
edge_color = 'none';
linewidth = 0.01;
if ~exist('fig','var')
    fig = figure('Name', name,'NumberTitle','off','Position',[1025 300 500 300]);
    axes
end
colorbar(fig.CurrentAxes,'off');

color_scheam = [0 0 1; 0 1 0; 0 0 0; 1 0 0; 1 1 1];
switch mode
    case 'prep'
        face_color(mesh.elements,:) = repelem([0,1,0],length(mesh.elements),1);
        face_color(ismember(mesh.elements,mesh.passive_elements),:) = repelem([1,0,0],length(mesh.passive_elements),1);
        face_color(ismember(mesh.elements,mesh.fixed_elements),:) = repelem([1,1,0],length(mesh.fixed_elements),1);
    case 'topoptresult'
        color = color_scheam(end-TopOptsolution.p+1:end,:);
        face_color = min(max(TopOptsolution.rho_n*color(1:TopOptsolution.p,:),0),1);
    case 'displacement'
        color = colormap(jet);
        val = normalize(U,'range')*255;
        face_color = color(floor(val)+1,:);
        face_color(selection,:) = ones(numel(selection),3);
        edge_color = 'black';
        linewidth = 0.1;
end

    patch(fig.CurrentAxes,'Faces',mesh.element_has_nodes,'Vertices',mesh.node_coords,...
        'FaceVertexCData',face_color,'FaceColor','flat','LineWidth',linewidth,'EdgeColor',edge_color);

if strcmp(mode, 'displacement')
    colormap jet;
    colorbar(fig.CurrentAxes,'Ticks',linspace(min(U),max(U),12));
    caxis([min(U) max(U)]);
end
axis equal;
axis off;
end