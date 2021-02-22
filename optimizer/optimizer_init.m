% Параметры оптимизатора
maxit = 15;

% 
% Вариант с граничными условиями на равенство 1 суммы переменных 
% соответствующих элементу. Вариант "ломающий" MATLAB
% m = numel(mesh.active_elements)*2 + TopOptsolution.p-1;   % The number of general constraints
%
m = TopOptsolution.p-1;   % The number of general constraints

n = numel(mesh.active_elements)*(TopOptsolution.p-1);       %The number of variables x_j
epsimin = 1e-7;
xval = TopOptsolution.x(mesh.active_elements,1:TopOptsolution.p-1);
xval = xval(:);
xold1 = xval;
xold2 = xval;
xmin = zeros(n,1);
xmax = ones(n,1);
low = xmin;
upp = xmax;
c = ones(m,1)*1e5;
d = ones(m,1);
a0 = 1;
a = zeros(m,1);
outeriter = 0;
maxoutit  = 1;
kkttol  = 0;

kktnorm = kkttol+10;
outit = 0;
