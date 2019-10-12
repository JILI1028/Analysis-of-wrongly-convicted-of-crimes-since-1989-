proc print data=work.a;run;
data work1;
set work.a;
Amount_peryear=Amount/Years_Lost;
Amount1_peryear=Amount__1/Years_Lost;
if Exonerated<=2000 then overtime=1;
else if Exonerated<=2010 then overtime=2;
else overtime=3;
if State in (1,2,3,4,10,11,13,16,17,18,19,20,24,26,27,28,29,35,36,37,38,40,43,44,45,46,47,51,52,53) then Blue_Red=0;
else if State in(5,6,7,8,9,13,15,21,22,23,25,30,31,32,33,34,39,42,48,49,50) then Blue_red=1;
if State in (7,21,23,31,32,34,40,42,48) then geo=0;
else if State in(15,16,17,18,24,25,27,29,36,37,44,52) then geo=1;
else if State in(1,4,8,9,10,11,19,20,22,26,35,38,43,45,46,49,51) then geo=2;
else if State in(2,3,5,6,13,14,28,30,33,39,47,50,53) then geo=3;
run;
proc print data=work1;run;
More Complex Inquiries
#1
proc corr data=work.a;
var Race State_Claim_Made_;
run;
proc corr data=work.a;
var Race State_Claim_Made_;
partial Exonerated;
run;

proc loess data=work.a;
  model State_Claim_Made_=Race / clm alpha=0.05;
ods output Outputstatistics=lofit;
run;
proc reg data=work.a;
model State_Claim_Made_=Race;
output out=regout p=pr uclm=upper lclm=lower r=resid;
plot State_Claim_Made_*Race/conf;
run;
Proc logistic data=work.a;
class race;
model State_Claim_Made_=Race;run;
Proc logistic data=work.a;
model State_Award_=Race;run;
Proc logistic data=work.a;
model Non_Statutory_Case_Filed_=Race;run;
Proc logistic data=work.a;
model Award_via_Settlement_or_Verdict=Race;run;
Proc logistic data=work1;
class Race;
model Amount_peryear=Race;run;
Proc reg data=work1;
model Amount_peryear=Race;run;
proc logistic data=work1;
class Race;
model Amount1_peryear=Race;run;

/whether have relationship with amount/
proc reg data=work1;
model Amount_peryear=Race;
run;
proc reg data=work1;
model Amount1_peryear=Race;
run;
proc reg data=work1;
model Amount_peryear=Sex;
run;
proc reg data=work1;
model Amount1_peryear=Sex;
run;
proc reg data=work1;
model Amount_peryear=Worst_Crime;
run;
proc glm data=work1;
model Amount_peryear=Worst_Crime;
run;
proc reg data=work1;
model Amount1_peryear=Worst_Crime;
run;
proc reg data=work1;
model Amount_peryear=Years_Lost;
run;
proc reg data=work1;
model Amount1_peryear=Years_Lost;
run;
proc reg data=work1;
model Amount_peryear=Exonerated;
run;
proc reg data=work1;
model Amount1_peryear=Exonerated;
run;
#

proc sort data=work.a;
by Race;run;
proc sgplot data=work.a;
   loess x=Exonerated y=State_Claim_Made_ / group=Race;
run;
proc sgplot data=work.a;
    reg x=Years_Lost y=State_Claim_Made_ / group=Race;
run;
proc sgplot data=work.a;
   reg x=Exonerated y=Non_Statutory_Case_Filed_ / group=Race;
run;
proc sgplot data=work.a;
    reg x=Years_Lost y=Non_Statutory_Case_Filed_ / group=Race;
run;
proc sgplot data=work.a;
   reg x=Exonerated y=State_Award_ / group=Race;
run;
proc sgplot data=work.a;
    reg x=Years_Lost y=State_Award_ / group=Race;
run;
proc reg data=work.a;
   model State_Claim_Made_=Exonerated;
run;

proc means data=work1;
class Race overtime;
var Amount1_peryear;
run;
/zuotu/
#Race V.S rates changed over time?
proc sgplot data=work1;
   vbar Race/response=State_Claim_Made_ stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar State_Claim_Made_/response=Years_Lost stat=mean group=Race nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;

proc reg data=work1;
model Non_Statutory_Case_Filed_=Race;run;
proc sgplot data=work1;
   vbar Race/response=State_Claim_Made_ stat=mean  nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Race/response=Non_Statutory_Case_Filed_ stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Race/response=State_Award_ stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Race/response=Award_via_Settlement_or_Verdict stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Race/response=Amount1_peryear stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   loess x=Exonerated y=State_Claim_Made_ / group=Race;
run;
proc sgplot data=work1;
   vbar Race/response=Amount1_peryear stat=mean nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc logistic data=work1;
class Race;
   model State_Claim_Made_= Race;
run;
proc reg data=work1;
   model Amount1_peryear=Race;
run;

#Gender:
proc sgplot data=work1;
   vbar Sex/response=Non_Statutory_Case_Filed_ stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Sex/response=State_Claim_Made_ stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Sex/response=State_Award_ stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Sex/response=Award_via_Settlement_or_Verdict stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Sex/response=Amount1_peryear stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Sex/response=Amount1_peryear stat=mean nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;

proc loess data=work1;

  model Amount1_peryear=Sex / clm alpha=0.05;
ods output Outputstatistics=lofit;
run;
proc sgplot data=work1;
   loess x=Exonerated y=Amount1_peryear / group=Sex;
run;
proc sgplot data=work1;
   loess x=Exonerated y=Non_Statutory_Case_Filed_;
run;
proc sgplot data=work1;
   loess x=Exonerated y=Amount_peryear;
run;
proc sgplot data=work1;
   loess x=Years_Lost y=Amount1_peryear;
   axis1 order=(0 to 2500000 by 10000 ) ;
run;
proc sgplot data=work1;
   loess x=Exonerated y=State_Claim_Made_;
run;
proc sgplot data=work1;
   reg x=Exonerated y=State_Claim_Made_;
run;
proc sgplot data=work1;
   vbar Exonerated/response=State_Claim_Made_ stat=mean nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar Exonerated/response=State_Claim_Made_ stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar overtime/response=State_Claim_Made_ stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
proc sgplot data=work1;
   vbar overtime/response=Amount_peryear stat=mean nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;

proc loess data=work.a;
  model Non_Statutory_Case_Filed_=Race / clm alpha=0.05;
ods output Outputstatistics=lofit;
run;
proc sgplot data=work.a;
   reg x=Exonerated y=Non_Statutory_Case_Filed_ / group=Race;
run;
proc sgplot data=work.a;
    reg x=Years_Lost y=Non_Statutory_Case_Filed_ / group=Race;
run;

#
#/Race V.S file and prevail or not/
proc freq data=work.a;
tables Race*State_Claim_Made_/ chisq;
tables Race*State_Award_/ chisq;
tables Race*Non_Statutory_Case_Filed_/ chisq;
tables Race*Award_via_Settlement_or_Verdict/ chisq;
run;
proc freq data=work.a;
tables Race*State_Claim_Made_/ nopercent nocol chisq cmh1 relrisk;exact pchi or;run;
proc sort data=work1;by overtime;run;
proc freq data=work1;
by overtime;
tables Race*State_Claim_Made_/ chisq;
tables Race*State_Award_/ chisq;
tables Race*Non_Statutory_Case_Filed_/ chisq;
tables Race*Award_via_Settlement_or_Verdict/ chisq;
run;
proc means data=work1;
class Race;
var Amount1_peryear;
run;
proc means data=work1;
class Race;
var Amount_peryear;
run;

proc means data=work1;
class State_Award_;
var Amount;
run;



#/Gender V.S file and prevail or not/
proc freq data=work.a;
tables Sex*State_Claim_Made_/ chisq;
tables Sex*State_Award_/ chisq;
tables Sex*Non_Statutory_Case_Filed_/ chisq;
tables Sex*Award_via_Settlement_or_Verdict/ chisq;
run;

proc freq data=work1;
by overtime;
tables Sex*State_Claim_Made_/ chisq;
tables Sex*State_Award_/ chisq;
tables Sex*Non_Statutory_Case_Filed_/ chisq;
tables Sex*Award_via_Settlement_or_Verdict/ chisq;
run;
proc means data=work1;
class Sex;
var Amount_peryear;
run;
proc means data=work1;
class Sex;
var Amount1_peryear;
run;
proc means data=work1;
class Sex overtime;
var Amount_peryear;
run;
proc means data=work1;
class Sex overtime;
var Amount1_peryear;
run;
#blue and red
proc freq data=work1;
tables Blue_Red*State_Claim_Made_/ chisq;
tables Blue_Red*State_Award_/ chisq;
tables Blue_Red*Non_Statutory_Case_Filed_/ chisq;
tables Blue_Red*Award_via_Settlement_or_Verdict/ chisq;
run;
proc reg data=work1;
model Amount_peryear=Blue_Red;
run;
proc reg data=work1;
model Amount1_peryear=Blue_Red;
run;
proc sgplot data=work1;
   vbar Blue_Red/response=State_Claim_Made_ stat=mean group=overtime nostatlabel groupdisplay=cluster;
xaxis display=(nolabel);
yaxis grid;
run;
#Geo:
proc freq data=work1;
tables geo*State_Claim_Made_/ chisq;
tables geo*State_Award_/ chisq;
tables geo*Non_Statutory_Case_Filed_/ chisq;
tables geo*Award_via_Settlement_or_Verdict/ chisq;
run;
proc reg data=work1;
model State_Claim_Made_=geo;
run;
proc reg data=work1;
model State_Award_=geo;
run;
proc reg data=work1;
model Non_Statutory_Case_Filed_=geo;
run;
proc reg data=work1;
model Award_via_Settlement_or_Verdict=geo;
run;


#CIU
proc freq data=work.a;
tables CIU*State_Claim_Made_/ chisq;
tables CIU*State_Award_/ chisq;
tables CIU*Non_Statutory_Case_Filed_/ chisq;
tables CIU*Award_via_Settlement_or_Verdict/ chisq;
run;

#guilty plea
proc freq data=work.a;
tables Guilty_Plea*State_Claim_Made_/ chisq;
tables Guilty_Plea*State_Award_/ chisq;
tables Guilty_Plea*Non_Statutory_Case_Filed_/ chisq;
tables Guilty_Plea*Award_via_Settlement_or_Verdict/ chisq;
run;

#Worst_Crime
proc freq data=work.a;
tables Worst_Crime*State_Claim_Made_/ chisq;
tables Worst_Crime*State_Award_/ chisq;
tables Worst_Crime*Non_Statutory_Case_Filed_/ chisq;
tables Worst_Crime*Award_via_Settlement_or_Verdict/ chisq;
run;
proc means data=work1;
class Worst_Crime;
var Amount1_peryear;
run;
# year of Exonerated
proc freq data=work1;
tables overtime*State_Claim_Made_/ chisq;
tables overtime*State_Award_/ chisq;
tables overtime*Non_Statutory_Case_Filed_/ chisq;
tables overtime*Award_via_Settlement_or_Verdict/ chisq;
run;
#DNA_only
proc freq data=work1;
tables DNA_only*State_Claim_Made_/ chisq;
tables DNA_only*State_Award_/ chisq;
tables DNA_only*Non_Statutory_Case_Filed_/ chisq;
tables DNA_only*Award_via_Settlement_or_Verdict/ chisq;
run;
#Death_Penalty_
proc freq data=work1;
tables Death_Penalty_*State_Claim_Made_/ chisq;
tables Death_Penalty_*State_Award_/ chisq;
tables Death_Penalty_*Non_Statutory_Case_Filed_/ chisq;
tables Death_Penalty_*Award_via_Settlement_or_Verdict/ chisq;
run;
#Years_Lost
proc means data=work1;
class State_Claim_Made_;
var Years_Lost;
run;
proc means data=work1;
class State_Award_;
var Years_Lost;
run;
proc means data=work1;
class Non_Statutory_Case_Filed_;
var Years_Lost;
run;
proc means data=work1;
class Award_via_Settlement_or_Verdict;
var Years_Lost;
run;




proc corr data=work1 pearson spearman;
var Years_Lost Amount1_peryear;
run;
proc corr data=work.a pearson spearman;
var Years_Lost Amount;
run;
proc sgplot data=work1;
   scatter x=Years_Lost y=Amount1_peryear;
run;
proc sgplot data=work.a;
   scatter x=Years_Lost y=Amount;
run;
proc reg data=work1;
model Amount1_peryear=Years_Lost;
output out=regout p=pr uclm=upper lclm=lower r=resid;
plot Amount1_peryear*Years_Lost/conf;
run;
proc loess data=work1;
  model Amount1_peryear=Years_Lost / clm alpha=0.05;
ods output Outputstatistics=lofit;
run;

proc freq data=work.a;
tables Race*State_Claim_Made_/plots=freqplot(type=dotplot);run;
proc freq data=work.a;
tables Race*State_Award_/plots=freqplot(type=dotplot);run;
proc freq data=work.a;
tables Race*Non_Statutory_Case_Filed_/plots=freqplot(type=dotplot);run;
proc freq data=work.a;
tables Race*Award_via_Settlement_or_Verdict/plots=freqplot(type=dotplot);run;



data work2;
set work.a;
new=Amount__1/Years_Lost;run;
proc print data=work2;run;
proc sgplot data=work2;
    scatter x=Race y=new;
run;
proc reg data=work2;
model new=Race;
output out=regout p=pr uclm=upper lclm=lower r=resid;
plot new*Race/conf;
run;
proc sgplot data=work.a;
   scatter x=Exonerated y=Amount__1 / group=Race;
run;



proc reg data=work.a;
  model Amount=Age_on_Date_of_Crime--Worst_Crime Death_Penalty_--State_Award_ Non_Statutory_Case_Filed_--Years_Lost/ vif;
run;
quit;
proc reg data=work.a;
  model Amount=Age_on_Date_of_Crime--Worst_Crime Death_Penalty_--State_Award_ Non_Statutory_Case_Filed_--Years_Lost/ selection=cp ;
run;
  plot cp.*np. / cmallows=black;
run; 
quit;
proc reg data=work.a;
forward:  model Amount=Age_on_Date_of_Crime--Worst_Crime Death_Penalty_--State_Award_ Non_Statutory_Case_Filed_--Years_Lost/ selection=f ;
run;
quit;
proc reg data=work.a;
  model Amount=Tags CIU Guilty_Plea Death_Penalty_  MWID State_Claim_Made_  _0_ Denied_ Pending Amount__1 Years_Lost ;
  plot r.*(Tags CIU Guilty_Plea Death_Penalty_  MWID State_Claim_Made_  _0_ Denied_ Pending Amount__1 Years_Lost) / nomodel nostat;
  plot r.*p.;
  plot npp.*r.;
  plot nqq.*r.;
  plot cookd.*obs.;
run;
quit;
proc glm data=work.a;
  model Amount=Tags CIU Guilty_Plea Death_Penalty_  MWID State_Claim_Made_  _0_ Denied_ Pending Amount__1 Years_Lost ;
run;
quit;
proc reg data=work.a;
  model Amount__1=Age_on_Date_of_Crime--Worst_Crime Death_Penalty_--Premature Years_Lost/ selection=cp ;
run;
  plot cp.*np. / cmallows=black;
run; 
quit;
proc reg data=work.a;
  model Amount__1=State Tags Worst_Crime DNA_only MWID ILD State_Award_ Amount Non_Statutory_Case_Filed_ No_Time_ Dismissed_or_verdict_for_D Pending Award_via_Settlement_or_Verdict Years_Lost;
  plot r.*(State Tags Worst_Crime DNA_only MWID ILD State_Award_ Amount Non_Statutory_Case_Filed_ No_Time_ Dismissed_or_verdict_for_D Pending Award_via_Settlement_or_Verdict Years_Lostt) / nomodel nostat;
  plot r.*p.;
  plot npp.*r.;
  plot nqq.*r.;
  plot cookd.*obs.;
run;

#/proc glm data=work.a;
  model Amount Amount__1=Tags CIU Guilty_Plea Death_Penalty_  MWID State_Claim_Made_  _0_ Denied_ Pending Amount__1 Years_Lost ;
  run;/
proc logistic data=work.a;
  model State_Award_=Age_on_Date_of_Crime--Worst_Crime Death_Penalty_--Denied_ Amount--Years_Lost ;
run;

data work2;
set work.a;
if State_Award_=1 then State_receive=1;
else if State_Award_=0 then State_receive=0;run;
#/proc genmod data=work2;
      model State_receive=Age_on_Date_of_Crime--Worst_Crime Death_Penalty_--Denied_ Amount--Years_Lost / dist = bin
                           link = logit;
   run;/
proc print data=work2;run;
proc reg data=work2;
  model State_receive=Age_on_Date_of_Crime--Worst_Crime Death_Penalty_--Denied_ Amount--Years_Lost/ selection=cp ;
run;
  plot cp.*np. / cmallows=black;
run; 
quit;
proc reg data=work2;
  model State_receive=Age_on_Date_of_Crime State_Claim_Made_ _0_ Denied_ ;
  plot r.*(Age_on_Date_of_Crime State_Claim_Made_ _0_ Denied_) / nomodel nostat;
  plot r.*p.;
  plot npp.*r.;
  plot nqq.*r.;
  plot cookd.*obs.;
run;
proc logistic data=work2;
  model State_receive=Age_on_Date_of_Crime--Worst_Crime Death_Penalty_--Denied_ Amount--Years_Lost ;
run;
proc reg data=work2;
  model State_receive=State_Claim_Made_ _0_ Denied_ Prem_;
  plot r.*(State_Claim_Made_ _0_ Denied_ Prem_) / nomodel nostat;
  plot r.*p.;
  plot npp.*r.;
  plot nqq.*r.;
  plot cookd.*obs.;
run;

proc reg data=work.a;
  model Award_via_Settlement_or_Verdict=Age_on_Date_of_Crime--Worst_Crime Death_Penalty_--Pending Premature--Years_Lost ;
run;

proc reg data=work.a;
  model Award_via_Settlement_or_Verdict=F_MFE P_FA Unfiled Dismissed_or_verdict_for_D Pending Premature ;
  plot r.*(F_MFE P_FA Unfiled Dismissed_or_verdict_for_D Pending Premature) / nomodel nostat;
  plot r.*p.;
  plot npp.*r.;
  plot nqq.*r.;
  plot cookd.*obs.;
run;

proc genmod data=work.a;
  model Amount=Tags CIU Guilty_Plea Death_Penalty_  MWID State_Claim_Made_  _0_ Denied_ Pending Amount__1 Years_Lost/ dist=p ;
  output out=gamout;
run;



Sex: 
Proc logistic data=work.a;
class Sex;
model State_Claim_Made_(event='1')=Sex;run;
Proc logistic data=work.a;
class Sex;
model State_Award_(DESCENDING)=Sex;run;
Proc logistic data=work.a;
class Sex;
model Non_Statutory_Case_Filed_(event='1')=Sex;run;
Proc logistic data=work.a;
class Sex;
model Award_via_Settlement_or_Verdict(event='1')=Sex;run;
proc logistic data=work1;
class Sex;
model Amount_peryear(DESCENDING)=Sex;run;
proc logistic data=work1;
class Sex;
model Amount1_peryear(DESCENDING)=Sex;run;
proc sort data=work1;
by overtime;run;

Blue:/red:
Proc logistic data=work1;
class Blue_red;
model State_Claim_Made_(event='1')=Blue_red;run;
Proc logistic data=work1;
class Blue_red;
model State_Award_(DESCENDING)=Blue_red;run;
Proc logistic data=work1;
class Blue_red;
model Non_Statutory_Case_Filed_(event='1')=Blue_red;run;
Proc logistic data=work1;
class Blue_red;
model Award_via_Settlement_or_Verdict(event='1')=Blue_red;run;
proc logistic data=work1;
class Blue_red;
model Amount_peryear(DESCENDING)=Blue_red;run;
proc logistic data=work1;
class Blue_red;
model Amount1_peryear(DESCENDING)=Blue_red;run;

geo:
proc freq data=work1;
tables geo*State_Claim_Made_/ nopercent nocol chisq cmh1 relrisk;
tables geo*State_Award_/  nopercent nocol chisq cmh1 relrisk;
tables geo*Non_Statutory_Case_Filed_/  nopercent nocol chisq cmh1 relrisk;
tables geo*Award_via_Settlement_or_Verdict/  nopercent nocol chisq cmh1 relrisk;exact pchi or;
run;

CIU:
Proc logistic data=work1;
class CIU;
model State_Claim_Made_(event='1')=CIU;run;
Proc logistic data=work1;
class CIU;
model State_Award_(DESCENDING)=CIU;run;
Proc logistic data=work1;
class CIU;
model Non_Statutory_Case_Filed_(event='1')=CIU;run;
Proc logistic data=work1;
class CIU;
model Award_via_Settlement_or_Verdict(event='1')=CIU;run;
