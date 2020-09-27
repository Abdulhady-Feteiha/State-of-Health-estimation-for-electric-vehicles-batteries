function [norm_data, norm_labels, norm] = Normalize(Aug_data, labels)

norm_data = Aug_data;
min_max = zeros(length(Aug_data),3,2);
min_max(:,:,1) = min_max(:,:,1)+100;
norm = zeros(length(labels),2);
norm_labels = labels;
for i=1:length(Aug_data)
    for j=1:length(Aug_data{i})
        for k=1:3
            mx = max(Aug_data{i}{j}(k,:));
            mn = min(Aug_data{i}{j}(k,:));
            if mn<min_max(i,k,1)
                min_max(i,k,1) = mn;
            end
            if mx>min_max(i,k,2)
                min_max(i,k,2) = mx;
            end
        end
    end
end
for i=1:length(Aug_data)
    r = min_max(i,:,2)-min_max(i,:,1);
    %rand_pos = randperm(length(Aug_data{i}));
    norm(i,1) = min(labels{i});
    norm(i,2) = max(labels{i}) - min(labels{i});
    for j=1:length(Aug_data{i})
%rand_pos(j)
        norm_data{i}{j} = (norm_data{i}{j}-min_max(i,:,1)')./r';
        norm_labels{i}(j) = (labels{i}(j) - norm(i,1))./norm(i,2);
    end
end
%norm_labels{i} =norm_labels{i}*100;

