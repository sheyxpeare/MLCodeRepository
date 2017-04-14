nb = fitNaiveBayes(Xtrain,Ytrain);
post = posterior(nb,Xtest);
dlmwrite('prediction.csv', post ,'precision', '%.9f');
%0.468