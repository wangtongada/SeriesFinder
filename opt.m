cluster_eta;

A=-1.*eye(14,14);
b=zeros(14,1);
Aeq=[ones(1,13),0];
beq=1;
ub=ones(14,1);
lb=0.001*ones(14,1);
fout=1000000;
lb(14)=0.5;

for i=1:30
    i
    
    %for j=1:5
    %j
    x0=rand(1,14);
    x0(1:13)=x0(1:13)/sum(x0(1:13));
    options=optimset('Algorithm','active-set','TolCon',1e-10,'Display','iter');
    [x,fval,exitflag,output]=fmincon(@clusterLoss,x0,A,b,Aeq,beq,lb,ub,[],options);
    if fval<fout
        xout=x;
        fout=fval;
    end
end
%     x0=0.5.*xout+xout.*rand(1,14);
%     x0(1:13)=x0(1:13)/sum(x0(1:13));
%end
