% Dr. George Azzopardi
% October 2016
% Predictive Analysis

% Animation of gradient descent with one variable
function script3

x = 1:4;
y = 1:4;

figure;
plot(x,y,'r+','markersize',20);
set(gca,'xlim',[0 4],'ylim',[0 4],'fontsize',20,'xtick',0:3,'ytick',0:3,'xticklabel',0:3,'yticklabel',0:3);
xlabel('x','fontsize',20);
ylabel('y','fontsize',20);
axis square;

figure;
set(gca,'xlim',[-0.5 2.5],'ylim',[0 4],'fontsize',20,'xtick',-0.5:0.5:2.5,'ytick',0:3,'xticklabel',-0.5:0.5:2.5,'yticklabel',0:3);

if exist('theta.mat')
    load theta;
    load cf;
else
    for i = 1:100
        theta(i) = rand*8-3;
        cf(i) = sum(((theta(i).*x) - y).^2)/(2*numel(x));
    end
    save theta theta;
    save cf cf;
end
figure;plot(theta,cf,'r+');
axis square;

hold on;
iter = 1;
t = 4.5;
isconverged = 0;
alpha = 0.1;
axis equal;

while ~isconverged    
    cf(iter) = sum(((t.*x) - y).^2)/(2*numel(x));
    plot(t,cf(iter),'b.','markersize',30);
    
    grad = sum((t.*x - y).*x)/numel(x);  
        
    %line([t-0.5 t+0.5],[cf(iter)-grad/2, cf(iter)+grad/2]);
    quiver(t,cf(iter),-1,-grad)
    t = t - alpha*grad;
    
    pause(1);
    
    if iter > 2 && abs(cf(iter) - cf(iter-1)) < 0.0001
        isconverged = 1;
    else
        iter = iter + 1;
    end
end
z = 0;