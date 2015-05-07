% compute the similarity in timeframe
% the time frame in our data is a range, for example 11:00AM - 1:00PM
% see paper "Learning to detect patterns of crime" for detail

pdf2=[pdf pdf(2:1441) pdf(2:1441)]; %pdf is the estimated density of distribution of time. pdf2 is created for computation convenience
dfrom=datenum(time_data(:,1:3));
dto=datenum(time_data(:,4:6));
t_mm=inline('60*hh+mm+1','hh','mm');
HB_timeframe=zeros(h,h); %till i=70, j=955;
sigma=240;
Gauss=inline('exp(-diff.^2./2./sigma.^2)','sigma','diff');
dis=inline('min(abs(mod((m1-1),1441)-mod((m2-1),1441)),1440-abs(mod((m1-1),1441)-mod((m2-1),1441)))','m1','m2');
A=zeros(1,721);
for diff=0:720
    A(diff+1)=Gauss(sigma,diff);
end
for i=1:Ncrimes
    if ~isnan(time_data(i,10))& dto(i)-dfrom(i)>=0
        tfivec=datevec(time_data(i,10));
        ttivec=datevec(time_data(i,11));
        tfi=t_mm(tfivec(4),tfivec(5));
        tti=t_mm(ttivec(4),ttivec(5));
        spani=(dto(i)-dfrom(i))*1440+tti-tfi;
        for j=(i+1):h
            sprintf('i=%d, j=%d',i,j)
            if ~isnan(time_data(j,10))& dto(j)-dfrom(j)>=0
                HB_timeframe(i,j)=0;
                tfjvec=datevec(time_data(j,10));
                ttjvec=datevec(time_data(j,11));
                tfj=t_mm(tfjvec(4),tfjvec(5));
                ttj=t_mm(ttjvec(4),ttjvec(5));
                spanj=(dto(j)-dfrom(j))*1440+ttj-tfj;
                if spani>1440|spanj>1440|isnan(time_data(j,11))|isnan(time_data(j,10))
                    HB_timeframe(i,j)=0;
                else
                    sumi=0;
                    for k=tfi:((dto(i)-dfrom(i))*1440+tti)                     
                        jindx=tfj:((dto(j)-dfrom(j))*1440+ttj);
                        jvec=A(dis(k,jindx)+1).*pdf2(mod((k-1),1441)+1).*pdf2(mod((jindx-1),1441)+1);
                        HB_timeframe(i,j)=HB_timeframe(i,j)+sum(jvec);
                    end
                    sumi=sum(pdf2(tfi:((dto(i)-dfrom(i))*1440+tti)));
                    sumj=sum(pdf2(tfj:((dto(j)-dfrom(j))*1440+ttj)));
                    HB_timeframe(i,j)=HB_timeframe(i,j)/sumi/sumj;
                end
            else HB_timeframe(i,j)=0;
            end
        end
    else HB_timeframe(i,:)=zeros(1,h);
    end
end