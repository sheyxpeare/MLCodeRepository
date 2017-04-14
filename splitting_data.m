%splitting data
%Random permutations
num_points = size(Xtrain,1);
split_point = round(num_points*0.7);
split_point = 501;
seq = randperm(num_points);
Xtrain = Xtrain(seq(1:split_point),:);
Ytrain = Ytrain(seq(1:split_point));
X_test = Xtrain(seq(split_point+1:end),:);
Y_test = Ytrain(seq(split_point+1:end));

%Another splitting
numInst = size(Xtrain,1);
numLabels = max(Ytrain);

%# split training/testing
idx = randperm(numInst);
numTrain = 400; numTest = numInst - numTrain;
trainData = Xtrain(idx(1:numTrain),:);  testData = Xtrain(idx(numTrain+1:end),:);
trainLabel = Ytrain(idx(1:numTrain)); testLabel = Ytrain(idx(numTrain+1:end));