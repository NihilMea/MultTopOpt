function Ke = createKe(mesh)
mu = 0.3;
a = mesh.element_size_x;
b = mesh.element_size_y;

D = 1/(1-mu^2)*[1, mu, 0;
    mu, 1, 0;
    0, 0, (1-mu)/2];
B = @(et,xi)[(et-1)/2/a, 0, (-et+1)/2/a, 0, (et+1)/2/a, 0, (-et-1)/2/a, 0;
    0, (xi-1)/2/b, 0, (-xi-1)/2/b, 0, (xi+1)/2/b, 0, (-xi+1)/2/b;
    (xi-1)/2/b, (et-1)/2/a, (-xi-1)/2/b, (-et+1)/2/a, (xi+1)/2/b, (et+1)/2/a,(-xi+1)/2/b, (-et-1)/2/a];

Ke = matrix_int2(@(xi,et) (B(xi,et)')*D*B(xi,et)*a*b/4,-1, 1, -1, 1);
end