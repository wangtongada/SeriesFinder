%test
tic;
cluster_eta;
closs=0;
tloss=0;
for t=1:Nseries
    t
    %choose crimes from h1 to h2, to grow a crime pattern from the given seed
    %seed(t,2:3) contains the seed of a pattern
    tempScore=1;
    len=0;
    while tempScore>x(14)&len<50
        % calculate the new eta
        %clusterEta(t,:);
        %clusterCount(t,:);
        len=clusterList(t,80);
        eta(t,:)=(const+clusterEta(t,:)./(clusterCount(t,:)+logical(clusterCount(t,:)==0))).^(1/de);
        eta(t,:)=eta(t,:)/sum(eta(t,:));
        % start growing the set
        tempScore=0;
        for h=hset(t,1):hset(t,2)%choose the most similar crime for the current cluster
            if h_index(h)&~ismember(h,clusterList(t,2:(clusterList(t,80)+1)))
                %h
                v1=min(clusterList(t,2:(clusterList(t,80)+1)),h);
                v2=max(clusterList(t,2:(clusterList(t,80)+1)),h);
                v=(v2-1).*7067+v1;
                s=[LocEntry(v).*HB_LocEntry_index(v);MnsEntry(v).*HB_MnsEntry_index(v);dayapart(v).*HB_dayapart_index(v);...
                    HB_dis(v);Injure(v).*HB_Injure_index(v);premises(v).*HB_premises_index(v);ransacked(v).*HB_Ransacked_index(v);...
                    residents(v).*HB_Residents_index(v);(~isnan(timeframe(v)).*HB_timeframe_index(v)).*timeframe(v);...
                    dayweek(v).*HB_week_index(v);seasonal(v);HB_SP_index(v).*suspect(v);victim(v).*HB_VI_index(v)];
                s_avg=(sum((s.^ds)')/clusterList(t,80)).^(1/ds);
                newScore=sum(eta(t,:).*x(1:13).*s_avg);
                norm=sum(eta(t,:).*x(1:13).*[sum(HB_LocEntry_index(v));sum(HB_MnsEntry_index(v));sum(HB_dayapart_index(v));len;...
                    sum(HB_Injure_index(v));sum(HB_premises_index(v));sum(HB_Ransacked_index(v));sum(HB_Residents_index(v));...
                    sum(HB_timeframe_index(v));sum(HB_week_index(v));len;sum((~isnan(HB_SP_index(v)).*HB_SP_index(v)));sum(HB_VI_index(v))]'./len);
                newScore=newScore/norm;
                if newScore>tempScore
                    newCrime=h;
                    tempScore=newScore;
                end
            end
        end
        if tempScore>x(14) % the updated cluster is a valid cluster
            % add in the new crime
            clusterList(t,80)=clusterList(t,80)+1;
            clusterScore(t,clusterList(t,80)+1)=tempScore;
            clusterList(t,clusterList(t,80)+1)=newCrime;
            % update the eta and count
            for k=2:(len+1)
                m=min(newCrime,clusterList(k));
                l=max(newCrime,clusterList(k));
                if HB_LocEntry_index(m,l)>0
                    clusterEta(t,1)=clusterEta(t,1)+LocEntry(m,l);
                    clusterCount(t,1)=clusterCount(t,1)+1;
                end
                if HB_MnsEntry_index(m,l)>0
                    clusterEta(t,2)=clusterEta(t,2)+MnsEntry(m,l);
                    clusterCount(t,2)=clusterCount(t,2)+1;
                end
                if HB_dayapart_index(m,l)>0
                    clusterEta(t,3)=clusterEta(t,3)+dayapart(m,l);
                    clusterCount(t,3)=clusterCount(t,3)+1;
                end
                if ~isnan(HB_dis(m,l))&HB_dis(m,l)>0
                    clusterEta(t,4)=clusterEta(t,4)+HB_dis(m,l);
                    %HB_dis(k,l)/mDis
                    clusterCount(t,4)=clusterCount(t,4)+1;
                end
                if HB_Injure_index(m,l)>0
                    clusterEta(t,5)=clusterEta(t,5)+Injure(m,l);
                    clusterCount(t,5)=clusterCount(t,5)+1;
                end
                if HB_premises_index(m,l)>0
                    clusterEta(t,6)=clusterEta(t,6)+premises(m,l);
                    clusterCount(t,6)=clusterCount(t,6)+1;
                end
                if HB_Ransacked_index(m,l)>0
                    clusterEta(t,7)=clusterEta(t,7)+ransacked(m,l)^(de);
                    clusterCount(t,7)=clusterCount(t,7)+1;
                end
                if HB_Residents_index(m,l)>0
                    clusterEta(t,8)=clusterEta(t,8)+residents(m,l);
                    clusterCount(t,8)=clusterCount(t,8)+1;
                end
                if HB_timeframe_index(m,l)>0
                    clusterEta(t,9)=clusterEta(t,9)+timeframe(m,l);
                    clusterCount(t,9)=clusterCount(t,9)+1;
                end
                if HB_week_index(m,l)>0
                    clusterEta(t,10)=clusterEta(t,10)+dayweek(m,l);
                    clusterCount(t,10)=clusterCount(t,10)+1;
                end
                clusterEta(t,11)=clusterEta(t,11)+seasonal(m,l);
                clusterCount(t,11)=clusterCount(t,11)+1;
                if HB_SP_index(m,l)>0
                    clusterEta(t,12)=clusterEta(t,12)+suspect(m,l);
                    clusterCount(t,12)=clusterCount(t,12)+1;
                end
                if HB_VI_index(m,l)>0
                    clusterEta(t,13)=clusterEta(t,13)+victim(m,l);
                    clusterCount(t,13)=clusterCount(t,13)+1;
                end
            end
        end
    end
    patternt=find(patternnum==pset(t,1));
    tloss=tloss+5*length(setdiff(patternt,clusterList(t,2:(clusterList(t,end)+1))))+length(setdiff(clusterList(t,2:(clusterList(t,end)+1)),patternt))

    closs=closs+length(setdiff(patternt,clusterList(t,2:(clusterList(t,end)+1))))%+length(setdiff(clusterList(t,2:(clusterList(t,end)+1)),patternt));
    
    x(14)=0.68*clusterScore(t,4);
end
elapsed=toc;