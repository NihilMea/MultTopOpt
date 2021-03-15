% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%                                                               %
%             |<-------------size_x----------------->|          %
%        _____|______________________________________|          %
%        |    |                                      |          %
%   	 |    |                                      |          %
%        |    |                                      |          %
%  size_y|    |                                      |          %
%        |    |                                      |          %
%        |____|______________________________________|          %
%                                                               %
% ^y                                                            %
% |                                                             %
% |                                                             %
% |----->x                                                      %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% E0 = [2,1,1e-9]';
% v = [0.2,0.2,0.6]';
E0 = [1,1e-9]';
v = [0.5,0.5]';

% ЗАДАНИЕ ГЕОМЕТРИИ

% 
% size_x = 24; size_y = 12; % размеры области проектирования мм
% passive_elem_bot_left_corner = [22,0];
% passive_elem_top_right_corner = [24,2];
% fixed_elem_bot_left_corner = [0, 11; 
%                            23, 2];
% fixed_elem_top_right_corner = [1, 12;
%                                 24, 3];
% element_size_x = 1; % длинна элемента мм
% element_size_y = 1; % высота элемента мм
% h = 1; % толщина элемента мм
% forces = [0,size_y,0,-1]; % координаты и значение прикладываемой силы [x,y,fx,fy]
% fixed_DOFs = [zeros(floor(size_y/element_size_y)+1,1),(element_size_y*(0:floor(size_y/element_size_y)))',ones(floor(size_y/element_size_y)+1,1)
%     size_x,2,2];  

% size_x = 48; size_y = 24; % размеры области проектирования мм
% passive_elem_bot_left_corner = [44,0];
% passive_elem_top_right_corner = [48,4];
% fixed_elem_bot_left_corner = [0, 22; 
%                            46, 4];
% fixed_elem_top_right_corner = [2, 24;
%                                 48, 6];
% element_size_x = 1; % длинна элемента мм
% element_size_y = 1; % высота элемента мм
% h = 1; % толщина элемента мм
% forces = [0,size_y,0,-1]; % координаты и значение прикладываемой силы [x,y,fx,fy]
% fixed_DOFs = [zeros(floor(size_y/element_size_y)+1,1),(element_size_y*(0:floor(size_y/element_size_y)))',ones(floor(size_y/element_size_y)+1,1)
%     size_x,4,2];  

size_x = 24; size_y = 12; % размеры области проектирования мм
passive_elem_bot_left_corner = [];
passive_elem_top_right_corner = [];
fixed_elem_bot_left_corner = [];
fixed_elem_top_right_corner = [];
element_size_x = 1; % длинна элемента мм
element_size_y = 1; % высота элемента мм
h = 1; % толщина элемента мм
forces = [0,size_y,0,-1]; % координаты и значение прикладываемой силы [x,y,fx,fy]
fixed_DOFs = [zeros(floor(size_y/element_size_y)+1,1),(element_size_y*(0:floor(size_y/element_size_y)))',ones(floor(size_y/element_size_y)+1,1)
    size_x,0,2];

% size_x = 480; size_y = 120; % размеры области проектирования мм
% passive_elem_bot_left_corner = [440,0];
% passive_elem_top_right_corner = [480,40];
% fixed_elem_bot_left_corner = [0,110; 474,40];
% fixed_elem_top_right_corner = [6,120; 480,46];
% 
% element_size_x = 2; % длинна элемента мм
% element_size_y = 2; % высота элемента мм
% h = 10; % толщина элемента мм
% forces = [0,size_y,0,-1000]; % координаты и значение прикладываемой силы [x,y,fx,fy]
% fixed_DOFs = [zeros(floor(size_y/element_size_y)+1,1),(element_size_y*(0:floor(size_y/element_size_y)))',ones(floor(size_y/element_size_y)+1,1)
%     480,40,2];

p = size(E0,1); % количество материалов
q = 5; % штрафная степень
beta = 0; % параметр функции хевисайда
dbeta = 1.1;
beta_max = 50;
rmin = 2; % минимальная ширина конструктивных элементов /2



