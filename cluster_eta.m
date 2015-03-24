%--cluster seed clusterEta
Nseries = ...
Nfeatures = ...
clusterEta=zeros(Nseries,Nfeatures);
clusterCount=zeros(Nseries,Nfeatures);
List_grid=zeros(Nseries,1000);
clusterScore=List_grid;
List_grid(:,1:3)=seed;
List_grid(:,end)=2*ones(Nseries,1);
eta=clusterEta;

for t=1:Nseries
    m=min(seed(t,2),seed(t,3));
    l=max(seed(t,2),seed(t,3));
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
        clusterCount(t,4)=clusterCount(t,4)+1;
    end
    if HB_premises_index(m,l)>0
        clusterEta(t,5)=clusterEta(t,5)+premises(m,l);
        clusterCount(t,5)=clusterCount(t,5)+1;
    end
    if HB_Ransacked_index(m,l)>0
        clusterEta(t,6)=clusterEta(t,6)+ransacked(m,l);
        clusterCount(t,6)=clusterCount(t,6)+1;
    end
    if HB_Residents_index(m,l)>0
        clusterEta(t,7)=clusterEta(t,7)+residents(m,l);
        clusterCount(t,7)=clusterCount(t,7)+1;
    end
    if HB_timeframe_index(m,l)>0
        clusterEta(t,8)=clusterEta(t,8)+HB_timeframe(m,l);
        clusterCount(t,8)=clusterCount(t,8)+1;
    end
    if HB_week_index(m,l)>0
        clusterEta(t,9)=clusterEta(t,9)+dayweek(m,l);
        clusterCount(t,9)=clusterCount(t,9)+1;
    end
    if HB_SP_index(m,l)>0
        clusterEta(t,10)=clusterEta(t,10)+suspect(m,l);
        clusterCount(t,10)=clusterCount(t,10)+1;
    end
    if HB_VI_index(m,l)>0
        clusterEta(t,11)=clusterEta(t,11)+victim(m,l);
        clusterCount(t,11)=clusterCount(t,11)+1;
    end
end