
function SampEnVal = SampEn(data, m, r)
% SampEn  计算时间序列data的样本熵
% 输入：data是数据一维行向量
%      m重构维数，一般选择1或2，优先选择2，一般不取m>2
%      r 阈值大小，一般选择r=0.1~0.25*Std(data)
% 输出：SampEnVal样本熵值大小

data = data(:)';%转化为行向量
N = length(data);%数据点个数
Nkx1 = 0;%所有m维向量在容限r下的匹配概率之和
Nkx2 = 0;%所有m维向量在容限r下的匹配概率之和

%构造两个向量空间，一个是m维，一个是m+1维，为了让两个不同维度的向量个数相同，从1取到N-m而非N-m+1
for k = N - m:-1:1
    x1(k, :) = data(k:k + m - 1);%m维
    x2(k, :) = data(k:k + m);%m+1维
end

%
for k = N - m:-1:1%分别对m维和m+1维空间中的所有向量计算容限r下的匹配数目（即在定义的距离下，向量之间的距离小于r的概率之和）
    x1temprow = x1(k, :);%取出Xk
    x1temp    = ones(N - m, 1)*x1temprow; %将每行都展成Xk，方便后续统一计算
    dx1(k, :) = max(abs(x1temp - x1), [], 2)';   %对每个Xk，计算其余向量与Xk的最大距离(max函数按第二个维度，行，取最大值)
    Nkx1 = Nkx1 + (sum(dx1(k, :) < r) - 1)/(N - m - 1);    %不能计算自己（自己与自己的距离为0，不作数），因此分母也是N-M再减去1
    x2temprow = x2(k, :);
    x2temp    = ones(N - m, 1)*x2temprow;
    dx2(k, :) = max(abs(x2temp - x2), [], 2)';
    Nkx2      = Nkx2 + (sum(dx2(k, :) < r) - 1)/(N - m - 1);%对m+1维的向量也计算一遍
end
Bmx1 = Nkx1/(N - m);%在相似容限r下匹配m个点的概率
Bmx2 = Nkx2/(N - m);%在相似容限r下匹配m+个点的概率
SampEnVal = -log(Bmx2/Bmx1);%近似熵指数
end
