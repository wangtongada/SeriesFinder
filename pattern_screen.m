pattern_num=patternnum;
for tt=t1:t2
    list=find(patternnum==pset(tt,1));
    len=length(list);
    for k1=1:len
        for k2=1:len
            m1=min(list(k1),list(k2));
            m2=max(list(k1),list(k2));
            if HB_SP_index(m1,m2)==-1
                fprintf('--(%d,%d)--',m1,m2);
            end
        end
    end
end