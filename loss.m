function fval=loss(x)
global patternnum;
global HB_LocEntry_index;
global HB_LocEntry;
global HB_MnsEntry_index;
global HB_MnsEntry;
global HB_dayapart_index;
global HB_dayapart;
global HB_dis;
global HB_Injure_index;
global HB_Injure;
global HB_Ransacked_index;
global HB_Ransacked;
global HB_Residents_index;
global HB_Residents;
global HB_timeframe_index;
global HB_timeframe;
global HB_week_index;
global HB_week;
global HB_seasonal;
global HB_SP_index;
global HB_SP;
global HB_VI_index;
global HB_VI;
global HB_premises_index;
global HB_premises;
global mLoc;
global mMns;
global mDap;
global mDis;
global mInj;
global mPrm;
global mRsck;
global mRes;
global mtf;
global mWk;
global mSson;
global mSP;
global mVI;
global h;

HB_S=x(1).*HB_LocEntry_index.*(HB_LocEntry/mLoc)...
    +x(2).*HB_MnsEntry_index.*(HB_MnsEntry/mMns)...
    +x(3).*HB_dayapart_index.*(HB_dayapart/mDap)...
    +x(4).*(HB_dis/mDis)...
    +x(5).*HB_Injure_index.*(HB_Injure/mInj)...
    +x(6).*HB_premises_index.*(HB_premises/mPrm)...
    +x(7).*HB_Ransacked_index.*(HB_Ransacked/mRsck)...
    +x(8).*HB_Residents_index.*(HB_Residents/mRes)...
    +x(9).*HB_timeframe_index.*(HB_timeframe/mtf)...
    +x(10).*HB_week_index.*(HB_week/mWk)...
    +x(11).*(HB_seasonal/mSson)...
    +x(12).*HB_SP_index.*(HB_SP/mSP)...
    +x(13).*HB_VI_index.*(HB_VI/mVI);

fval=0;
for i=2:h
    D=i:h;
    if patternnum(i)==0
        B=[];
    else
        B=find(patternnum==patternnum(i));
    end
    C=setdiff(D,B);
    fval=fval+length(find(HB_S(i,C)>=x(66)));
end
