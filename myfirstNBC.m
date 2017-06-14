% Dr. George Azzopardi
% Predictive Analysis
% October 2015
function myfirstNBC

load irisData;
load irisLabels;

irisData = normr(irisData);
uniqueClasses = unique(irisLabels);

cv = cvpartition(irisLabels,'KFold',10);
for i = 1:cv.NumTestSets
    trainingIdx = cv.training(i);
    testIdx = cv.test(i);
    
    % Determine NB Model
    [priors,likelihoods] = determineNBModel(irisData(trainingIdx,:),irisLabels(trainingIdx));
    
    % Test Model
    pl = applyNBModel(irisData(testIdx,:), priors, likelihoods);
    predictedLabel = uniqueClasses(pl);
    
    % Compute accuracy for each partition
    acc(i) = sum(strcmp(predictedLabel,irisLabels(testIdx)));
end

% Compute the mean accuracy
meanacc = sum(acc)/numel(irisLabels);
fprintf('Mean accuracy: %2.6f\n',meanacc);

function [priors,likelihoods] = determineNBModel(trainingData,trainingLabels)

% Compute prior probabilities
uniqueClasses = unique(trainingLabels);
for i = 1:numel(uniqueClasses)
    idx = strcmp(trainingLabels,uniqueClasses(i));
    
    priors(i) = sum(idx)/numel(trainingLabels);
    
    % Compute likelihoods
    likelihoods(i).mean = mean(trainingData(idx,:));
    likelihoods(i).std = std(trainingData(idx,:));    
end

function predictedLabel = applyNBModel(testData, priors, likelihoods)
predictedLabel = [];
for i = 1:size(testData,1)   
    for j = 1:numel(priors)
        component1 = -(testData(i,:) - likelihoods(j).mean).^2;
        component2 = 2 .* (likelihoods(j).std).^2;
        component3 = 1./(sqrt(2*pi)*likelihoods(j).std);
        gf = component3 .* exp(component1/component2);                
        posterior(j) = prod(gf) * priors(j);
    end
    [mx,mxind] = max(posterior);
    predictedLabel(i) = mxind;
end