%function [Ktrn,Ktst,B] =elmHBCK(XTrn,XTst,XTrnm,XTstm,YTrn,L,mu,C,sigma1,sigma2)    
function [pred,traintime,testime] =elmHBCK(XTrn,XTst,XTrnm,XTstm,YTrn,mu,sigma1,sigma2)    
[nTrn,~] = size(XTrn); 
classLabel = unique(YTrn);  nClass = length(classLabel);
tstart = tic;
temp_T = zeros(nClass, nTrn);
for i = 1 : nTrn
    for j = 1 : nClass
        if classLabel(j) == YTrn(i)
            break;
        end
    end
    temp_T(j,i) = 1;
end
T = temp_T*2 - 1;
kw=calckernel('rbf', sigma1, XTrn, XTrn);                                  %[nTrn,nTrn]kw
ks=calckernel('rbf', sigma2, XTrnm, XTrnm);                                %[nTrn,nTrn]ks
k=mu*ks+(1-mu)*kw;
B=(k)\T';
traintime=toc(tstart);
tstart = tic;
kww=calckernel('rbf', sigma1, XTrn, XTst);                                 %[nTrn,nTst]kww
kss=calckernel('rbf', sigma2, XTrnm, XTstm);                               %[ntrn,ntst]kss
kx=mu*kss+(1-mu)*kww;
p=B'*kx';
testime=toc(tstart);
[~,pred]=max(p);  
end

                                                         %找出结果中每列的最大值的行号赋值给pred
