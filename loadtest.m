function [images, labels, indexs] = loadtest(img, gt,trainindexs)
% 生成实验1的测试样本
imgsize = size(img);
num = imgsize(1);     %20245
indexs = [];
gt(trainindexs)=0;             %gt145*145

for i = 1 : num                  %1:20245
    if gt(i) ~= 0
        indexs = [indexs; i];      %把类不是0的地址存进indexs
    end
end
toolnum = length(indexs);
for j=1:16
    a=find(gt==j);
    b=length(a);
end
    

labels = gt(indexs);
%bandmaxvalue=max(tempimg);
%maxmun=max(tempimg(:));
images =(img(indexs,:))';

end