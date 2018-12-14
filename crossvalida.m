%------------------------------通过交叉验证得到最优的两个sigma------------------------------------%
function [sigma1,sigma2,crosstime] = crossvalida(XTrn,XTrnm,YTrn,sigma,mu)                          
[nTrn ,~] = size(XTrn);                           %[583,200],9783
classLabel = unique(YTrn);  nClass = length(classLabel);                  
temp_T = zeros(nClass, nTrn);                                            
cgtmp=double(zeros(length(sigma),length(sigma)));
cg=double(zeros(length(sigma),length(sigma)));
for i = 1 : nTrn
    for j = 1 : nClass
        if classLabel(j) == YTrn(i)
            break;
        end
    end
    temp_T(j,i) = 1;
end
T = temp_T*2 - 1;                                                         
%--------------------------5重交叉验证，找出可以使光谱信息精度达到最高的sigma1和c------------------------------%
tstart = tic;
nfold = 5; nSamfold = floor(nTrn/nfold);                                  
nperm = randperm(nTrn);                                                   

for i = 1 : nfold                                                          
    idtst = ((i-1)*nSamfold + 1) : i*nSamfold;                              
    idtrn = 1 : nTrn; idtrn(idtst) = [];                                   
    idtst = nperm(idtst);  idtrn = nperm(idtrn);                           
    for p = 1 : length(sigma)                                              
            s1 = sigma(p);      
            Kw  = calckernel('rbf', s1, XTrn(idtrn,:), XTrn(idtrn,:));      
            Kwt = calckernel('rbf', s1, XTrn(idtrn,:),  XTrn(idtst,:));       
        for q=1:length(sigma)   
            s2 = sigma(q);      
            Ks  = calckernel('rbf', s2, XTrnm(idtrn,:), XTrnm(idtrn,:));   
            Kst = calckernel('rbf', s2, XTrnm(idtrn,:),  XTrnm(idtst,:));
            K=mu*Ks+(1-mu)*Kw;
            Kt=mu*Kst+(1-mu)*Kwt;               
                OutputWeight =( K)\T(:,idtrn)';               
                TY = (Kt * OutputWeight)';                                 
                [~,B1] = max(TY,[],1);                                             
                Ypre_tst = classLabel(B1);                                 
                cgtmp(p,q) = length(find(YTrn(idtst)==Ypre_tst)) / length(idtst);                    
         end
    end   
    cg = cg + cgtmp;                                                       
end
cg = cg/nfold;
[A1,B1]=find(cg==max(max(cg)));
sigma1=sigma(A1(1))
sigma2=sigma(B1(1))
crosstime=toc(tstart)
end

