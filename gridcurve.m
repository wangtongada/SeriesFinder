%x=[2.4932,1.9858,4,9,1.39,1.35,1.39,0.695,1.39,1.39,1.9161];
%x(8)*0.7->x=[2.4932,1.9858,4,9,1.39,1.35,1.39,0.4865,1.39,1.39,1.9161];gridloss2
%x(2)*0.7->x=[2.4932,1.3901,4,9,1.39,1.35,1.39,0.4865,1.39,1.39,1.9161];gridloss3
%x(6)*0.85->x=[2.4932,1.3901,4,9,1.39,1.1475,1.39,0.4865,1.39,1.39,1.9161];gridloss4
%x(6)*0.7->x=[2.4932,1.3901,4,9,1.39,0.8032,1.39,0.4865,1.39,1.39,1.9161];gridloss5
ratio=0.6:0.05:1.4;
lr=length(ratio);
gridloss6=zeros(11,lr);
for j=1:11
    j
    for r=1:lr;
        r
        cluster_eta;
        x=[2.4932,1.3901,4,9,1.39,0.8032,1.39,0.4865,1.39,1.39,1.9161];
        x(j)=x(j)*ratio(r);
        x=x./sum(x);
        for t=2:52
            if tset(t)
                %count=count+1;
                %choose crimes from h1 to h2, to grow a crime pattern from the given seed
                %seed(t,2:3) contains the seed of a pattern
                patternt=find(patternnum==pset(t,1));
                while List_grid(t,1000)<pset(t,2)*3
                    % calculate the new eta
                    eta(t,:)=const+clusterEta(t,:)./(clusterCount(t,:)+logical(clusterCount(t,:)==0));
                    eta(t,:)=eta(t,:)/sum(eta(t,:));
                    % start growing the set
                    tempScore=0;
                    for h=hset(t,1):hset(t,2)%choose the most similar crime for the current cluster
                        if h_index(h)&~ismember(h,List_grid(t,2:(List_grid(t,1000)+1)))
                            v1=min(List_grid(t,2:(List_grid(t,1000)+1)),h);
                            v2=max(List_grid(t,2:(List_grid(t,1000)+1)),h);
                            v=(v2-1).*7067+v1;
                            lv=length(v);
                            s=[LocEntry(v).*HB_LocEntry_index(v);MnsEntry(v).*HB_MnsEntry_index(v);dayapart(v).*HB_dayapart_index(v);...
                                HB_dis(v);premises(v).*HB_premises_index(v);ransacked(v).*HB_Ransacked_index(v);...
                                residents(v).*HB_Residents_index(v);(~isnan(timeframe(v)).*HB_timeframe_index(v)).*timeframe(v);...
                                dayweek(v).*HB_week_index(v);HB_SP_index(v).*suspect(v);victim(v).*HB_VI_index(v)];
                            lambda=repmat(eta(t,:)',1,lv);
                            xmat=repmat(x',1,lv);
                            newScore=mean(sum((s.*lambda.*xmat).^ds).^(1/ds));
                            if newScore>tempScore
                                newCrime=h;
                                tempScore=newScore;
                            end
                        end
                    end
                    % the updated cluster is a valid cluster
                    % add in the new crime
                    List_grid(t,1000)=List_grid(t,1000)+1;
                    len=List_grid(t,1000);
                    clusterScore(t,List_grid(t,1000)+1)=tempScore;
                    List_grid(t,List_grid(t,1000)+1)=newCrime;
                    %List_grid(t,2:(List_grid(t,1000)+1))
                    % update the eta and count
                    for k=2:len
                        m=min(newCrime,List_grid(t,k));
                        l=max(newCrime,List_grid(t,k));
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
                    %List_grid(t,1:(List_grid(t,1000)+1))
                    if length(intersect(patternt,List_grid(t,2:999)))==pset(t,2)
                        break;
                    end
                end
                TM_precision=(length(intersect(patternt,List_grid(t,2:end)))-2)/(List_grid(t,1000)-2);
                TM_recall=(length(intersect(patternt,List_grid(t,2:end)))-2)/(pset(t,2)-2);
                %closs=closs+TM_precision*1.5+TM_recall;
                gridloss6(j,r)=gridloss6(j,r)+TM_precision*1.5+TM_recall;
            end
        end
        
    end
    gridloss6
    %save('grid.mat','gridloss2','-append');
end


