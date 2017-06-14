% Groningen - Predictive Analysis
% Author: Dr. George Azzopardi
% Date: October 2016

% Logistic Regression - another example
function Tutorial_Exercise4

% https://archive.ics.uci.edu/ml/datasets/seeds
load seeds;

features = seeds(:,1:end-1);
label = seeds(:,end);
%features = normr(features);
features = (features - repmat(mean(features),numel(label),1))./repmat(std(features),numel(label),1);
un = unique(label);
% 
% for i = 1:numel(un)
%     idx = label == un(i);
%     model(i) = logisticRegression(features(idx,:),label(idx));
% end

cv = cvpartition(label,'k',10);
      
for k = 1:cv.NumTestSets
    trIdx = cv.training(k);
    teIdx = cv.test(k);
    
    trainingFeatures = features(trIdx,:);
    trainingLabels = label(trIdx);
    testingFeatures = features(teIdx,:);
    testingLabels = label(teIdx);
    
    nextid = 1;
    for i = 1:numel(un)-1
        for j = i+1:numel(un)
            posidx = find(trainingLabels == un(i));
            negidx = find(trainingLabels == un(j));
            local_labels = [zeros(1,numel(posidx)),ones(1,numel(negidx))]';
            local_training = trainingFeatures([posidx;negidx],:);
            model(nextid).theta = logisticRegression(local_training,local_labels);
            model(nextid).classes = [un(i) un(j)];            
            nextid = nextid + 1;
        end
    end

    prediction = [];
    for i = 1:numel(model)
        pr = ([ones(numel(testingLabels),1) testingFeatures] * model(i).theta');
        pr = (pr > 0) + 1;
        prediction(:,i) = model(i).classes(pr);
    end

    predictedLabel = mode(prediction');

    correctrate(k) = sum(predictedLabel  == label(teIdx)')/cv.TestSize(k);
end
fprintf('Classification rate = %2.6f\n',mean(correctrate));

function theta = logisticRegression(X,Y)
theta = zeros(1,size(X,2)+1); % parameters
alpha = 0.3; % learning rate

cferror = [];

iter = 0;
maxiter = 10000;

% gradient descent
while (iter < 2 || abs(cferror(end) - cferror(end-1)) > 0.00000001) && iter < maxiter
    iter = iter + 1;    

    % compute hypothesis
    mypred = [ones(size(X,1),1) X] * theta';
    g = 1./(1+exp(-mypred));       
    
    % compute cost function
    cferror(iter) = -sum(Y.*log(g)+(1-Y).*log(1-g))/numel(Y);    
    
    % partial derivatives
    pd = sum(repmat((g-Y),1,size(X,2)+1).*[ones(numel(Y),1) X])./numel(Y);
    
    % update parameters
    theta = theta - alpha.*pd;
end