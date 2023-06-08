function [y ssw stdo]= generate_synth(N,wh,pl,index,dt)
% y = generate_synth(N,wh,pl,index,dt)

% Function to generate synthetic series with white noise (amplitude wh) and power-law noise
% with amplitude (pl and spectral index  index). N is the length of the time series required
% and dt is the sampling period in years i.e. one day = 1/365.25


degree = index / 2;
h      = cumprod([1;[0:1:N-2]'-degree]./[1;[1:1:N-1]']);

rw     = fftfilt(h,pl.*dt.^(-index/4) .* randn(N,1));

sw = wh .* randn(N,1);
ssw = std(sw);
y = sw + rw;
stdo = std(rw);
return;
