% Dr. George Azzopardi
% October 2015
% ICS5110 - Applied Machine Learning
function accuracy = LVQ_CrossVal(nprotosperclass,normalize)
%check for arguments, if none set default values
if nargin == 0
   nprotosperclass = 3;
   normalize = 1;
end

% Load the data
load('irisdata.mat');
load('irisLabels.mat');

% For visualization purpose use only 2 dimensions (the first and the
% fourth)
labels = irisLabels;

if normalize
   % Normalize vectors to unit length
   data = normr(data);
end

% Create a random permutation
if exist('randpermlist.mat')
   load('randpermlist.mat');
else
   randpermlist = randperm(numel(labels));
   save randpermlist randpermlist;
end

%Bepaal training- en testsets met crossvalidation
cv = cvpartition(labels,'Kfold',10);

for i = 1:cv.NumTestSets
    trainingIdx = cv.training(i);
    testingIdx = cv.test(i);
    trainingData=data(trainingIdx,:);
    trainingLabels=labels(trainingIdx,:);
    testingData=data(testingIdx,:);
    testingLabels=labels(testingIdx,:);
    % Intialize the prototypes randomly
    [protosWeights, protosLabels] = initProtos(trainingData,trainingLabels,nprotosperclass);

    for iter = 1:10
        % Learning rate alpha decreases over time
        alpha = exp(-0.7*iter);
        for i = 1:size(trainingData,1)    
            widx = getWinner(trainingData(i,:),protosWeights);

            if strcmp(protosLabels{widx},trainingLabels{i})
                % The winner prototype is of the same class
                protosWeights(widx,:) = protosWeights(widx,:) + alpha * (trainingData(i,:) - protosWeights(widx,:));
            else
                % The winner prototype is of different class
                protosWeights(widx,:) = protosWeights(widx,:) - alpha * (trainingData(i,:) - protosWeights(widx,:));
            end        
        end
    end
    
    %prototypes = protosWeights
    
    for i = 1:size(testingData,1)
        dist = zeros(1,size(protosWeights,1));
        for j = 1:size(protosWeights,1)
            dist(j) = norm(testingData(i,:) - protosWeights(j,:));
        end
        [mn,mnidx] = min(dist);
        predictedLabel{i} = protosLabels{mnidx};
    end

    %For every cross-validation run find total number of matches in
    %predicted labels and testing labels
    acc(i) = sum(strcmp(predictedLabel,testingLabels'));
end
%compute accuracy. Sum over all found matches and divide by number of
%cross-validation runs.
accuracy=sum(acc)/numel(acc);

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