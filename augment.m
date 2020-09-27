function [Aug_data,labels] = augment(Data,labels,add_gauss)

offC = 0.11;
gainC = 0.002;
offV = 0.004;
offT = 5;
augMat= [gainC 0 0 0; gainC offC 0 0; gainC offC offV 0; gainC offC offV offT; -gainC 0 0 0; -gainC offC 0 0; -gainC offC offV 0; -gainC offC offV offT; gainC -offC 0 0; gainC -offC offV 0; gainC -offC offV offT; gainC -offC offV -offT; 1 -offC -offV -offT];

for i=1:length(Data)
    for j=1:length(Data{i})
        for k=1:length(augMat)
            Data{i}{end+1} = Data{i}{j}.*augMat(k,4)+augMat(k,1:3)';
            labels{i}(end+1) = labels{i}(j);
        end
    end
end
Aug_data = Data;
end
                
           