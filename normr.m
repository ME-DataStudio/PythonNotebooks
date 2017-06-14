function normdata = normr(data)

for i = 1:size(data,1)
   normdata(i,:) = data(i,:)./norm(data(i,:));
end