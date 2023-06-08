function  snr = SNR( RawData,data )
%   compute SNR
snr = sum( data.^2) / sum ( (RawData-data).^2);

end

