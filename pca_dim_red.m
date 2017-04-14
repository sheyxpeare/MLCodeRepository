%mu = mean(Xtrain);
%Xtrain = bsxfun(@minus,Xtrain,mu);
[coeff,score,latent,tsquared,explained,mu] = pca(Xtrain);

%summ =0;
%for i=1:500
%    latent(i) = latent(i).*latent(i);
%    summ = summ + latent(i);
%end

%latent = latent./summ;

Xtrain = Xtrain*coeff(:,1:400); 
 
Xtest = bsxfun(@minus,Xtest,mu); % center the test data
Xtest = Xtest*coeff(:,1:400);
