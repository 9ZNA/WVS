function rmse = RMSE(IMF,RawData)
%   Compute the RMSE
[m n] = size(IMF);
% if m==1
%     IMF=IMF';
% end
summation = sum ( ( IMF-RawData ).^2) / length(RawData);
rmse = sqrt(summation);
end
