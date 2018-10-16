function [dicomInfo image] = read_dicoms(directory)
dicomlist = dir(fullfile(directory,'*.dcm'));
for cnt = 1 : numel(dicomlist)
    dicomInfo{cnt} =dicominfo(fullfile(directory,dicomlist(cnt).name));
    image{cnt} = dicomread(fullfile(directory,dicomlist(cnt).name));
end
end

