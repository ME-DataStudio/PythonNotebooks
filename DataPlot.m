function DataPlot
    %load data from file
    path = 'C:\Users\enuma\Desktop\Data Science opleiding\8 - Predictive analytics\Assignment\';
    file = strcat(path,'krkoptNum.txt');
    KRK = csvread(file);

    %split data in data and label/class
    %KRK=datasample(KRK,1000); %take sample for debugging purposes
    KRKlabel = KRK(:,end);
    %Kdata=horzcat(KRK(:,1:2),KRKlabel);
    %Rdata=KRK(:,3:4);
    %KBdata=KRK(:,5:6);
    
    Kdata=(KRK(:,1)-1)*8+KRK(:,2);
    Rdata=(KRK(:,3)-1)*8+KRK(:,4);
    KBdata=(KRK(:,5)-1)*8+KRK(:,6);
    
    KRKdata=horzcat(Kdata,Rdata,KBdata,KRKlabel);
    %classdistr=[];
    %for j = 1:18
    %    classdistr(j) = sum(KRKlabel == (j-1));
    %end
    %figure;
    %bar(classdistr);
    %bar3(Kdata);
    
end