%% parameters
Nfeatures = 11    % the number of features used to detec series. In our dataset, there are 11 features
Ncrimes = ...     % the number of all crimes from which we want to discover series. 
Nseries = ...     % the number of series we want to discover
cutoff =...       % the cutoff for cohesion of a series where if the cohesion is below the cutoff, the series stops growing
for i=1:Nseries   % the seed crimes to grow a series with, they need to be provided by users
    seed(i,:)=[...,...];   
end
Maxlen = ...      % the maximum number of crime that can be discovered in a series
lambda = ...      % this is the output of file learn_lambda.m
ds = 1.5 

% initialize eta
seriesEta = zeros(Nseries,Nfeatures);
for t=1:Nseries
    m=min(seed(t,1),seed(t,2));
    l=max(seed(t,1),seed(t,2));
    seriesEta(t,1)=LocEntry(m,l);
    seriesEta(t,2)=MnsEntry(m,l);
    seriesEta(t,3)=dayapart(m,l);
    seriesEta(t,4)=HB_dis(m,l);
    seriesEta(t,5)=premises(m,l);
    seriesEta(t,6)=ransacked(m,l);
    seriesEta(t,7)=residents(m,l);
    seriesEta(t,8)=HB_timeframe(m,l);
    seriesEta(t,9)=dayweek(m,l);
    seriesEta(t,10)=suspect(m,l);
    seriesEta(t,11)=victim(m,l);
end

% initialize a list with seed crimes
growlist = zeros(Nseries,Maxlen);
growlist(:,1:2)=seed;
growlist(:,end)=2*ones(Nseries,1);
tempEta = zeros(Nseries,Nfeatures);
Cohesion = zeros(Nseries,Nfeatures);

for t=1:Nseries
    %choose crimes grow a crime pattern from the given seed
    %seed(t,1:2) contains the seed of a pattern
    while growlist(t,Maxlen)<Maxlen 
        % calculate the new eta
        tempEta(t,:)=2*seriesEta(t,:)./growlist(t,Maxlen)/(growlist(t,Maxlen)-1);
        % start growing the set
        for h=1:Ncrimes %choose the most similar crime for the current series t
            if ~ismember(h,growlist(t,:))
                v1=min(growlist(t,1:growlist(t,Maxlen)),h);
                v2=max(growlist(t,1:growlist(t,Maxlen)),h);
                v=(v2-1).*Ncrimes+v1;
                lv=length(v);
                s=[LocEntry(v);MnsEntry(v);dayapart(v);HB_dis(v);premises(v);ransacked(v);...
                    residents(v);timeframe(v);dayweek(v);suspect(v);victim(v)];
                eta_mat=repmat(tempEta(t,:)',1,lv);
                lambda_mat=repmat(lambda',1,lv);
                Gamma = sum(tempEta.*x)
                tempSim=sum((s.*lambda_mat.*eta_mat./Gamma).^ds./growlist(t,Maxlen)).^(1/ds);
                if tempSim>maxSim
                    newCrime=h;
                    maxSim=tempSim;
                end
            end
        end
        growlist(t,Maxlen)=growlist(t,Maxlen)+1; % growlist(t,Maxlen) contains the number of crimes in series t
        growlist(t,growlist(t,Maxlen))=newCrime;
        Cohesion(t,growlist(t,Maxlen))=  Cohesion(t,growlist(t,Maxlen)) + maxSim;
        if Cohesion(t,growlist(t,Maxlen))/growlist(t,Maxlen) < cutoff
            break
        end

        %update the eta 
        for k=1:(growlist(t,Maxlen)-1)
            m=min(newCrime,growlist(t,k));
            l=max(newCrime,growlist(t,k));
            seriesEta(t,1)=seriesEta(t,1)+LocEntry(m,l);
            seriesEta(t,2)=seriesEta(t,2)+MnsEntry(m,l);
            seriesEta(t,3)=seriesEta(t,3)+dayapart(m,l);
            seriesEta(t,4)=seriesEta(t,4)+HB_dis(m,l);                    
            seriesEta(t,5)=seriesEta(t,5)+premises(m,l);
            seriesEta(t,6)=seriesEta(t,6)+ransacked(m,l);
            seriesEta(t,7)=seriesEta(t,7)+residents(m,l);
            seriesEta(t,8)=seriesEta(t,8)+timeframe(m,l);
            seriesEta(t,9)=seriesEta(t,9)+dayweek(m,l);
            seriesEta(t,10)=seriesEta(t,10)+suspect(m,l);
            seriesEta(t,11)=seriesEta(t,11)+victim(m,l);
        end
    end
end
