% интегрирование
function int_sum = matrix_int2(int_func,x0,x1,y0,y1)
% int_func = @(x,y) func(x,y)
detJ = (x1-x0)*(y1-y0)/4;
x = @(xi) (x1-x0)*(xi+1)/2+x0;
y = @(et) (y1-y0)*(et+1)/2+y0;
val = 1/sqrt(3);
int_sum = (int_func(x(-val),y(-val)) + int_func(x(-val),y(val))...
    + int_func(x(val),y(-val)) + int_func(x(val),y(val)))*detJ;
end