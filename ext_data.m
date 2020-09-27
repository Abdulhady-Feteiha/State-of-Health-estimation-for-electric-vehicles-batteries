function [Data,labels] = ext_data(DataVar)

Data = {};
bcycle = DataVar.cycle;
labels = [];
flag = true;
for i = 1:length(bcycle)
    if isequal(bcycle(i).type, 'discharge')
        vTemp = bcycle(i).data.Voltage_measured;

        iTemp = bcycle(i).data.Current_measured;

        tTemp = bcycle(i).data.Temperature_measured;
        
        cap = bcycle(i).data.Capacity;

        if cap
            if flag
                initial_cap = cap;
                flag = false;
            end
            Data{end+1} = [vTemp; iTemp; tTemp];
            labels(end+1,1) = cap/initial_cap;
        end
    end
end
Data = reshape(Data,length(Data),1);
