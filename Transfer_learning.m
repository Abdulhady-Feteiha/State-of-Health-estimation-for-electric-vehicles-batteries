function [Nets,Info] = Transfer_learning(mov_av_data,labels,epochs,DataPath)
inputSize = length(mov_av_data{1}{1}(:,1));

%{
layersLSTM = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(64,'OutputMode','sequence')
    lstmLayer(32,'OutputMode','last')
    fullyConnectedLayer(16)
    fullyConnectedLayer(1)
    regressionLayer
    ];
%}
layersLSTM = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(32,'OutputMode','last')
    fullyConnectedLayer(1)
    regressionLayer
    ];

Network =  SeriesNetwork(layersLSTM);
valX = {};
valY = {};
Nets = {};
Info = {};
for D = 1:length(mov_av_data)
    sprintf("Training on Dataset Number: %s",DataPath{D})
    Dataset = mov_av_data{D};
    label = labels{D};
    %{
    [trainInd,valInd] = dividerand(length(Dataset),0.99,0.01);
    valx = Dataset(valInd);
    valy = label(valInd);
    trainx = Dataset(trainInd);
    trainy = label(trainInd);
    %}
%        'Plots','training-progress' ,'Shuffle', 'once', ...
    options = trainingOptions('adam', ...
        'InitialLearnRate', 0.01, ...
        'MaxEpochs',epochs, ...
        'MiniBatchSize',128, ...
        'Plots','training-progress', 'Shuffle', 'every-epoch', ...
        'LearnRateSchedule','piecewise','LearnRateDropFactor',0.1);

%        'ValidationData',{valx,valy});
    [Network,info] = trainNetwork(Dataset, label, Network.Layers, options);

    Nets{end+1} = Network;
    Info{end+1} = info;
    %valX{end+1} = valx;
    %valY{end+1} = valy;
    
end
end