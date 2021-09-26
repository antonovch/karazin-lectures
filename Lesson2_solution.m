%% Lesson 2: collecting data from multiple files
% Data files: <https://drive.google.com/file/d/1kwzy0HeYRou9QeiHVmkFYbIildTKhpWc/view?usp=sharing 
% https://drive.google.com/file/d/1kwzy0HeYRou9QeiHVmkFYbIildTKhpWc/view?usp=sharing>
% 
% Function for getting the images: <https://drive.google.com/file/d/1BcNXAMLo7hLsOLZH2Z2olaXHmey7TGTU/view?usp=sharing 
% https://drive.google.com/file/d/1BcNXAMLo7hLsOLZH2Z2olaXHmey7TGTU/view?usp=sharing> 
% 
% Each file name has the following structure: geometry name + _P + period + 
% _H + height.

periods = 300:50:400;
heights = 600:100:1000;
geom_names = {'post','post_inverted','mid_corner_circ',...
    'mid_corner_circ_inverted','4ellipses','4ellipses_inverted',...
    'cross','cross_inverted','4bars_rounded','4bars_rounded_inverted',...
    '2posts','2posts_inverted'};
%% 
% Each file has a |data| matrix, size number of wavelength times number of geometries, 
% vector of wavelength values and cell array of function handles that generate 
% the images.
% Task 1. Get all the datafile names as a cell array using ls.
% On Unix

list = ls('datafiles/simdata/*.mat'); % note file path may vary
list = split(list);
list(end) = []; % delete final empty array
%% 
% On Windows

list = ls('datafiles/simdata/*.mat'); % note file path may vary
% add additional padding with spaces
list = [list, repmat(' ',size(list,1),1)];
list = list.';
list = list(:).';
list = split(list, ' ');
% remove empty cells
list(cellfun(@isempty, list)) = [];
% delete '.' and '..' cells
list(1:2) = []; % or list = list(3:end);
%% 
% Or another simpler way for Windows

list = ls('datafiles/simdata/*.mat'); % note file path may vary
list = num2cell(list, 2); % put each row into a cell
list = cellfun(@strip, list, 'UniformOutput', false); % remove extra whitespaces
% this cellfun is totally equivalent to the following loop
% for i = 1:length(list)
%     list{i} = strip(list{i});
% end
% Task 2. Collect all the data for different paramters into one large matrix glued along the 'geometry' dimension.

data = [];
for i = 1:length(list)
    f = load(list{i});
    data = [data, f.data]; % ignore the warning
end
% Task 3. Plot phase scatter plots for all the data as in Lesson 1.

% Same as in Lesson 1 (Tasks 2 and 3), but define phase as angle of data and amp as abs of
% data.
% Task 4. Make a scatter plot where in red we have 'non-iverted' geomtries, in blue -- 'inverted' ones.

% Hint: to filter out inverted geometries, in the for loop from Task 2 use
% contains(list{i},'inverted'). This checks if the filename contains the
% word "inverted". If it does, record the data to something like
% data_inverted array, instead of data.
% Hint 2: make same steps as in Task 3 (amp not needed, as color will be
% fixed)
% Task 5. In a seprate subplots for inverted and non-inverted, colorcode data by height. 

% In this task, the loop will be a bit different
data = cell(1,length(heights));
for hcurr = heights
    for i = 1:length(list{i})
        if contains(list{i}, ['H',num2str(hcurr)])
            % TO DO code
        end
    end
end
% Task 6. Create a new variable "volume fraction" and use it as color coding for the scatter plots (inverted and non-inverted separately).