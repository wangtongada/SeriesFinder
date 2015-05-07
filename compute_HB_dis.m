% compute the similarity in geographic locations
% geo_coordinate contains the longitutde and latitude of each crime.

HB_dis=zeros(Ncrimes,Ncrimes);
d = 0.2
for i=1:Ncrimes
    for j=(i+1):Ncrimes
        HB_dis(i,j)=exp(-distdim(distance('gc',geo_coordinate(i,:),geo_coordinate(j,:)),'deg','km')/d);
    end
end
