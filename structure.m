%%
measurements:
input = (616x4, 6xv)
ouptu = regression

Data = ext_data(measurements)
Data = 616x3xv


Aug_data = augment(Data,add_gauss)
Aug_data =  8624x3xv/20944x3xv

mov_av_data = mo_average(Aug_data,window)
mov_av_data = 8624x5xv/20944x5xv

Datasets = preprocessing(measurements)
[Network,info,valX,valY,norm] = Transfer_learning(Datasets)

%%
Data = ext_data(measurements)

