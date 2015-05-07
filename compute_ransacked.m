% similarity in if the premises is ransacked

ransacked=zeros(Ncrimes,Ncrimes);
f0=... ; % frequency of a premises being ransacked in the training data
f1=1-f0;

for i=1:Ncrimes
    if isnan(ransacked_data(i))
        ransacked(i,:)=zeros(1,h);
    else
        for j=(i+1):Ncrimes
            if isnan(ransacked_data(j))
                ransacked(i,j)=0;
            else
                if ransacked_data(i)==ransacked_data(j)
                    if ransacked_data(i)==0
                      ransacked(i,j)=1-f0^2;
                    else
                        ransacked(i,j)=1-f1^2;
                    end
                end
            end
        end
    end
end
