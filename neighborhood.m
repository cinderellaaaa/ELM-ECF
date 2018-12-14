% % set for squared neighborhood
function [ newdata]=neighborhood(wopt,nr,nDim,nAll,data2,GT)  %5,145,[1,1043],[9323,1],1043,9323,20,21025,[21025,20],27.0464
w = wopt; wc = (w-1)/2;  vv = -wc : wc; gamma0 = 1;
idw0 = repmat(vv*nr,w,1) + repmat(vv',1,w);
idw0 = reshape(idw0,1,w*w);          %[1,25]
newdata=zeros(nAll, nDim);         %[1043,200]
for i = 1 : nAll                     %1:1043
    if GT(i)~=0
        idw = idw0 + i;
        idw(idw>nAll | idw<1) = [];      %idw中存放的是indexs[i]周围的元素的地址
        dtmp = repmat(data2(i,:),length(idw),1) - data2(idw,:);
        A = sum(dtmp.*dtmp, 2);
        wei = exp(-gamma0*A);
        newdata(i,:) = 1/sum(wei) * sum(diag(wei)*data2(idw,:),1);
    end
end
end
