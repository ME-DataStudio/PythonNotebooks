function LogisticRegression

data = [2.7810836  2.550537003     0
       1.465489372 2.362125076     0             
       3.396561688 4.400293529     0
       1.38807019  1.850220317     0
       3.06407232  3.005305973     0
       7.627531214 2.759262235     1
       5.332441248 2.088626775     1
       6.922596716 1.77106367      1
       8.675418651 0.2420686549    1
       7.673756466 3.508563011     1];
X1 = data(:,1);   
X2 = data(:,2);   
Y = data(:,3);   
%initialisatie van theta-parameters en learning grade
t0=0;
t1=0;
t2=0;
alpha = 0.3;

cferror=[];
iter=0;

figure('color',[1 1 1]);
subplot(1,2,1)
gscatter(X1,X2,Y,'rb','',25);
set(gca,'xlim',[0,10],'ylim',[0 10]);
hold on;

while (iter < 2 ||abs(cferror(end) - cferror(end-1)) > 0.0001) && iter <100
    iter = iter + 1;
    mypred = t0+t1.*X1+t2.*X2;
    g=1./(1+exp(-mypred));
    cferror(iter)=-sum(Y.*log(g)+(1-Y).*log(1-g))/numel(Y);
    
    %mypred = t0+t1.*X1+t2.*X2;
    %g=1./(1+exp(-mypred));
    df = g - Y;
    df3 = df * ones(1,3);
    t = sum(df3.* [ones(numel(X1),1) X1 X2])./numel(Y);
    
    t0=t0 - alpha*t(1);
    t1=t1 - alpha*t(2);
    t2=t2 - alpha*t(3);
end
subplot(1,2,1);
XX = [min(X1) max(X1)];
db = (-t1.*XX - t0)./t2;
p=plot(XX,db,'g-','linewidth',2);