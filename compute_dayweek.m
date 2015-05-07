% compute the similarity in day of week

dayweek=zeros(Ncrimes,Ncrimes);

% if both are weekday or weekends, 1, if one of them is early week, 1, if one of them is late week, 0.8
% if the weekday/weekend type is unknown, this feature is not included in the summation
weekday={'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday','Weekend','Weekend Unknown','Early Week','Late Week'};
% the above categories are from the training data 

for i=1:Ncrimes
    d1=zeros(1,2);
    if isempty(strmatch(dayweek_data(i),weekday,'exact'))
        dayweek(i,:)=zeros(1,h);
        dayweek_index(i,:)=zeros(1,h);% 0 means no information
    else
        index1=strmatch(dayweek_data(i),weekday,'exact');
        if index1<6
            d1(1)=1;% 1 indicates weekday
            if index1<4
                d1(2)=1;% 1 indicates early week
            else d1(2)=2;
            end
        elseif index1>5 & index1<10
            d1(1)=2;% 2 indicates Weekend
            d1(2)=2;% 2 indicates Late Week
        elseif index1==10
            d1(2)=1;%Early Week
        elseif index1==11
            d1(2)=2;%Late Week
        else error('error i');
        end
        for j=(i+1):Ncrimes
            if isempty(strmatch(dayweek_data(j),weekday,'exact'))
                dayweek(i,j)=0;
                dayweek_index(i,j)=0;
            else
                index2=strmatch(dayweek_data(j),weekday,'exact');
                if index2<6
                    d2(1)=1;% 1 indicates weekday
                    if index2<4
                        d2(2)=1;% 1 indicates early week
                    else d2(2)=2;
                    end
                elseif index2>5 & index2<10
                    d2(1)=2;% 2 indicates Weekend
                    d2(2)=2;% 2 indicates Late Week
                elseif index2==10
                    d2(2)=1;
                elseif index2==11
                    d2(2)=2;
                else index2 
                    error('error j');
                end
                % compare the weekday weekend type
                if d1(1)==d2(1) & d1(1)*d2(1)
                    dayweek(i,j)=1;
                elseif d1(1)*d2(1)==0 & d1(2)==d2(2)
                    if d1(2)==1
                        dayweek(i,j)=1;
                    elseif d1(2)==2
                        dayweek(i,j)=0.8;
                    else error('error compare');
                    end
                else dayweek(i,j)=0;
                end
            end
        end
    end
end
