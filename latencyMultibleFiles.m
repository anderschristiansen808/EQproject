% Change directory to where the wav files are located
cd('C:\Users\AU0012EF\OneDrive - WSA\Desktop\Soundfiles for eq test');

% Define the file names
fileNames = {'8024boost.wav', '8024flat.wav', '8024out.wav', 'Fabfilter sine.wav', 'focusrite only.wav'};

% Load the reference signal from a wav file and extract a single channel
[ref, FsRef] = audioread('sine.wav');
ref = ref(:,1); 

% Loop over all input files
for i = 1:length(fileNames)
    % Load the signal from a wav file
    [x, Fs] = audioread(fileNames{i});

    % Set the length of the input signal equal to the length of the reference signal
    x = x(1:length(ref));

    % Cross-correlate the input signal with the reference signal
    [r, lags] = xcorr(x, ref);

    % Find the index of the maximum value in the cross-correlation function
    [~, maxIdx] = max(abs(r));

    % Calculate the latency time for the input signal
    latencyTime = lags(maxIdx) / Fs;

    % Print the results
    fprintf('Latency time in %s = %.4f seconds\n', fileNames{i}, latencyTime);
end