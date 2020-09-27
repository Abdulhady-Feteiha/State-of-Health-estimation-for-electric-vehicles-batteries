%%
[Data,labels,DataPath] = load_data();

[Aug_data,labels] = augment(Data,labels,0);

[norm_data, norm_labels, norm] = Normalize(Aug_data, labels);

mov_av_data = mo_average(norm_data,50,DataPath);

save mov_av_data.mat

%%
epochs = 70;
[Nets,Info] = Transfer_learning(mov_av_data,norm_labels,epochs,DataPath);
save Nets.mat
%%
Evaluate(Nets,Info,Data,mov_av_data,norm_labels,DataPath,norm)
close all
fprintf("Plots saved to your figs directory, Networks saved to a Nets.mat file")