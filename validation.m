Real=zeros(52,500,2);
Wrong=zeros(52,500,2);
for t=2:52
    ireal=1;
    iwrong=1;
    if pset(t,2)>2
        patternt=find(patternnum==pset(t,1))
        for i=2:(List_grid(t,1000)+1)
            if ismember(List_grid(t,i),patternt)
               Real(t,ireal,1)=i-1;
               Real(t,ireal,2)=List_grid(t,i);
               ireal=ireal+1;
            else
               Wrong(t,iwrong,1)=i-1;
               Wrong(t,iwrong,2)=List_grid(t,i);
               iwrong=iwrong+1;
           end
       end
   end
end
