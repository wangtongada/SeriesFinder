%matrix of pattern_eta
%input: t1,t2,h1,h2;
%pattern_list=zeros(52,66);
pattern_eta=zeros(52,11);
clusterEta=zeros(52,11);
clusterCount=clusterEta;

%c=1/13;

%for n=520.03*
%pattern_list(n,1:pset(n,2))=find(patternnum==pset(n,1));
%len=pset(n,2);
len=length(list2);
%---dynamic coefficient
for i1=1:len
    for i2=(i1+1):len
        %m=min(newCrime,List_grid(t,k));
        %l=max(newCrime,List_grid(t,k));
        m=min(list2(i1),list2(i2));
        l=max(list2(i1),list2(i2));
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
            clusterEta(t,6)=clusterEta(t,6)+ransacked(m,l)^(de);
            clusterCount(t,6)=clusterCount(t,6)+1;
        end
        if HB_Residents_index(m,l)>0
            clusterEta(t,7)=clusterEta(t,7)+residents(m,l);
            clusterCount(t,7)=clusterCount(t,7)+1;
        end
        if HB_timeframe_index(m,l)>0
            clusterEta(t,8)=clusterEta(t,8)+timeframe(m,l);
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
    %end
    %pattern_eta(1,:)
    pattern_eta(n,:)=const+clusterEta(t,:)./(clusterCount(t,:)+logical(clusterCount(t,:)==0));
    pattern_eta(n,:)=pattern_eta(n,:)/sum(pattern_eta(n,:));
    %     for kk=1:11
    %         if pattern_count(n,kk)==0
    %             pattern_eta(n,kk)=c;
    %         else
    %             pattern_eta(n,kk)=c+pattern_eta(n,kk)/pattern_count(n,kk);
    %         end
    %     end
    %     %pattern_eta(1,:)
    %     pattern_eta(n,:)=pattern_eta(n,:)/sum(pattern_eta(n,:));
end

%%Initiate the score
% pattern_score=zeros(60^2,13,53);
% pattern_norm=zeros(60^2,13,53);


% for n=t1:t2
%     len=pset(n,2);
%     %---dynamic coefficient
%     for i1=1:len
%         for i2=(i1+1):len
%             m=min(pattern_list(n,i1),pattern_list(n,i2));
%             l=max(pattern_list(n,i1),pattern_list(n,i2));
%             pattern_score((i1-1)*len+i2,:,n)=pattern_eta(n,:).*[LocEntry(m,l).*HB_LocEntry_index(m,l),...
%                 MnsEntry(m,l).*HB_MnsEntry_index(m,l),dayapart(m,l).*HB_dayapart_index(m,l),...
%                 HB_dis(m,l),Injure(m,l).*HB_Injure_index(m,l),premises(m,l).*HB_premises_index(m,l),...
%                 ransacked(m,l).*HB_Ransacked_index(m,l),residents(m,l).*HB_Residents_index(m,l),...
%                 (~isnan(HB_timeframe(m,l)).*HB_timeframe_index(m,l)).*HB_timeframe(m,l),...
%                 dayweek(m,l).*HB_week_index(m,l),seasonal(m,l),(HB_SP_index(m,l)==1).*suspect(m,l),victim(m,l).*HB_VI_index(m,l)];
%
%             pattern_norm((i1-1)*len+i2,:,n)=pattern_eta(n,:).*[HB_LocEntry_index(m,l),HB_MnsEntry_index(m,l),HB_dayapart_index(m,l),1,...
%                 HB_Injure_index(m,l),HB_premises_index(m,l),HB_Ransacked_index(m,l),HB_Residents_index(m,l),...
%                 (~isnan(HB_timeframe(m,l)).*HB_timeframe_index(m,l)),HB_week_index(m,l),1,(~isnan(HB_SP_index(m,l)).*HB_SP_index(m,l)),HB_VI_index(m,l)];
%             pattern_score((i2-1)*len+i1,:,n)=pattern_score((i1-1)*len+i2,:,n);
%             pattern_norm((i2-1)*len+i1,:,n)=pattern_norm((i1-1)*len+i2,:,n);
%
%         end
%     end
% end
