%% Lesson 2: collecting data from multiple files
% Data files: https://drive.google.com/file/d/1kwzy0HeYRou9QeiHVmkFYbIildTKhpWc/view?usp=sharing
% 
% Function for getting the images: https://drive.google.com/file/d/1BcNXAMLo7hLsOLZH2Z2olaXHmey7TGTU/view?usp=sharing 
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
%% Task 1. Get all the datafile names as a cell array using ls.


%% Task 2. Collect all the data for different paramters into one large matrix glued along the 'geometry' dimension.


%% Task 3. Plot phase scatter plots for all the data as in Lesson 1.


%% Task 4. Make a scatter plot where in red we have 'non-iverted' geomtries, in blue -- 'inverted' ones.


%% Task 5. In a seprate subplots for inverted and non-inverted, colorcode data by height. 


%% Task 6. Create a new variable "volume fraction" and use it as color coding for the scatter plots (inverted and non-inverted separately).
