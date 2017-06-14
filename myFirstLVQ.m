% Dr. George Azzopardi
% Predictive Analysis
% October 2015
function meanacc = myFirstLVQ(nprotosperclass,normalize)

if nargin == 0
   nprotosperclass = 10;
   normalize = 1;
end

% Load the data
load('irisData.mat');
load('irisLabels.mat');

data = irisData;
labels = irisLabels;

if normalize
   % Normalize vectors to unit length
   data = normr(data);
end

cv = cvpartition(labels,'KFold',10);
for i = 1:cv.NumTestSets
    trainingIdx = cv.training(i);
    testIdx = cv.test(i);
    
    % Learn LVQ model with train data
    [protosWeights, protosLabels] = learnLVQModel(data(trainingIdx,:),labels(trainingIdx),nprotosperclass);
    
    % To test the model on the test data
    tData = data(testIdx,:);
    for h = 1:size(tData,1)
       dist = zeros(1,size(protosWeights,1));
       for j = 1:size(protosWeights,1)
           dist(j) = norm(tData(h,:) - protosWeights(j,:));
       end
       [mn,mnidx] = min(dist);
       predictedLabel{h} = protosLabels{mnidx};
    end    
    
    accuracy(i) = sum(strcmp(predictedLabel,labels(testIdx)'));
end

meanacc = sum(accuracy)/numel(labels);
fprintf('Final accuracy: %2.6f\n',meanacc);

function [protosWeights, protosLabels] = learnLVQModel(trainingData,trainingLabels,nprotosperclass)
% Intialize the prototypes randomly
[protosWeights, protosLabels] = initProtos(trainingData,trainingLabels,nprotosperclass);

for t = 1:10
   title(sprintf('Epoch %d',t));
   
   % Learning rate alpha decreases over time
   alpha = exp(-0.7*t);
   for i = 1:size(trainingData,1)    
       widx = getWinner(trainingData(i,:),protosWeights);

       if strcmp(protosLabels{widx},trainingLabels{i})
           % The winner prototype is of the same class
           protosWeights(widx,:) = protosWeights(widx,:) + alpha * (trainingData(i,:) - protosWeights(widx,:));
       else
           protosWeights(widx,:) = protosWeights(widx,:) - alpha * (trainingData(i,:) - protosWeights(widx,:));
           % The winner prototype is of different class
       end        
   end
end

function widx = getWinner(trainingDataPoint,protosWeights)
nprotos = size(protosWeights,1);
d = zeros(1,nprotos);
for i = 1:nprotos
   d(i) = norm(trainingDataPoint - protosWeights(i,:));
end
[mn,widx] = min(d);

function [protosWeights,protosLabels] = initProtos(trainingData,trainingLabels,nprotosperclass)

uLabels = unique(trainingLabels);
protosWeights = [];
protosLabels = cell(0);
nattributes = size(trainingData,2);

for i = 1:numel(uLabels)
   for j = 1:nprotosperclass
       idx = strcmp(trainingLabels,uLabels{i});
       mn = min(trainingData(idx,:));
       mx = max(trainingData(idx,:));
       protosWeights(end+1,:) = rand(1,nattributes).*(mx-mn)+mn;
       protosLabels{end+1} = uLabels{i};
   end
end