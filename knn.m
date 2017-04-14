mdl = fitcknn(Xtrain,Ytrain) ;
[label,score,cost] = predict(mdl, Xtest);
dlmwrite('prediction.csv', score ,'precision', '%.9f');
%0.464