function autoinsuranceSweden

%Autinsurance in Sweden http://tinyurl.com/n8j28e2

data = [108	392.5
19	46.2
13	15.7
124	422.2
40	119.4
57	170.9
23	56.9
14	77.5
45	214
10	65.3
5	20.9
48	248.1
11	23.5
23	39.6
7	48.8
2	6.6
24	134.9
6	50.9
3	4.4
23	113
6	14.8
9	48.7
9	52.1
3	13.2
29	103.9
7	77.5
4	11.8
20	98.1
7	27.9
4	38.1
0	0
25	69.2
6	14.6
5	40.3
22	161.5
11	57.2
61	217.6
12	58.1
4	12.6
16	59.6
13	89.9
60	202.4
41	181.3
37	152.8
55	162.8
41	73.4
11	21.3
27	92.6
8	76.1
3	39.9
17	142.1
13	93
13	31.9
15	32.1
8	55.6
29	133.3
30	194.5
24	137.9
9	87.4
31	209.8
14	95.5
53	244.6
26	187.5];

x = data(:,1);
y = data(:,2);
mx = mean(x);
my = mean(y);
%Using leasts Squares
m = (mean(x.*y)-(mx*my))/(mean(x.^2)-mx^2);
b = my - m*mx;
%Using descending gradient
model = multipleLineairRegression(x,y);

figure;
plot(x,y,'b*');
hold on;
plot([min(x) max(x)],[model.theta(1,2)*min(x)+model.theta(1,1) model.theta(1,2)*max(x)+model.theta(1,1)],'b-','linewidth',2);
hold on;
plot([min(x) max(x)],[m*min(x)+b m*max(x)+b],'r-','linewidth',2);
xlabel('X');
ylabel('Y');
set(gca,'fontsize',20);

rho = corr(x,y);

function model = multipleLineairRegression(X,Y)
theta = zeros(1,size(X,2)+1);

isconverged = 0;
iter = 1;
alpha = 0.5;
while ~isconverged
        %Compute the prediction with the current model parameters
        %c1 = [ones(size(X,1),1) X] * theta';
        %Compute the total error with the current model parameters
        cf(iter) = sum((([ones(size(X,1),1) X] * theta') - Y).^2)/(2*numel(Y));
        
        if  iter > 1 && cf(iter) > cf(iter-1)
            alpha = alpha / 10;
        end
        if iter > 1 && abs(cf(iter)-cf(iter-1)) < 0.000000001 || iter == 100000
            isconverged =1;
        else
            df = ([ones(size(X,1),1) X] * theta') - Y;
            df3 = df * ones(1,size(X,2)+1);
            grad = sum(df3 .* [ones(size(X,1),1) X] ./ numel(Y));
            theta = theta - alpha.*grad;
       
            iter = iter + 1;
        end
end
model.theta = theta;