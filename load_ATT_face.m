function image = load_ATT_face(subjectID, imageID)
%-----used to get the image data--------%

path_to_data = fileparts(mfilename('fullpath'));%get the absolute path;
image = imread( fullfile(path_to_data, ['s' num2str(subjectID)], [num2str(imageID) '.pgm'] ));

