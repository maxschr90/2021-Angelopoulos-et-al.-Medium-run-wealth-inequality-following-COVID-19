%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAIN TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all

figure(1)
subplot(2,2,1)
load('Good_Cap_v2.mat')
plot([Mean_K(1),  Mean_K(1:20)]/Mean_K(1),'LineWidth',2.5, 'Marker', '*')
hold on
load('Bad_Cap_v2.mat')
plot([Mean_K(1),  Mean_K(1:20)]/Mean_K(1),'LineWidth',2.5, 'Marker', 'd')
ylabel({'Mean wealth relative', 'to pre-COVID-19'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on

xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
subplot(2,2,2)
load('Good_Cap_v2.mat')
plot([GINI_K(1) GINI_K(1:20)],'LineWidth',2.5, 'Marker', '*')
hold on
load('Bad_Cap_v2.mat')
plot([GINI_K(1)  GINI_K(1:20)],'LineWidth',2.5, 'Marker', 'd')
ylabel('Gini coefficient of Wealth')
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})

set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on

subplot(2,2,3)
load('Good_Cap_v2.mat')
plot(([sum(Quintile_Share(1:2,1)), sum(Quintile_Share(1:2,1:20))]),'LineWidth',2.5, 'Marker', '*')
hold on
load('Bad_Cap_v2.mat')
plot(([sum(Quintile_Share(1:2,1)), sum(Quintile_Share(1:2,1:20))]),'LineWidth',2.5, 'Marker', 'd')
ylabel('Share of bottom 40%')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})

subplot(2,2,4)
load('Good_Cap_v2.mat')
plot(([Quintile_Share(5,1), Quintile_Share(5,1:20)]),'LineWidth',2.5, 'Marker', '*')
hold on
load('Bad_Cap_v2.mat')
plot(([Quintile_Share(5,1), Quintile_Share(5,1:20)]),'LineWidth',2.5, 'Marker', 'd')
ylabel('Share of top 20%')
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
legend('Short recession', 'Long recession','location','best')

set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on


set (figure(1), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(1);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'Fig2','-dmeta','-r600')
print(h,'Fig2','-dpdf','-r600')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
subplot(2,2,1)
load('Good_Cap_v2.mat')
plot([Mean_K_Class(1,1), Mean_K_Class(1,1:20)]/Mean_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([Mean_K_Class(2,1), Mean_K_Class(2,1:20)]/Mean_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([Mean_K_Class(3,1), Mean_K_Class(3,1:20)]/Mean_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([Mean_K_Class(4,1), Mean_K_Class(4,1:20)]/Mean_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
ylabel({'Mean wealth relative', 'to pre-COVID-19'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
title('Short recession')

subplot(2,2,2)
load('Bad_Cap_v2.mat')
plot([Mean_K_Class(1,1), Mean_K_Class(1,1:20)]/Mean_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([Mean_K_Class(2,1), Mean_K_Class(2,1:20)]/Mean_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([Mean_K_Class(3,1), Mean_K_Class(3,1:20)]/Mean_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([Mean_K_Class(4,1), Mean_K_Class(4,1:20)]/Mean_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
title('Long recession')


subplot(2,2,3)
load('Good_Cap_v2.mat')
plot([GINI_K_Class(1,1), GINI_K_Class(1,1:20)]/GINI_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([GINI_K_Class(2,1), GINI_K_Class(2,1:20)]/GINI_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([GINI_K_Class(3,1), GINI_K_Class(3,1:20)]/GINI_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([GINI_K_Class(4,1), GINI_K_Class(4,1:20)]/GINI_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
ylabel({'Relative change in', 'Gini coefficient'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
legend('Professionals', 'Intermediate','Routine', 'Inactive','location','NE', 'FontSize', 16,'fontname','Helvetica')



subplot(2,2,4)
load('Bad_Cap_v2.mat')
plot([GINI_K_Class(1,1), GINI_K_Class(1,1:20)]/GINI_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([GINI_K_Class(2,1), GINI_K_Class(2,1:20)]/GINI_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([GINI_K_Class(3,1), GINI_K_Class(3,1:20)]/GINI_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([GINI_K_Class(4,1), GINI_K_Class(4,1:20)]/GINI_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})

set (figure(2), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(2);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'Fig3','-dmeta','-r600')
print(h,'Fig3','-dpdf','-r600')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(6)
subplot(1,2,1)
load('Good_Cap_v2.mat')
plot([Median_K_Class(1,1), Median_K_Class(1,1:20)]/Median_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([Median_K_Class(2,1), Median_K_Class(2,1:20)]/Median_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([Median_K_Class(3,1), Median_K_Class(3,1:20)]/Median_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([Median_K_Class(4,1), Median_K_Class(4,1:20)]/Median_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
ylabel({'Median wealth relative', 'to pre-COVID-19'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
title('Short recession')

subplot(1,2,2)
load('Bad_Cap_v2.mat')
plot([Median_K_Class(1,1), Median_K_Class(1,1:20)]/Median_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([Median_K_Class(2,1), Median_K_Class(2,1:20)]/Median_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([Median_K_Class(3,1), Median_K_Class(3,1:20)]/Median_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([Median_K_Class(4,1), Median_K_Class(4,1:20)]/Median_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
title('Long recession')
legend('Professionals', 'Intermediate','Routine', 'Inactive','location','NE', 'FontSize', 16,'fontname','Helvetica')

set (figure(6), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(6);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'Fig4','-dmeta','-r600')
print(h,'Fig4','-dpdf','-r600')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(5)
subplot(2,2,1)
load('Good_Cap_v2.mat')
plot([Share_HTM_Class(1,1), Share_HTM_Class(1,1:20)],'LineWidth',2, 'Marker', '*')
hold on
load('Bad_Cap_v2.mat')
plot([Share_HTM_Class(1,1), Share_HTM_Class(1,1:20)],'LineWidth',2, 'Marker', 'd')
ylabel({'Professionals'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})

subplot(2,2,2)
load('Good_Cap_v2.mat')
plot([Share_HTM_Class(2,1), Share_HTM_Class(2,1:20)],'LineWidth',2, 'Marker', '*')
hold on
load('Bad_Cap_v2.mat')
plot([Share_HTM_Class(2,1), Share_HTM_Class(2,1:20)],'LineWidth',2, 'Marker', 'd')
ylabel({'Intermediate'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})


subplot(2,2,3)
load('Good_Cap_v2.mat')
plot([Share_HTM_Class(3,1), Share_HTM_Class(3,1:20)],'LineWidth',2, 'Marker', '*')
hold on
load('Bad_Cap_v2.mat')
plot([Share_HTM_Class(3,1), Share_HTM_Class(3,1:20)],'LineWidth',2, 'Marker', 'd')
ylabel({'Routine'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
legend('Short Recession', 'Long Recession','location','NE', 'FontSize', 16,'fontname','Helvetica')



subplot(2,2,4)
load('Good_Cap_v2.mat')
plot([Share_HTM_Class(4,1), Share_HTM_Class(4,1:20)],'LineWidth',2, 'Marker', '*')
hold on
load('Bad_Cap_v2.mat')
plot([Share_HTM_Class(4,1), Share_HTM_Class(4,1:20)],'LineWidth',2, 'Marker', 'd')
ylabel({'Inactive'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
set (figure(5), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(5);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'Fig5','-dmeta','-r600')
print(h,'Fig5','-dpdf','-r600')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% APPENDIX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
subplot(2,2,1)
load('Good_v2.mat')
plot([Mean_K(1),  Mean_K(1:20)]/Mean_K(1),'LineWidth',2.5, 'Marker', '*')
hold on
load('Bad_v2.mat')
plot([Mean_K(1),  Mean_K(1:20)]/Mean_K(1),'LineWidth',2.5, 'Marker', 'd')
ylabel({'Mean wealth relative', 'to pre-COVID-19'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on

xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
subplot(2,2,2)
load('Good_v2.mat')
plot([GINI_K(1) GINI_K(1:20)],'LineWidth',2.5, 'Marker', '*')
hold on
load('Bad_v2.mat')
plot([GINI_K(1)  GINI_K(1:20)],'LineWidth',2.5, 'Marker', 'd')
ylabel('Gini coefficient of Wealth')
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
legend('Short recession', 'Long recession','location','best')

set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on

subplot(2,2,3)
load('Good_v2.mat')
plot(([sum(Quintile_Share(1:2,1)), sum(Quintile_Share(1:2,1:20))]),'LineWidth',2.5, 'Marker', '*')
hold on
load('Bad_v2.mat')
plot(([sum(Quintile_Share(1:2,1)), sum(Quintile_Share(1:2,1:20))]),'LineWidth',2.5, 'Marker', 'd')
ylabel('Share of bottom 40%')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})

subplot(2,2,4)
load('Good_v2.mat')
plot(([Quintile_Share(5,1), Quintile_Share(5,1:20)]),'LineWidth',2.5, 'Marker', '*')
hold on
load('Bad_v2.mat')
plot(([Quintile_Share(5,1), Quintile_Share(5,1:20)]),'LineWidth',2.5, 'Marker', 'd')
ylabel('Share of top 20%')
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})

set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on


set (figure(3), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(3);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'Fig2_App','-dmeta','-r600')
print(h,'Fig2_App','-dpdf','-r600')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(4)
subplot(2,2,1)
load('Good_v2.mat')
plot([Mean_K_Class(1,1), Mean_K_Class(1,1:20)]/Mean_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([Mean_K_Class(2,1), Mean_K_Class(2,1:20)]/Mean_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([Mean_K_Class(3,1), Mean_K_Class(3,1:20)]/Mean_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([Mean_K_Class(4,1), Mean_K_Class(4,1:20)]/Mean_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
ylabel({'Mean wealth relative', 'to pre-COVID-19'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
title('Short recession')

subplot(2,2,2)
load('Bad_v2.mat')
plot([Mean_K_Class(1,1), Mean_K_Class(1,1:20)]/Mean_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([Mean_K_Class(2,1), Mean_K_Class(2,1:20)]/Mean_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([Mean_K_Class(3,1), Mean_K_Class(3,1:20)]/Mean_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([Mean_K_Class(4,1), Mean_K_Class(4,1:20)]/Mean_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
title('Long recession')


subplot(2,2,3)
load('Good_v2.mat')
plot([GINI_K_Class(1,1), GINI_K_Class(1,1:20)]/GINI_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([GINI_K_Class(2,1), GINI_K_Class(2,1:20)]/GINI_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([GINI_K_Class(3,1), GINI_K_Class(3,1:20)]/GINI_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([GINI_K_Class(4,1), GINI_K_Class(4,1:20)]/GINI_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
ylabel({'Relative change in', 'Gini coefficient'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
legend('Professionals', 'Intermediate','Routine', 'Inactive','location','NE', 'FontSize', 16,'fontname','Helvetica')



subplot(2,2,4)
load('Bad_v2.mat')
plot([GINI_K_Class(1,1), GINI_K_Class(1,1:20)]/GINI_K_Class(1,1),'LineWidth',2, 'Marker', 'o')
hold on
plot([GINI_K_Class(2,1), GINI_K_Class(2,1:20)]/GINI_K_Class(2,1),'LineWidth',2, 'Marker', '*')
plot([GINI_K_Class(3,1), GINI_K_Class(3,1:20)]/GINI_K_Class(3,1),'LineWidth',2, 'Marker', 's')
plot([GINI_K_Class(4,1), GINI_K_Class(4,1:20)]/GINI_K_Class(4,1),'LineWidth',2, 'Marker', 'p')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})

set (figure(4), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(4);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'Fig3_App','-dmeta','-r600')
print(h,'Fig3_App','-dpdf','-r600')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FIGURE 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(7)
subplot(4,2,1)
load('Good_Cap_v2.mat')

k_choice =reshape(k_choice,[],T);
        class =       (nn<4)...
                      + 2*(nn>3 & nn<=6)+  ...
                      + 3*(nn>6 & nn<=9)+  ...
                      + 4*(nn>9 & nn<=12) ;
x = sum(OMEGA(class==4,1).*k_choice(class==4,1:20))./sum(OMEGA(class==4,1));


plot([Mean_K_Class(4,1), Mean_K_Class(4,1:20)]/Mean_K_Class(4,1),'LineWidth',2, 'Marker', '*')
hold on
plot([x(1), x(1:20)]/x(1),'LineWidth',2, 'Marker', 'd', 'Linestyle', '--')
set(gca,'FontSize',21,'fontname','Helvetica')
ylabel({'Mean wealth' 'relative to', 'pre-COVID-19'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
title('Short Recession')

subplot(4,2,3)
for t =1:20
    [~,~,y(t)] = gini(k_choice(class==4,t), OMEGA(class==4,1));
end

plot([GINI_K_Class(4,1), GINI_K_Class(4,1:20)],'LineWidth',2, 'Marker', '*')
hold on
plot([y(1), y(1:20)],'LineWidth',2, 'Marker', 'd', 'Linestyle', '--')
set(gca,'FontSize',21,'fontname','Helvetica')
ylabel({'Gini coefficient'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})

subplot(4,2,5)
for t =1:20
    z(t) = wprctile(k_choice(class==4,t),50,OMEGA(class==4,1));
end

plot([Median_K_Class(4,1), Median_K_Class(4,1:20)]/Median_K_Class(4,1),'LineWidth',2, 'Marker', '*')
hold on
plot([z(1), z(1:20)]/z(1),'LineWidth',2, 'Marker', 'd', 'Linestyle', '--')
set(gca,'FontSize',21,'fontname','Helvetica')
ylabel({'Median wealth' 'relative to', 'pre-COVID-19'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})


subplot(4,2,7)
for t =1:20
    q(t) = sum(OMEGA(class==4,1).*(k_choice(class==4,t)<10^-6))/ sum(OMEGA(class==4,1));
end

plot([Share_HTM_Class(4,1), Share_HTM_Class(4,1:20)],'LineWidth',2, 'Marker', '*')
hold on
plot([q(1), q(1:20)],'LineWidth',2, 'Marker', 'd', 'Linestyle', '--')
set(gca,'FontSize',21,'fontname','Helvetica')
ylabel({'Share of', 'indebted', 'households'})
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})


subplot(4,2,2)
load('Bad_Cap_v2.mat')

k_choice =reshape(k_choice,[],T);
        class =       (nn<4)...
                      + 2*(nn>3 & nn<=6)+  ...
                      + 3*(nn>6 & nn<=9)+  ...
                      + 4*(nn>9 & nn<=12) ;
x = sum(OMEGA(class==4,1).*k_choice(class==4,1:20))./sum(OMEGA(class==4,1));


plot([Mean_K_Class(4,1), Mean_K_Class(4,1:20)]/Mean_K_Class(4,1),'LineWidth',2, 'Marker', '*')
hold on
plot([x(1), x(1:20)]/x(1),'LineWidth',2, 'Marker', 'd', 'Linestyle', '--')
set(gca,'FontSize',21,'fontname','Helvetica')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
title('Long Recession')

subplot(4,2,4)
for t =1:20
    [~,~,y(t)] = gini(k_choice(class==4,t), OMEGA(class==4,1));
end

plot([GINI_K_Class(4,1), GINI_K_Class(4,1:20)],'LineWidth',2, 'Marker', '*')
hold on
plot([y(1), y(1:20)],'LineWidth',2, 'Marker', 'd', 'Linestyle', '--')
set(gca,'FontSize',21,'fontname','Helvetica')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})

subplot(4,2,6)
for t =1:20
    z(t) = wprctile(k_choice(class==4,t),50, OMEGA(class==4,1));
end

plot([Median_K_Class(4,1), Median_K_Class(4,1:20)]/Median_K_Class(4,1),'LineWidth',2, 'Marker', '*')
hold on
plot([z(1), z(1:20)]/z(1),'LineWidth',2, 'Marker', 'd', 'Linestyle', '--')
set(gca,'FontSize',21,'fontname','Helvetica')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})


subplot(4,2,8)
for t =1:20
    q(t) = sum(OMEGA(class==4,1).*(k_choice(class==4,t)<10^-6))/ sum(OMEGA(class==4,1));
end

plot([Share_HTM_Class(4,1), Share_HTM_Class(4,1:20)],'LineWidth',2, 'Marker', '*')
hold on
plot([q(1), q(1:20)],'LineWidth',2, 'Marker', 'd', 'Linestyle', '--')
set(gca,'FontSize',21,'fontname','Helvetica')
set(gca,'FontSize',21,'fontname','Helvetica')
axis tight
grid on
xticks([3:5:21])
xtickangle(45)
xticklabels({'2020', '2025','2030', '2035', '2040'})
legend('Model Prediction', 'Model Counterfactual','location','best', 'FontSize', 16,'fontname','Helvetica')

set (figure(7), 'Units', 'normalized', 'Position', [0.16,0,0.66,1]);
h = figure(7);
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'Fig4_App','-dmeta','-r600')
print(h,'Fig4_App','-dpdf','-r600')





 
