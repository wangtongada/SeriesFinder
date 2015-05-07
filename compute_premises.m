% % compute similarities in premises

categories={'Accounting Firm',
    'Apartment',
    'Apartment Basement',
    'Apartment Hallway',
    'Assisted Living',
    'Church',
    'Cinema',
    'Commercial Unknown',
    'Condominium',
    'Construction Site',
    'Dormitory',
    'Driveway',
    'Garage',
    'Halfway House',
    'Hotel/Motel',
    'House',
    'Medical Building',
    'Nursing Home',
    'Office Park',
    'Other Retail',
    'Parking Garage',
    'Parking Lot',
    'Porch',
    'Recreation Center',
    'Research',
    'School',
    'Shelter',
    'Single-Family House',
    'Storage',
    'Street',
    'Two-Family House',
    'University',
    'YMCA',
    'Yard'};

% %     '1--Accounting Firm'
% %     '2--Apartment'
% %     '3--Apartment Basement'
% %     '4--Apartment Hallway'
% %     '5--Assisted Living'
% %     '6--Church'
% %     '7--Cinema'
% %     '8--Commercial Unknown'
% %     '9--Condominium'
% %     '10--Construction Site'
% %     '11--Dormitory'
% %     '12--Driveway'
% %     '13--Garage'
% %     '14--Halfway House'
% %     '15--Hotel/Motel'
% %     '16--House'
% %     '17--Medical Building'
% %     '18--Nursing Home'
% %     '19--Office Park'
% %     '20--Other Retail'
% %     '21--Parking Garage'
% %     '22--Parking Lot'
% %     '23--Porch'
% %     '24--Recreation Center'
% %     '25--Research'
% %     '26--School'
% %     '27--Shelter'
% %     '28--Single-Family House'
% %     '29--Storage'
% %     '30--Street'
% %     '31--Two-Family House'
% %     '32--University'
% %     '33--YMCA'
% %     '34--Yard'
f1 = [...] % frequencies of above categories in the training data
index=zeros(34,3);
for k=1:34
    index(k,:)=PremisesIndex(categories(k));
end
f2=zeros(1,25);
for j=1:34
    f2(index(j,2))=f2(index(j,2))+f1(index(j,3));%1st stage grouping
end
f3=zeros(1,21);
for l=1:34
    f3(index(l,1))=f3(index(l,1))+f1(index(l,3));%2nd stage grouping
end
premises=zeros(Ncrimes,Ncrimes);
for i=1:Ncrimes
    h1=strmatch(premises(i),categories,'exact');
    if isempty(h1)
        premises(i,:)=zeros(1,h);
        premises(i,:)=zeros(1,h);
    else
        for j=(i+1):Ncrimes
            h2=strmatch(premises(j),categories,'exact');
            if isempty(h2)
                premises(i,j)=0;
                premises(i,j)=0;
            else
                h1=PremisesIndex(premises(i));
                h2=PremisesIndex(premises(j));
                if h1(1)*h2(1)==0
                    disp('-------error-------');
                    break;
                else
                    if h1(3)==h2(3)
                        premises(i,j)=1-f1(h1(3))^2;
                    elseif h1(2)==h2(2)
                        premises(i,j)=1-f2(h1(2))^2;
                    elseif h1(1)==h2(1)
                        premises(i,j)=1-f3(h1(1))^2;
                    else premises(i,j)=0;
                    end
                end
            end
        end
    end
end

                        