
for i=1:size(Ytrain)
    if(Ytrain(i) ~= 3)
        Ytrain(i) = Ytrain(i) + 1;
    end
end

numInst = size(Xtrain,1);
numLabels = max(Ytrain);

%# split training/testing
idx = randperm(numInst);
numTrain = 400; numTest = numInst - numTrain;
trainData = Xtrain(idx(1:numTrain),:);  testData = Xtrain(idx(numTrain+1:end),:);
trainLabel = Ytrain(idx(1:numTrain)); testLabel = Ytrain(idx(numTrain+1:end));


%# train one-against-all models
model = cell(numLabels,1);
for k=1:numLabels
    model{k} = svmtrain(double(Ytrain==k), Xtrain, '-c 50 -g 0.00005 -t 2 -b 1');
end

%# get probability estimates of test instances using each model
prob = zeros(numTest,numLabels);
for k=1:numLabels
    [~,~,p] = svmpredict(double(testLabel==k), testData, model{k}, '-b 1');
    prob(:,k) = p(:,model{k}.Label==1);    %# probability of class==k
end

numTest = 1001;
prob = zeros(numTest,numLabels);
for k=1:numLabels
    [~,~,p] = svmpredict(double(ones(1001,1)==k), Xtest, model{k}, '-b 1');
    prob(:,k) = p(:,model{k}.Label==1);    %# probability of class==k
end

for k=1:numTest
    sumall = sum(prob(k,:));
    prob(k,:)= prob(k,:)./sumall;
end

for k=1:numTest
    sumall(k) = sum(prob(k,:));
end
dlmwrite('prediction.csv',prob);

%# predict the class with the highest probability
[~,pred] = max(prob,[],2);
acc = sum(pred == testLabel) ./ numel(testLabel)    %# accuracy
C = confusionmat(testLabel, pred)                   %# confusion matrix