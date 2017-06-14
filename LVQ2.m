% Dr. George Azzopardi
% October 2015
% ICS5110 - Applied Machine Learning
function accuracy = LVQ2(nprotosperclass,normalize)
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

% Split data set into 50% training and 50% testing
ntraining = floor(0.5*numel(labels));
trainingData = data(randpermlist(1:ntraining),:);
trainingLabels = labels(randpermlist(1:ntraining));
testingData = data(randpermlist(ntraining+1:end),:);
testingLabels = labels(randpermlist(ntraining+1:end));
uniqueLabels = unique(trainingLabels);

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
           protosWeights(widx,:) = protosWeights(widx,:) - alpha * (trainingData(i,:) - protosWeights(widx,:));
           % The winner prototype is of different class
       end        
   end
end

for i = 1:size(testingData,1)
   dist = zeros(1,size(protosWeights,1));
   for j = 1:size(protosWeights,1)
       dist(j) = norm(testingData(i,:) - protosWeights(j,:));
   end
   [mn,mnidx] = min(dist);
   predictedLabel{i} = protosLabels{mnidx};
end

% Comptue accuracy; i.e. number of matches division by the number of
% testing samples
accuracy = sum(strcmp(predictedLabel,testingLabels'))/numel(testingLabels);

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