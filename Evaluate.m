function Evaluate(Nets,Info,Data,mov_av_data,norm_labels,DataPath,norm)

for i=1:length(Nets)
    
    x= mov_av_data{i};
    Predictions = predict(Nets{i}, x);
    
    SOH = Predictions.*norm(i,2)+norm(i,1);
    gold = (norm_labels{i}.*norm(i,2))+norm(i,1);
    
    DataLen = length(Data{i});
    dataset_name = split(DataPath{i},".");
    fig = figure('Name',dataset_name{1});
    plot(SOH(1:DataLen),'r-')
    hold all
    plot(gold(1:DataLen),'b-')
    
    filename = append('figs/',dataset_name{1},'.png');
    title(filename)
    xlabel('Time')
    ylabel('SOH')
    legend({'Predicted','Gold'},'Location','southwest')
    saveas(fig,filename)
    
    error = abs(SOH(1:DataLen)-gold(1:DataLen));
    error_percent = error./gold(1:DataLen);
    mean_rror = mean(error)
    mean_error_percent = mean(error_percent)
    
    fig = figure('Name',dataset_name{1});
    plot(Info{i}.TrainingLoss,'r-')
    hold all
    plot(Info{i}.TrainingRMSE,'b-')
    
    filename = append('figs/',dataset_name{1},'_Training_process.png');
    title(filename)
    legend({'Training Loss','Training RMSE'})
    saveas(fig,filename)
end
end
