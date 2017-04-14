%% Fourier Kernel Attempt

n = length(Xtrain(:,1));
q = 0.5

Kernel=@(xi,xj) (1-q^2)./(2*(1-2*q*cos(xi-xj)+q^2));
K =  [ (1:n)' , Kernel(Xtrain,Xtrain) ];

H=zeros(n,n);

for i=1:n
    for j=1:n
        for k=1:n
            H(i,j)=Kernel(Xtrain(i,j),Xtrain(i,k));
        end
    end
end


K =  [ (1:n)' , H ];



%% RBF Kernel that works


n = length(Xtrain(:,1));
sigma = 0.00005;
rbfKernel = @(X,Y) exp(-sigma .* pdist2(X,Y,'euclidean').^2);
K =  [ (1:n)' , rbfKernel(Xtrain,Xtrain) ];

