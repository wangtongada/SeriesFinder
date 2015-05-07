suspect=zeros(Ncrimes,Ncrimes);
SP=zeros(Ncrimes,14,3);
lambda=[5,0,3,2,3,5,4]';
Nsubfeature = 14;
for i=1:Ncrimes %crime incident #1
    index=0;
    for j=0:13 %incident #1 structure index
        %compare the suspect
        index=index+1;
        if strcmpi(cell2mat(suspect_data(i,2+j*16)),'M')
            SP(i,index,1)=1;%sp1('M','F',index);
        elseif strcmpi(cell2mat(suspect_data(i,2+j*16)),'F')
            SP(i,index,2)=1;%sp1('M','F',index);
        end
        SP(i,index,3)=j;
    end
end

for i1=2:Ncrimes
    for i2=(i1+1):Ncrimes %crime incident #2
        count=zeros(14,1);
        kk=0;
        for j1=1:(sum(SP(i1,:,1))+sum(SP(i1,:,2)))
            count1=zeros(14,1);
            k1=0;
            for j2=1:(sum(SP(i2,:,1))+sum(SP(i2,:,2)))
                if SP(i1,j1,1)==SP(i2,j2,1)&SP(i1,j1,2)==SP(i2,j2,2)
                    %compare the offender
                    feature=zeros(1,7);
                    feature_index=ones(1,7);
                    %feature 1:race
                    if strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'(null)')|strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'NA')|...
                            strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'Unknown')|strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'(null)')...
                            |strcmpi(suspect_data(i2,3+SP(i2,j2,3)*16),'NA')|strcmpi(suspect_data(i2,3+SP(i2,j2,3)*16),'Unknown')...
                            strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'Other')&strcmpi(suspect_data(i2,3+SP(i2,j2,3)*16),'Other')
                        feature_index(1)=0;
                    elseif strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),suspect_data(i2,3+SP(i2,j2,3)*16))
                        feature(1)=1;
                    elseif (strncmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'Mid',3)&strncmpi(suspect_data(i2,3+SP(i2,j2,3)*16),'Mid',3))
                        feature(1)=1;
                    elseif (strncmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'Asian',5)&strncmpi(suspect_data(i2,3+SP(i2,j2,3)*16),'Asian',5))
                        feature(1)=1;
                    elseif (strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'white')&(strcmpi(suspect_data(i2,3+SP(i2,j2,3)*16),'hispanic')|...
                            strcmpi(suspect_data(i2,3+SP(i2,j2,3)*16),'Native American')|strcmpi(suspect_data(i2,3+SP(i2,j2,3)*16),'Carribean')))|...
                            (strcmpi(suspect_data(i2,3+SP(i2,j2,3)*16),'white')&(strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'hispanic')|...
                            strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'Native American')|strcmpi(suspect_data(i1,3+SP(i1,j1,3)*16),'Carribean')))
                        feature(1)=1;
                    else
                        feature_index(1)=-1;%-1 means the two person cannot be the same guy
                    end
                    %feature 2:dob
                    try
                        dob1=datenum(num(i1,4+SP(i1,j1,3)*16));
                        dob2=datenum(num(i2,4+SP(i2,j2,3)*16));
                        if dob1==dob2
                            feature(2)=10;
                        else feature_index(2)==-1;
                        end
                    catch
                        feature_index(2)=0;
                    end
                    
                    %feature 3:height
                    if Height(i1,SP(i1,j1,3)+1)==0|Height(i2,SP(i2,j2,3)+1)==0
                        feature_index(3)=0;
                    else
                        if abs(Height(i1,SP(i1,j1,3)+1)-Height(i1,SP(i2,j2,3)+1))/max(Height(i1,SP(i1,j1,3)+1),Height(i1,SP(i2,j2,3)+1))<=0.05
                           feature(3)=1;
                        else feature_index(3)=-1;
                        end
                    end
                    %feature 4:weight
                    if Weight(i1,SP(i1,j1,3)+1)==0|Weight(i2,SP(i2,j2,3)+1)==0
                        feature_index(3)=0;
                    else
                        if abs(Weight(i1,SP(i1,j1,3)+1)-Weight(i1,SP(i2,j2,3)+1))/max(Weight(i1,SP(i1,j1,3)+1),Weight(i1,SP(i2,j2,3)+1))<0.25
                            feature(4)=1;
                        else feature_index(4)=-1;
                        end
                    end
                    %feature 5:hair color
                    if strcmpi(suspect_data(i1,8+SP(i1,j1,3)*16),'(null)')|~strcmpi(suspect_data(i2,8+SP(i2,j2,3)*16),'(null)')...
                            |strcmpi(suspect_data(i1,8+SP(i1,j1,3)*16),'NA')|strcmpi(suspect_data(i2,8+SP(i2,j2,3)*16),'NA')...
                            |strcmpi(suspect_data(i1,8+SP(i1,j1,3)*16),'UNKNOWN')|strcmpi(suspect_data(i2,8+SP(i2,j2,3)*16),'UNKNOWN')...
                            feature_index(5)=0;
                    else
                            if strcmpi(suspect_data(i1,8+SP(i1,j1,3)*16),suspect_data(i2,8+SP(i2,j2,3)*16))
                                feature(5)=1;
                            elseif strncmpi(suspect_data(i1,8+SP(i1,j1,3)*16),'Gray',4)&strncmpi(suspect_data(i2,8+SP(i2,j2,3)*16),'Gray',4)
                                feature(5)=1;
                            elseif (strncmpi(suspect_data(i1,8+SP(i1,j1,3)*16),'red',3)&strncmpi(suspect_data(i2,8+SP(i2,j2,3)*16),'red',3))
                                feature(5)=1;
                            else feature(5)=0;
                            end
                    end
                    %feature 6:ethnicity
                    if ~strcmpi(cell2mat(suspect_data(i1,12+SP(i1,j1,3)*16)),'(null)')&~strcmpi(cell2mat(suspect_data(i2,12+SP(i2,j2,3)*16)),'(null)')...
                            &~strcmpi(cell2mat(suspect_data(i1,12+SP(i1,j1,3)*16)),'NA')&~strcmpi(cell2mat(suspect_data(i2,12+SP(i2,j2,3)*16)),'NA')...
                            &~strcmpi(cell2mat(suspect_data(i1,12+SP(i1,j1,3)*16)),'UNKNOWN')&~strcmpi(cell2mat(suspect_data(i2,12+SP(i2,j2,3)*16)),'UNKNOWN')...
                            if ~strcmpi(cell2mat(suspect_data(i1,12+SP(i1,j1,3)*16)),cell2mat(suspect_data(i2,12+SP(i2,j2,3)*16)))
                            feature_index(6)=-1;
                            else feature(6)=1;
                            end
                    end
                    %feature 7: eye color
                    if ~strcmpi(cell2mat(suspect_data(i1,13+SP(i1,j1,3)*16)),'(null)')&~strcmpi(cell2mat(suspect_data(i2,13+SP(i2,j2,3)*16)),'(null)')...
                            &~strcmpi(cell2mat(suspect_data(i1,13+SP(i1,j1,3)*16)),'NA')&~strcmpi(cell2mat(suspect_data(i2,13+SP(i2,j2,3)*16)),'NA')...
                            &~strcmpi(cell2mat(suspect_data(i1,13+SP(i1,j1,3)*16)),'UNKNOWN')&~strcmpi(cell2mat(suspect_data(i2,13+SP(i2,j2,3)*16)),'UNKNOWN')...
                            if ~strcmpi(cell2mat(suspect_data(i1,13+SP(i1,j1,3)*16)),cell2mat(suspect_data(i2,13+SP(i2,j2,3)*16)))
                            feature(7)=-1;
                            else feature(7)=0.8;
                            end
                    end
                    
                    %feature
                    
                    if isempty(find(feature_index<0))
                        k1=k1+1;
                        count1(k1)=feature.*feature_index*lambda/sum(lambda);
                        if feature(2)==10
                            count1(k1)=1;
                        end
                    end
                end
            end
            if k1
                kk=kk+1;
                count(kk)=max(count1);
            end
        end
        if max(count)==1
            suspect(i1,i2)=1;
            sprintf('SP=1:(%d,%d)',i1,i2)
        else
            if kk==(sum(SP(i1,:,1))+sum(SP(i1,:,2)))& kk==(sum(SP(i2,:,1))+sum(SP(i2,:,2)))&kk
                suspect(i1,i2)=sum(count)/kk;
                sprintf('SP=%f:(%d,%d)',suspect(i1,i2),i1,i2)
            elseif kk & (sum(SP(i1,:,1))+sum(SP(i1,:,2)))
                suspect(i1,i2)=0;
                %sprintf('SP=0.5:(%d,%d)',i1,i2)
            end
        end
        if sum(SP(i1,:,1))+sum(SP(i1,:,2))+sum(SP(i2,:,1))+sum(SP(i2,:,2))==0
            suspect_index(i1,i2)=0;
        end
    end
end
