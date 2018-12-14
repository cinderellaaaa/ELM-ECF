function[testresult]=sselm(trainsamples,testsamples,Xtainm,Xtestm,trainlabels,L,mu)%(304,200)(9945,200)(304,200)(1,304)
trainsamples=trainsamples';
testsamples=testsamples';
[dim,ntrn]=size(trainsamples);
[~,ntest]=size(testsamples);
Ytrain=zeros(16,ntrn);
for i=1:ntrn
    Ytrain(trainlabels(i),i)=1;
end
Ytrain=Ytrain*2-1;
%--------------------ÑµÁ·----------------------%

w=rand(L,dim)*2-1;
b=rand(L,1);
b1=repmat(b,1,ntrn);
H11=w*trainsamples+b1;
H12=w*Xtainm'+b1;
H11=1./(1+exp(-H11));
H12=1./(1+exp(-H12));
H1=(1-mu)*H11+mu*H12;
% B=pinv(H1')*Ytrain';
B=((H1*H1')\H1)*Ytrain';
%------------²âÊÔ----------------%
b2=repmat(b,1,ntest);
H21=w*testsamples+b2;
H22=w*Xtestm'+b2;
H21=1./(1+exp(-H21));
H22=1./(1+exp(-H22));
H2=(1-mu)*H21+mu*H22;
Ytest=B'*H2;

[~,testresult]=max(Ytest);



