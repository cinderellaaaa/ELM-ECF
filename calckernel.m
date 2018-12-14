function K = calckernel(type, para, X1, X2)

if exist('X1','var')
    dim = size(X1, 2);
    n1  = size(X1, 1);
end

if exist('X2','var')
    n2 = size(X2, 1);
end

switch type
    case 'linear'
        if exist('X2','var')
            K = X2*X1';
        else
            K = X1*X1';
        end
    case 'poly'
        if exist('X2','var')
            K = (X2*X1' + 1).^para; 
        else
            K = (X1*X1' + 1).^para; % coef = 1 or 0;
        end

    case 'rbf'
        if exist('X2','var')
            K = exp(-(repmat(sum(X1.*X1,2)',n2,1) + repmat(sum(X2.*X2,2),1,n1) ...            %.*就是相同位置上的元素相乘         
                - 2*X2*X1')/(2*para^2));
        else
            P = sum(X1.*X1,2);
            K = exp( -( repmat(P',n1,1)+repmat(P,1,n1)-2*X1*X1' ) / (2*para^2) );
        end
    otherwise
        error('Unknown Kernel Function.');
end

