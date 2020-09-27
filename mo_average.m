function mov_av_data = mo_average(Aug_data,av_window_size,DataPath)

mov_av_data = {};
avgd_seq = [];
for i=1:length(Aug_data)
    sprintf("Preparing dataset number: %s",DataPath{i})
    k = 0;
    for j=1:length(Aug_data{i})
        sequence = Aug_data{i}{j};
            for l=1:3
                avgd_seq(l,:) = sequence(l,av_window_size:end);
                
                if l<3
                    for m=av_window_size:length(sequence)
                        step = av_window_size-1;
                        avgd_seq(l+3,m-step)  = sum(sequence(l,m-step:m))/av_window_size;
                    end
                end
            end
            if ~isempty(avgd_seq)
                k = k+1;
                mov_av_data{i}{k,1} = (avgd_seq);
            end
            avgd_seq = [];
        
    end
end

                
                    
