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

E0 = [2,1,1e-9]';
v = [0.2,0.2,0.6]';

% ЗАДАНИЕ ГЕОМЕТРИИ


size_x = 36; size_y = 18; % размеры области проектирования мм
% passive_elem_bot_left_corner = [35,0];
% passive_elem_top_right_corner = [50,4];
% fixed_elem_bot_left_corner = [0,13.5; 39.5,4];
% fixed_elem_top_right_corner = [0.5,16; 40,3.5];
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
% element_size_x = 8; % длинна элемента мм
% element_size_y = 8; % высота элемента мм
% h = 10; % толщина элемента мм
% forces = [0,size_y,0,-1000]; % координаты и значение прикладываемой силы [x,y,fx,fy]
% fixed_DOFs = [zeros(floor(size_y/element_size_y)+1,1),(element_size_y*(0:floor(size_y/element_size_y)))',ones(floor(size_y/element_size_y)+1,1)
%     480,40,2];

epsilon = 1; zeta = 0.125;
p = size(E0,1); % количество материалов
%q = 3; % штрафная степень



