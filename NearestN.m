function NearestN
k=3;
data = [2.7810836    2.550537003     0
       1.465489372    2.362125076     0             
       3.396561688    4.400293529     0
       1.38807019    1.850220317     0
       3.06407232    3.005305973     0
       7.627531214    2.759262235     1
       5.332441248    2.088626775     1
       6.922596716    1.77106367      1
       8.675418651    0.2420686549    1
       7.673756466    3.508563011     1];
   X1 = data(:,1);
   X2 = data(:,2);
   Y = data(:,3);
   
   %cross-validation partition
   cv=cvpartition(Y,'LeaveOut');
   for i = 1:cv.NumTestSets
       trainingIdx = cv.training(i);
       testingIdx = cv.test(i);
       
       figure;
       gscatter(X1(trainingIdx),X2(trainingIdx),Y(trainingIdx),'rb','',20)
       set(gca,'xlim',[0 10],'ylim',[0 10]);
       hold on;
       plot(X1(testingIdx),X2(testingIdx),'g.','markersize',20);
   
       predictedLabel(i) = knn([X1(testingIdx),X2(testingIdx)], [X1(trainingIdx),X2(trainingIdx)], Y(trainingIdx), k);
       acc(i) = Y(cv.test(i)) == predictedLabel(i);    
   end
   meanacc=mean(acc);
   fprintf('Accuracy: %2.6f\n',meanacc);
   
    function predictedLabels = knn(testing, training, trainingLabels, k)
        for i = 1:size(testing,1)
            for j = 1:size(training,1) %take every trainingdata
                %compute euclidean distance between test and every
                %trainingdata
                diff = testing(i,:) - training(j,:)
                squarediff = diff.^2
                s = sum(squarediff);
                d(j) = sqrt(s);
                
            end
            
            [srt,srtidx] = sort(d,'ascend');
            neighbours = trainingLabels(srtidx(1:k));
            
            predictedLabels(i) = mode(neighbours);
        end