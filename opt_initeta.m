%matrix of eta
%input: t1,t2,h1,h2;
cc=sum(sampleC(h1:h2))*sum(sampleP(t1:t2));
eta=zeros(cc,13);
count=zeros(cc,13);
const=1/100;
ind=0;

for k=h1:h2
    if sampleC(k)
        for n=t1:t2
            if sampleP(n)
                ind=ind+1;
                list=find(patternnum(h1:h2)==pset(n,1));
                if patternnum(k)~=pset(n,1)|patternnum(k)==0
                    y=-1;
                    list=[(list+h1-1);k];
                    w=1;
                else
                    y=1;
                    w=100;
                    list=list+h1-1;
                end
                len=length(list);
                %---dynamic coefficient
                for i1=1:len
                    for i2=(i1+1):len
                        m=min(list(i1),list(i2));
                        l=max(list(i1),list(i2));
                        if HB_LocEntry_index(m,l)>0
                            eta(ind,1)=eta(ind,1)+LocEntry(m,l)^de;
                            count(ind,1)=count(ind,1)+1;
                        end
                        if HB_MnsEntry_index(m,l)>0
                            eta(ind,2)=eta(ind,2)+MnsEntry(m,l)^de;
                            count(ind,2)=count(ind,2)+1;
                        end
                        if HB_dayapart_index(m,l)>0
                            eta(ind,3)=eta(ind,3)+dayapart(m,l)^de;
                            count(ind,3)=count(ind,3)+1;
                        end
                        if ~isnan(HB_dis(m,l))&HB_dis(m,l)>0
                            eta(ind,4)=eta(ind,4)+HB_dis(m,l)^de;
                            %HB_dis(k,l)/mDis
                            count(ind,4)=count(ind,4)+1;
                        end
                        if HB_Injure_index(m,l)>0
                            eta(ind,5)=eta(ind,5)+Injure(m,l)^de;
                            count(ind,5)=count(ind,5)+1;
                        end
                        if HB_premises_index(m,l)>0
                            eta(ind,6)=eta(ind,6)+premises(m,l)^de;
                            count(ind,6)=count(ind,6)+1;
                        end
                        if HB_Ransacked_index(m,l)>0
                            eta(ind,7)=eta(ind,7)+ransacked(m,l)^(de);
                            count(ind,7)=count(ind,7)+1;
                        end
                        if HB_Residents_index(m,l)>0
                            eta(ind,8)=eta(ind,8)+residents(m,l)^de;
                            count(ind,8)=count(ind,8)+1;
                        end
                        if HB_timeframe_index(m,l)>0
                            eta(ind,9)=eta(ind,9)+HB_timeframe(m,l)^de;
                            count(ind,9)=count(ind,9)+1;
                        end
                        if HB_week_index(m,l)>0
                            eta(ind,10)=eta(ind,10)+dayweek(m,l)^de;
                            count(ind,10)=count(ind,10)+1;
                        end
                        eta(ind,11)=eta(ind,11)+seasonal(m,l)^de;
                        count(ind,11)=count(ind,11)+1;
                        if HB_SP_index(m,l)>0
                            eta(ind,12)=eta(ind,12)+suspect(m,l)^de;
                            count(ind,12)=count(ind,12)+1;
                        end
                        if HB_VI_index(m,l)>0
                            eta(ind,13)=eta(ind,13)+victim(m,l)^de;
                            count(ind,13)=count(ind,13)+1;
                        end
                    end
                end
                for kk=1:13
                    if count(ind,kk)==0%--missing information, assign const
                        eta(ind,kk)=const;
                    else
                        eta(ind,kk)=((const+eta(ind,kk))/count(ind,kk))^(1/de);
                    end
                end
                eta(ind,:)=eta(ind,:)/sum(eta(ind,:));
            end
        end
    end
end
% eta0=eta;
% m=mean(eta);
% eta=eta0./repmat(m,cc,1);