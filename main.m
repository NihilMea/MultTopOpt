close all hidden
addpath('./FEM');
addpath('./optimizer');

init; % Иннициализация переменныйх

mesh = generateMesh(size_x,size_y,passive_elem_bot_left_corner,...
    passive_elem_top_right_corner,fixed_elem_bot_left_corner,fixed_elem_top_right_corner,...
    element_size_x,element_size_y,rmin); % Создание сетки
mesh = prepare_for_FEM(mesh,forces,fixed_DOFs);
% fig = draw(mesh,'prep');
TopOptsolution = createTopOpt(mesh,E0,v,p,q,beta,h,rmin);
optimizer_init;
% первая итерация
FEMsolution = solveFEM(TopOptsolution, mesh);
[f0val,df0dx,fval,dfdx] = formulateOptimizationProblem(mesh,FEMsolution,TopOptsolution,m,n);
% Cтрока состояния
fig = draw(mesh,TopOptsolution,'prep','Name','TopOpt');
bar = waitbar(0,sprintf("Current iteration: %f",0));
% НАЧАЛО ЦИКЛА ОПТИМИЗАЦИИ
while kktnorm > kkttol && outit < maxit
    % КОНЕЧНО-ЭЛЕМЕНТНЫЙ АНАЛИЗ
    outit   = outit+1;
    outeriter = outeriter+1;
    
    [xmma,ymma,zmma,lam,xsi,eta,mu,zet,s,low,upp] = ...
        mmasub(m,n,outeriter,xval,xmin,xmax,xold1,xold2, ...
        f0val,df0dx,fval,dfdx,low,upp,a0,a,c,d);
    
    xold2 = xold1;
    xold1 = xval;
    xval  = xmma;
    
    TopOptsolution = TopOptSol_update(mesh,TopOptsolution,xval,beta,dbeta,beta_max,outeriter);
    
    FEMsolution = solveFEM(TopOptsolution, mesh);
    [f0val,df0dx,fval,dfdx] = formulateOptimizationProblem(mesh,FEMsolution,TopOptsolution,m,n);
    
    [residu,kktnorm,residumax] = kktcheck(m,n,xmma,ymma,zmma,lam,xsi,eta,mu,zet,s, ...
        xmin,xmax,df0dx,fval,dfdx,a0,a,c,d);
    draw(mesh,TopOptsolution,'topoptresult','figure',fig);
    % Cтрока состояния
    waitbar(outit/maxit,bar,sprintf("Current iteration: %i",outit));
end
% draw(mesh,TopOptsolution,'displacement','figure',fig,'Uy',FEMsolution.Ue,'notvoid');


%path = sprintf('C:/Users/ilun9/Desktop/kurs/results/%s/',name); %путь сохранения изображения результата
%saveas(fig,[path,'figure.png']);

%saveANSYS(nelx,nely,F,fixeddofs,x,elem_node_mat,node_coords,E0,h,name)


