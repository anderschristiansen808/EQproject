% Change directory to where the wav file is located
cd('C:\Users\AU0012EF\OneDrive - WSA\Desktop\Soundfiles for eq test');

% Load the first signal from a wav file
[x1, Fs1] = audioread('8024boost.wav');

% Load the second signal from a wav file
[x2, Fs2] = audioread('focusrite only.wav');



% Load the reference signal from a wav file and extract a single channel
[ref, FsRef] = audioread('sine.wav');
ref = ref(:,1); 

% Set the length of the input signals equal to the length of the reference signal
x1 = x1(1:length(ref));
x2 = x2(1:length(ref));

% Cross-correlate the first signal with the reference signal
[r1, lags1] = xcorr(x1, ref);

% Cross-correlate the second signal with the reference signal
[r2, lags2] = xcorr(x2, ref);

% Find the index of the maximum value in the cross-correlation function of each signal
[~, maxIdx1] = max(abs(r1));
[~, maxIdx2] = max(abs(r2));

% Calculate the latency time for each signal
latencyTime1 = lags1(maxIdx1) / Fs1;
latencyTime2 = lags2(maxIdx2) / Fs2;

% Print the results
fprintf('Latency time in %s = %.4f seconds\n', '8024boost.wav', latencyTime1);
fprintf('Latency time in %s = %.4f seconds\n', 'focusrite only.wav', latencyTime2);