% Dr. George Azzopardi
% Predictive Analysis
% October 2016
function accuracy = myfirstknn_cv(k)

% Iris Data set
load('irisData.mat');
load('irisLabels.mat');

irisData = normr(irisData);

% Use 10-fold cross validation
cv = cvpartition(irisLabels,'kfold',10);
for i = 1:cv.NumTestSets
    trainingIdx = cv.training(i);
    testingIdx = cv.test(i);
    accuracy(i) = knn(irisData(testingIdx,:), irisData(trainingIdx,:), irisLabels(testingIdx), irisLabels(trainingIdx), k);
end

accuracy = mean(accuracy);

% KNN
function accuracy = knn(testing, training, testingLabels, trainingLabels, k)
for i = 1:size(testing,1)
    for j = 1:size(training,1)
        diff = testing(i,:) - training(j,:);
        squareddiff = diff.^2;
        s = sum(squareddiff);
        d(j) = sqrt(s);
    end
        
    [srt,srtidx] = sort(d,'ascend');
    neighbours = trainingLabels(srtidx(1:k));
    
    [g,gn] = grp2idx(neighbours);
    m = mode(g);
    predictedLabels(i) = gn(m);
end

cmp = strcmp(testingLabels',predictedLabels);
accuracy = sum(cmp)/size(testing,1);