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

E0 = [2e5,7e4,1e-9]';
sigma_max = [300 100 1]';
v = [0.2,0.2,0.6]';

% ЗАДАНИЕ ГЕОМЕТРИИ


% size_x = 50; size_y = 15; % размеры области проектирования мм
% passive_elem_bot_left_corner = [45,0];
% passive_elem_top_right_corner = [50,5];
% fixed_elem_bot_left_corner = [0,14.5; 49.5,5];
% fixed_elem_top_right_corner = [0.5,15; 50,5.5];
% 
% element_size_x = 1; % длинна элемента мм
% element_size_y = 1; % высота элемента мм
% h = 1; % толщина элемента мм
% forces = [0,size_y,0,-1]; % координаты и значение прикладываемой силы [x,y,fx,fy]
% fixed_DOFs = [zeros(16,1),(element_size_y*(0:15))',ones(16,1)
%     50,5,2];

size_x = 500; size_y = 150; % размеры области проектирования мм
passive_elem_bot_left_corner = [450,0];
passive_elem_top_right_corner = [500,50];
fixed_elem_bot_left_corner = [0,144; 494,50];
fixed_elem_top_right_corner = [6,150; 500,56];

element_size_x = 2; % длинна элемента мм
element_size_y = 2; % высота элемента мм
h = 10; % толщина элемента мм
forces = [0,size_y,0,-1000]; % координаты и значение прикладываемой силы [x,y,fx,fy]
fixed_DOFs = [zeros(76,1),(element_size_y*(0:75))',ones(76,1)
    500,50,2];

epsilon = 1; zeta = 0.125;
p = size(E0,1); % количество материалов
%q = 3; % штрафная степень



