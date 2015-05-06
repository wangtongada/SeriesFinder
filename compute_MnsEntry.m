% similarity in means of entry

categories={'(null)',
    'Broke',
    'Broke Glass',
    'Broke door lock',
    'Cut',
    'Cut Screen',
    'Key',
    'NA',
    'Open Area',
    'Picked Lock',
    'Pried',
    'Punched/Popped Lock',
    'Removed',
    'Sawed/Drilled',
    'Shoved/Forced',
    'Unknown',
    'Unlocked',
    'unknown',
    '<undefined>'};
% categories = 
%     '1--(null)'
%     '2--Broke'
%     '3--Broke Glass'
%     '4--Broke door lock'
%     '5--Cut'
%     '6--Cut Screen'
%     '7--Key'
%     '8--NA'
%     '9--Open Area'
%     '10--Picked Lock'
%     '11--Pried'
%     '12--Punched/Popped Lock'
%     '13--Removed'
%     '14--Sawed/Drilled'
%     '15--Shoved/Forced'
%     '16--Unknown'
%     '17--Unlocked'
%     '18--unknown'
%     '19--<undefined>'
Ncategories = length(categories)
f=[...]    % frequency of each category in the training data
f=f/sum(f);
MnsEntry=zeros(Ncrimes,Ncrimes);

for i=1:Ncrimes
    h1=strmatch(cell2mat(MnsEntry_data(i)),categories,'exact');
    if h1==1|h1==8|h1==16|h1==18|h1==19
        MnsEntry(i,:)=zeros(1,h);
    else
        for j=(i+1):h
            h2=strmatch(cell2mat(MnsEntry_data(j)),categories,'exact');
            if h2==1|h2==8|h2==16|h2==18|h2==19
            MnsEntry(i,j)=0;
            else
                if h1==h2 &h1~=1&h1~=8&h1~=16&h1~=18&h1~=19
                    MnsEntry(i,j)=1-f(h1)^2;
                else
                    if h1>=2&h1<=4 & h2>=2&h2<=4
                        MnsEntry(i,j)=1-sum(f(2:4))^2;
                    elseif h1==6&h2==5 |h1==5&h2==6
                        MnsEntry(i,j)=1-(f(5)+f(6))^2;
                    elseif h1==11&h2==10|h1==10&h2==11
                        MnsEntry(i,j)=1-(f(10)+f(11))^2;
                    end
                end
            end
        end
    end
end
