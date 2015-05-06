% similarity in location of entry

categories ={'(null)','Basement','Door: Basement','Door: Front','Door: Rear',...
    'Door: Side','Door: Sliding Glass','Door: Unknown','NA','Roof',...
    'Skylight','Unknown','Wall','Window: Basement','Window: Fire Escape',...
    'Window: Front','Window: Ground','Window: Ladder','Window: Rear',...
    'Window: Side','Window: Skylight','Window: Unknown'}; % contains all categories for this attribute

Ncategories = length(categories)
f=[...]    % frequency of each category in the training data
f=f/sum(f);
LocEntry=zeros(Ncrimes,Ncrimes);

%     '1--(null)'
%     '2--Basement'
%     '3--Door: Basement'
%     '4--Door: Front'
%     '5--Door: Rear'
%     '6--Door: Side'
%     '7--Door: Sliding Glass'
%     '8--Door: Unknown'
%     '9--NA'
%     '10--Roof'
%     '11--Skylight'
%     '12--Unknown'
%     '13--Wall'
%     '14--Window: Basement'
%     '15--Window: Fire Escape'
%     '16--Window: Front'
%     '17--Window: Ground'
%     '18--Window: Ladder'
%     '19--Window: Rear'
%     '20--Window: Side'
%     '21--Window: Skylight'
%     '22--Window: Unknown'


for i=1:Ncrimes
    h1=strmatch(cell2mat(LocEntry_data(i)),categories,'exact');
    if h1==1|h1==9|h1==12
        LocEntry(i,:)=zeros(1,h);
    else
        for j=(i+1):h
            h2=strmatch(cell2mat(LocEntry_data(j)),categories,'exact');
            if h2==1|h2==9|h2==12
            LocEntry(i,j)=0;
            else
                if h1==h2 &h1~=1&h1~=9&h1~=12
                    LocEntry(i,j)=1-f(h1)^2;
                else
                    if h1>=3&h1<=8&h2>=3&h2<=8
                        LocEntry(i,j)=1-sum(f(3:8))^2;
                    elseif h1>=14&h1<=22&h2>=14&h2<=22
                        LocEntry(i,j)=1-sum(f(14:22))^2;
                    end
                    if (h1==2|h1==3|h1==14)&(h2==2|h2==3|h2==14)
                        LocEntry(i,j)=1-(f(2)+f(3)+f(14))^2;
                    end
                    if (h1==11|h1==21) & (h2==11|h2==21)
                        LocEntry(i,j)=1-(f(11)+f(21))^2;
                    end
                end
            end
        end
    end
end
