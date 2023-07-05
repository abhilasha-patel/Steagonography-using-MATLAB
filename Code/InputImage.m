function [Path] =  InputImage()


[filename, pathname] = uigetfile('*.*','Select the Image file');

% if isequal(filename,0)
%    disp('User selected Cancel')
% else
%    disp(['User selected ', fullfile(pathname, filename)])
% end

Path = fullfile(pathname, filename);

