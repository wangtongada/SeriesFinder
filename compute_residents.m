% similarity in if residents are at home when the housebreak happens

residents=zeros(Ncrimes,Ncrimes);
f0=... ; % frequency of residents not in the house
f1=1-f0;

for i=1:Ncrimes
    if isnan(residents_data(i))
        residents(i,:)=zeros(1,h);
    else
        for j=(i+1):h
        if isnan(residents_data(j))
            residents(i,j)=0;
        else
            if residents_data(i)==residents_data(j)
                if residents_data(i)==0
                    residents(i,j)=1-f0^2;
                else
                    residents(i,j)=1-f1^2;
                end
            end
        end
    end
end
