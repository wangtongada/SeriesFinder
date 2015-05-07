victim=zeros(Ncrimes,Ncrimes);
victim_index=ones(Ncrimes,Ncrimes);
VI=zeros(Ncrimes,14,3);

for i=1:Ncrimes %crime incident #1
    index=0;
    for j=0:13 %incident #1 structure index
        %compare the suspect
        index=index+1;
        if strcmpi(cell2mat(victim_data(i,2+j*16)),'M')
            VI(i,index,1)=1;%sp1('M','F',index);
        elseif strcmpi(cell2mat(victim_data(i,2+j*16)),'F')
            VI(i,index,2)=1;%sp1('M','F',index);
        end
        VI(i,index,3)=j;
    end
end

for i1=1:Ncrimes
    female1=sum(VI(i1,:,2));
    male1=sum(VI(i1,:,1));
    if female1==0&male1==0
        victim_index(i1,:)=zeros(1,h);
    else
        for i2=(i1+1):Ncrimes %crime incident #2
            female2=sum(VI(i2,:,2));
            male2=sum(VI(i2,:,1));
            if female2==0&male2==0
                victim_index(i1,i2)=0;
            else
                if (female1==female2)&female1==1&(male1==0)&(male2==0)
                    victim(i1,i2)=0.8;
                elseif female1>1&female2>1&(male1==0)&(male2==0)
                    victim(i1,i2)=0.8;
                elseif (female1==female2)&female1>1&(male1==0)&(male2==0)
                    victim(i1,i2)=0.9;
                elseif (male1==male2)&male1==1&(female1==0)&(female2==0)
                    victim(i1,i2)=0.8;
                elseif (male1==male2)&male1>1&(female1==0)&(female2==0)
                    victim(i1,i2)=0.9;
                elseif (male1>1&male2>1)&(female1==0)&(female2==0)
                    victim(i1,i2)=0.8;
                end
            end
        end
    end
end