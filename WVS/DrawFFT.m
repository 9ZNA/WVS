function fft_data = DrawFFT(data, fs)
N=length(data);
fft_data=fft(data);
magY=abs(fft_data(1:N/2))*2/N;
f=(0:N/2-1)'*fs/N;
figure()
plot(f,magY);
h=stem(f, magY, 'fill','--');
set(h,'MarkerEdgeColor','red','Marker','*');
grid on;
title('频谱图');xlabel('f(Hz)'), ylabel('幅值');
end