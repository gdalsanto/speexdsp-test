clear all
clc

samples_far = {'farend_singletalk_lpb.wav', 'nearend_singletalk_lpb.wav','doubletalk_lpb.wav' };
samples_mic = {'farend_singletalk_mic.wav', 'nearend_singletalk_mic.wav','doubletalk_mic.wav' };

config = [0, 4096, 128; 128, 4096, 128; 256, 4096, 128; ...
    0, 8192, 128; 0, 16384, 128; ...
    0, 4096, 256; 0, 4096, 512 ];

for i = 1:length(config)
    delay = config(i,1);
    filter_length = config(i,2);
    frame_size = config(i,3);
    for j = 3:length(samples_far)
        [far, fs] = audioread(strcat('data/', samples_far{j}));
        [near_mic, fs] = audioread(strcat('data/', samples_mic{j}));
        % truncate to 10s
        if length(far) > 16e4
            far = far(1:16e4);
            near_mic = near_mic(1:16e4);
        else 
            far = [far; zeros(16e4-length(far),1)];
            near_mic = [near_mic; zeros(16e4-length(near_mic),1)];
        end
        % add delay to nearend microphone signal
        near_mic = [zeros(delay,1); near_mic(1:end-delay)];
        % run AEC
        speex_mdf_out = speex_mdf(fs, far, near_mic, filter_length, frame_size);
        % save error signal 
        filename = strcat('aec_source_', string(j), '_fl', string(filter_length), '_fs', string(frame_size), '_d', string(delay), '.wav');
        audiowrite(strcat('./data/output/', filename), speex_mdf_out.e, fs)
    end
end


        
