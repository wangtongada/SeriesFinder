% compute similarity in day
dayapart=zeros(Ncrmies,Ncrimes);
lamda=90; % this number can be customized

for i=1:Ncrimes
    di=datenum(date_data(i,:));
    for j=(i+1):Ncrimes
        dj=datenum(date_data(j,4:6));
        dayapart(i,j)=exp(-abs(di-dj)/lamda);
    end
end
