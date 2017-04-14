%Find best parameters using crossvalidation
bestcv = 0;
for c = 15:30,
  for g = -30:-15,
    cmd = ['-v 5 -c ', num2str(1.2^c), ' -g ', num2str(1.5^g)];
    cv = svmtrain(Ytrain, Xtrain, cmd);
    if (cv >= bestcv),
      bestcv = cv; bestc = 1.2^c; bestg = 1.5^g;
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', c, g, cv, bestc, bestg, bestcv);
  end
end

%Best Parameters 
model = svmtrain(Ytrain, Xtrain , '-c 1024 -g 0.000976562 -t 2 -b 1');
[predict_label, accuracy, prob_estimates] = svmpredict(ones(1001,1), Xtest, model, '-b 1');

%Given Parameters 
model = svmtrain(Ytrain, Xtrain , '-c 15.407 -g 1.76009e-05 -t 2 -b 1');
[predict_label, accuracy, prob_estimates] = svmpredict(ones(1001,1), Xtest, model, '-b 1');

%Given Parameters 
model = svmtrain(Ytrain, Xtrain , '-c 38.4434 -g 7.82264e-06 -t 2 -b 1');
[predict_label, accuracy, prob_estimates] = svmpredict(ones(1001,1), Xtest, model, '-b 1');

%Given Parameters 
model = svmtrain(Ytrain, Xtrain , '-c 50 -g 0.00005 -t 2 -b 1 -v 5');
[predict_label, accuracy, prob_estimates] = svmpredict(ones(1001,1), Xtest, model, '-b 1');
dlmwrite('prediction.csv',prob_estimates,'precision', '%.9f');

%0.4817
%0.45