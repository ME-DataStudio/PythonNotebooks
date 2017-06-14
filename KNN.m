function KNN

%load habermanData;
load occupied;
summary(dataset(data));
X = data(:,1:end-1);
Y = data(:,end);

%Normaliseer de data en kijk of het beter of slechtere voorspellingen
%geeft.
X=normr(X);

%Three nearest neighbours
k = 3;

%Bepaal training- en testsets met crossvalidation
cv = cvpartition(Y,'Kfold',10);

for i = 1:cv.NumTestSets
    trainingIdx = cv.training(i);
    testingIdx = cv.test(i);
    
    predictedLabels = knn(X(testingIdx,:),X(trainingIdx,:), Y(trainingIdx), k);
    %sommeer alle voorspelling naar een getal en dit gebruik je als
    acc(i) = sum(predictedLabels == Y(testingIdx)');
end

accuracy = sum(acc) / numel(Y);
fprintf('Accuracy: %2.6f\n',accuracy);


function predictedLabels = knn(testing, training, trainingLabels, k)
for i = 1:size(testing,1)
    for j = 1:size(training,1) %take every trainingdata
        %compute euclidean distance between test and every
        %trainingdata
        diff = testing(i,:) - training(j,:);
        squarediff = diff.^2;
        s = sum(squarediff);
        d(j) = sqrt(s);
    end
    [srt,srtidx] = sort(d,'ascend');
    neighbours = trainingLabels(srtidx(1:k));
    predictedLabels(i) = mode(neighbours);
end

function normdata = normr(data)

for i = 1:size(data,1)
   normdata(i,:) = data(i,:)./norm(data(i,:));
end
