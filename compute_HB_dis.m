% compute the similarity in geographic locations
% data geocode contains the longitutde and latitude of each crime.

HB_dis=zeros(Ncrimes,Ncrimes);
for i=1:Ncrimes
    for j=(i+1):Ncrimes
        HB_dis(i,j)=distdim(distance(geocode(i,1),geocode(i,2),geocode(j,1),geocode(j,2)),'deg','kilometers');
    end
end
