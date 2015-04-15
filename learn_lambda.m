results=[];
ds=3;
gloss=0;
xinit = rand(1,Nfeatures)
xinit = xinit./sum(xinit)
steps = 0.1:0.1:10;
gtable=zeros(Nfeatures,length(steps));
Nseries = ...
trainSeries = ...
itr=1;
maxIter = ... % maximum number of steps

while itr==1|result(itr)-result(itr-1)>0.01 & itr < maxIter
    for j=1:Nfeatures
        xr=xinit;
        for r=1:length(steps)
            xx=xr;
            gtemp=0;
            xx(j)=steps(r)*xr(j);
            xx=xx./sum(xx);
            recall=0;
            precision=0;
            % initialize eta
            seriesEta = zeros(Nseries,Nfeatures);
            growlist = zeros(Nseries,block);
            growlist(:,1:2)=seed;
            growlist(:,end)=2*ones(Nseries,1);
            tempEta = zeros(Nseries,Nfeatures);
            Cohesion = zeros(Nseries,Nfeatures);
            for t=1:Nseries
                % initialize eta
                m=min(seed(t,1),seed(t,1));
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
                %grow a crime pattern from the given seed
                %seed(t,1:2) contains the seed of a pattern
                while growlist(t,Maxlen)<Maxlen 
                    % calculate the new eta
                    tempEta(t,:)=2*seriesEta(t,:)./growlist(t,Maxlen)/(growlist(t,Maxlen)-1);
                    % start growing the set
                    maxSim=0;
                    for h=1:Ncrimes %choose the most similar crime for the current series t
                        if ~ismember(h,growlist(t,:)
                            v1=min(growlist(t,1:growlist(t,Maxlen)),h);
                            v2=max(growlist(t,1:growlist(t,Maxlen)),h);
                            v=(v2-1).*Ncrimes+v1;
                            lv=length(v);
                            s=[LocEntry(v).*HB_LocEntry_index(v);MnsEntry(v).*HB_MnsEntry_index(v);dayapart(v).*HB_dayapart_index(v);...
                                HB_dis(v);premises(v).*HB_premises_index(v);ransacked(v).*HB_Ransacked_index(v);...
                                residents(v).*HB_Residents_index(v);(~isnan(timeframe(v)).*HB_timeframe_index(v)).*timeframe(v);...
                                dayweek(v).*HB_week_index(v);HB_SP_index(v).*suspect(v);victim(v).*HB_VI_index(v)];
                            eta_mat=repmat(tempEta(t,:)',1,lv);
                            lambda_mat=repmat(x',1,lv);
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
                precision=precision+(length(intersect(trainSeries(t,:),growlist(t,1:(Maxlen-1))))-2)/(growlist(t,Maxlen)-2);
                recall=recall+(length(intersect(trainSeries(t,:),growlist(t,1:(Maxlen-1))))-2)/(growlist(t,Maxlen)-2);
                gtable(j,r)=gtable(j,r)+precision + beta * recall;
            end
            if gtable(j,r)>gloss
                rtemp=r;
                xtemp=xx;
                gloss=gtable(j,r);
            end
        end
        result(itr)=gloss;
        itr=itr+1;
    end
end