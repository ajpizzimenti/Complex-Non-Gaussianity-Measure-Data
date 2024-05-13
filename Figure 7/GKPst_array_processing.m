%%Script for processing the GKPst file
L=100;
%% Store value of measure
Meas0=[];
Meas1=[];
for ind=1:L
    Meas0=[Meas0; GKParr(ind).meas0];
    Meas1=[Meas1; GKParr(ind).meas1];
end
save("LogicalZeroGKP_Re_Im_Mu.mat","Meas0")
save("LogicalOneGKP_Re_Im_Mu.mat","Meas1")
return
%%
figure(1)
subplot(2,1,1)
plot(sqV,Meas0(:,1),'LineWidth',3)
hold on
plot(sqV,Meas1(:,1),'LineWidth',3,'LineStyle','--')
grid on
ax=gca;
ax.FontSize = 14; 
lgd=legend('Logical Zero','Logical One');
lgd.FontSize=16;

subplot(2,1,2)
plot(sqV,Meas0(:,2),'LineWidth',3)
hold on
plot(sqV,Meas1(:,2),'LineWidth',3,'LineStyle','--')
grid on
ax=gca;
ax.FontSize = 14;  
ylim([0,0.1+pi/2])
line([0, 25],[pi/2,pi/2],'Color','k','LineWidth',2.5,'LineStyle',':')
return


%% Ensure normalized Wigner functions
for ind=1:L
    wigT0=GKParr(ind).wigFn0;
    wigT1=GKParr(ind).wigFn1;
    norm0=sum((GKParr(ind).dgrid*GKParr(ind).dgrid)*wigT0,'all');
    norm1=sum((GKParr(ind).dgrid*GKParr(ind).dgrid)*wigT1,'all');
    wigT0=wigT0./norm0;
    wigT1=wigT1./norm1;
    GKParr(ind).wigFn0=wigT0;
    GKParr(ind).wigFn1=wigT1;
end

%%
figure(1)
plot(Meas0(:,1),Meas0(:,2),'LineWidth',2)
hold on
plot(Meas1(:,1),Meas1(:,2),'LineWidth',2,'LineStyle','--')

figure(2)
plot(sqV,Meas0(:,1),'LineWidth',2)
hold on
plot(sqV,Meas1(:,1),'LineWidth',2,'LineStyle','--')
