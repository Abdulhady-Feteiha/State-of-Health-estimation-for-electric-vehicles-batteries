function [Data,labels,DataPath] = load_data()


FolderName = uigetdir('','Select folder to store data from each training iteration'); 
DataPath = dir(fullfile(FolderName, '*.mat'));
DataPath = {DataPath.name};

Num_datasets = length(DataPath);

for i=1:Num_datasets
    load(fullfile(FolderName,DataPath{i}))
end

Data = {};
labels = {};
norm = {};
for i=1:Num_datasets
    VarName = split(DataPath{i},".");
    DataVar = eval(string(VarName{1}));
    [Data{end+1},labels{end+1}] = ext_data(DataVar);
    
end

