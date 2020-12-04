clear all
close all
clc

% Load all the participants:
JND_TP1 = load(fullfile('JND_data_VIK/JND11'))      %Viktorija
JND_TP2 = load(fullfile('JND_data_SHOB/JND11'))     %Shobhit
JND_TP3 = load(fullfile('JND_data_hk/JND11'))       %Jin
JND_TP4 = load(fullfile('JND_data_HEMI/JND11'))     %Hemi
JND_TP5 = load(fullfile('JND_data_Jordi/JND11'))    %Jordi
JND_TP6 = load(fullfile('JND_data_Thomas/JND11'))   %Thomas

masker_type = [{'RANRAN'},{'COMCOM'},{'RANCOM'},{'FCOMCOM'}];
bmld = [{'IPD0'},{'IPD180'}];

colorcode = struct('blue',[0, 0.4470, 0.7410], 'orange',[0.8500, 0.3250, 0.0980],'yellow',[0.9290, 0.6940, 0.1250], 'purple',[0.4940, 0.1840, 0.5560]);
colortext = [{[0, 0.4470, 0.7410]},{[0.8500, 0.3250, 0.0980]},{[0.9290, 0.6940, 0.1250]},[0.4940, 0.1840, 0.5560]];

x = [0 5 10 15 20 25];                              % level above threshold (dB)

figure()                                            % figure of all the participants JND over level above (dB)

for k=1:4
subplot(4,2,k)
hold on
plot(x,[JND_TP1.JND(:,k),JND_TP2.JND(:,k),JND_TP3.JND(:,k),...
    JND_TP4.JND(:,k),JND_TP5.JND(:,k),JND_TP6.JND(:,k)],'o-','LineWidth',2)
caption = sprintf([masker_type{k} ' ' bmld{1}], k);
title(caption, 'FontSize', 12);

ylim([0 15])

end


for k=5:8
subplot(4,2,k)
hold on
plot(x,[JND_TP1.JND(:,k),JND_TP2.JND(:,k),JND_TP3.JND(:,k),...
    JND_TP4.JND(:,k),JND_TP5.JND(:,k),JND_TP6.JND(:,k)],'o--','LineWidth',2)
caption = sprintf([masker_type{k-4} ' ' bmld{2}], k);
title(caption, 'FontSize', 12);

ylim([0 15])

end
legend('TP1','TP2','TP3','TP4','TP5','TP6','TP7','FontSize', 12)
han=axes('Position',[0.1300 0.11262 0.71238 0.85],'visible','off'); 
han.XGrid = 'on';
han.YGrid = 'on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
xlabel(han,'Level above threshold (dB)','FontSize', 15);
ylabel(han,'JND (dB)','FontSize', 15);

%% log JND/I over I

plot(th_above_vitr, JND_TP1.JND./th_above_vitr)
set(gca, 'YScale', 'log')

N = 8;
for k = 1:N
    th_avg_ab(:,k) = mean([th_above_vitr(:,k),th_above_shob(:,k),th_above_hk(:,k)...
    th_above_hemi(:,k),th_above_jotg(:,k),th_above_thom(:,k)],2);
end
for k = 1:4
    plot(th_avg_ab(:,k), average(:,k)./th_avg_ab(:,k),'o-','Color', colortext{k},'LineWidth',2)
    hold on
end 
for k = 5:8
    plot(th_avg_ab(:,k), average(:,k)./th_avg_ab(:,k),'o--','Color', colortext{k-4},'LineWidth',2)
end

set(gca, 'YScale', 'log')
legend('RANRAN IPD0','COMCOM IPD0','RANCOM IPD0','FCOMCOM IPD0',...
    'RANRAN IPD180','COMCOM IPD180','RANCOM IPD180','FCOMCOM IPD180')
xlabel('Intensity (dB)','FontSize', 18)
ylabel('JND/I','FontSize', 18)


%%  mean thresholds with SD

for k = 1:8
    sd_cond(k) = std([th_vitr(k,3),th_shob(k,3), th_hk(k,3), ...
    th_hemi(k,3), th_jotg(k,3), th_thom(k,3)]);
    mean_cond(k) = mean([th_vitr(k,3), th_shob(k,3), th_hk(k,3), ...
    th_hemi(k,3), th_jotg(k,3), th_thom(k,3)]);
end

errorbar([mean_cond(1),mean_cond(2),mean_cond(3),mean_cond(4)],...
    [sd_cond(1),sd_cond(2),sd_cond(3),sd_cond(4)],'o-','MarkerSize',12,'LineWidth',2)
hold on
errorbar([mean_cond(5),mean_cond(6),mean_cond(7),mean_cond(8)],...
    [sd_cond(5),sd_cond(6),sd_cond(7),sd_cond(8)],'o--','MarkerSize',12,'LineWidth',2)
cond = {'RANRAN'; 'COMCOM'; 'RANCOM'; 'FCOMCOM'};
set(gca,'xtick',[1:4],'xticklabel',cond,'FontSize', 15)
legend('IPD0','IPD180','FontSize', 15)
xlabel('Condition','FontSize', 18)
ylabel('Level (dB)','FontSize', 18)


%% JND SD for FCOMCOM IPD180 at 0 dB and COMCOM IPD180 at 5 dB
sd_COMCOM180_5 = std([JND_TP1.JND(2,6),JND_TP2.JND(2,6),JND_TP3.JND(2,6),JND_TP4.JND(2,6),JND_TP5.JND(2,6),JND_TP6.JND(2,6)]);
sd_FCOMCOM180_0 = std([JND_TP1.JND(1,8),JND_TP2.JND(1,8),JND_TP3.JND(1,8),JND_TP4.JND(1,8),JND_TP5.JND(1,8),JND_TP6.JND(1,8)]);

%%  average of all participants

average = cat(6, JND_TP1.JND, JND_TP2.JND, JND_TP3.JND,...
    JND_TP4.JND, JND_TP5.JND, JND_TP6.JND);
average = sum(average,6);
average = average/6;

figure()                                            % Figure of JND average across all the participants over level above (dB)

for k=1:4
subplot(4,2,k)
hold on
plot(x,average(:,k),'o-','LineWidth',2)
caption = sprintf([masker_type{k} ' ' bmld{1}], k);
title(caption, 'FontSize', 8);

xlabel('Level above threshold (dB)')
ylabel('JND (dB)')
end


for k=5:8
subplot(4,2,k)
hold on
plot(x,average(:,k),'o--','LineWidth',2)
caption = sprintf([masker_type{k-4} ' ' bmld{2}], k);
title(caption, 'FontSize', 8);

xlabel('Level above threshold (dB)')
ylabel('JND (dB)')
end

%% Linear regression model
N = 8;
stack_avg = cell(1,N);

for k = 1:N
   tmp_avg = average(:,k);
   tmp_nanidx = isnan(tmp_avg);
   tmp_avg(tmp_nanidx) = [];
   stack_avg{k} = tmp_avg; 
   P(k,:) = polyfit(x(~tmp_nanidx), tmp_avg,1);
end

for k=1:4
    figure()
    yfit(:,k) = (P(k,1)*x+P(k,2))';
    hold on
    plot(x,[JND_TP1.JND(:,k),JND_TP2.JND(:,k),JND_TP3.JND(:,k),...
    JND_TP4.JND(:,k),JND_TP5.JND(:,k),JND_TP6.JND(:,k)],'o-','LineWidth',2)
    plot(x,yfit(:,k),'r-.');
    caption = sprintf([masker_type{k} ' ' bmld{1}], k);
    title(caption, 'FontSize', 12);
    ylim([0 15])
    xlim([0 25])
    legend('TP1','TP2','TP3','TP4','TP5','TP6','FontSize', 12)
    xlabel('Level above threshold (dB)','FontSize', 15);
    ylabel('JND (dB)','FontSize', 15);
end


for k=5:8
    figure()
    yfit(:,k) = (P(k,1)*x+P(k,2))';
%     subplot(4,2,k)
    hold on
    plot(x,[JND_TP1.JND(:,k),JND_TP2.JND(:,k),JND_TP3.JND(:,k),...
    JND_TP4.JND(:,k),JND_TP5.JND(:,k),JND_TP6.JND(:,k)],'o--','LineWidth',2)
    plot(x,yfit(:,k),'r-.');
    caption = sprintf([masker_type{k-4} ' ' bmld{2}], k);
    title(caption, 'FontSize', 12);
    ylim([0 15])
    xlim([0 25])
    legend('TP1','TP2','TP3','TP4','TP5','TP6','FontSize', 12)
    xlabel('Level above threshold (dB)','FontSize', 15);
    ylabel('JND (dB)','FontSize', 15);
end


%% correlation over the threshold above
rc = cell(1,N);
pc = cell(1,N);
for k = 1:N
    [rc{k} pc{k}] = corrcoef(x(1:length(stack_avg{k})), stack_avg{k},'rows','pairwise');
end

%% correlation of averaged JND and threshold above across conditions for individual TP

L = 6;
r = cell(1,L);
p = cell(1,L);

avg_cond = [mean(JND_TP1.JND,2,'omitnan'), mean(JND_TP2.JND,2,'omitnan'), ...
    mean(JND_TP3.JND,2,'omitnan'), mean(JND_TP4.JND,2,'omitnan'), ...
    mean(JND_TP5.JND,2,'omitnan'), mean(JND_TP6.JND,2,'omitnan')]

avg_th = [mean(th_above_vitr,2), mean(th_above_shob,2),...
    mean(th_above_hk,2), mean(th_above_hemi,2), mean(th_above_jotg,2),...
    mean(th_above_thom,2)];

for k = 1:L
    [r{k} p{k}] = corrcoef([avg_th(:,k) avg_cond(:,k)], 'rows','complete');
end

%% ranked thresholds
%load the thresholds of participants
th_jotg = load('JND_data_Jordi\threshold_jotg.mat')
th_jotg = round(th_jotg.average);
th_jotg(:,[1,5]) = [];

th_shob = load('JND_data_SHOB\threshold_shob.mat')
th_shob = round(th_shob.average);
th_shob(:,[1,5]) = [];

th_hemi = load('JND_data_HEMI\threshold_hemi.mat')
th_hemi = round(th_hemi.avg);
th_hemi(:,[1,5]) = [];

th_vitr = th_hemi;                                          %these threhsolds were given manually :(
th_v = round([53.6111111133333;
44.0555555566667;
49.5000000000000;
57.8333333333333;
39.2777777800000;
33.6111111100000;
38.6111111100000;
39.3333333333333]);
th_vitr(:,3) =th_v;


th_hk = th_hemi;                                            %these threhsolds were given manually :(
th_h = round([53.8333333333333;
43.1111111133333;
50.9444444433333;
61.1111111100000;
39.7222222233333;
32.6111111100000;
38.3888888900000;
49.1666666666667]);
th_hk(:,3) =th_h;

th_thom = load('JND_data_Thomas\tho_avg.mat')
th_thom = round(th_thom.avg);
th_thom(:,[1,5]) = [];

th_vitr = sortrows(th_vitr, 3);
th_shob = sortrows(th_shob, 3);
th_hk = sortrows(th_hk, 3);
th_hemi = sortrows(th_hemi, 3);
th_jotg = sortrows(th_jotg, 3);
th_thom = sortrows(th_thom, 3);

ranked_th = ([th_jotg, th_shob, th_hemi, th_vitr, th_hk, th_thom]);

%check if ranked thresholds for all the participants are the same:
f = 1;
for i = 1:3:length(ranked_th)-3
    if all(ranked_th(:, i)==ranked_th(:, i+3))&...
            all(ranked_th(:, i+1)==ranked_th(:, i+4))           %check if the sorted conditions and IPD are the same
    else 
        f = 0;
    end
end
if f == 1;                                                      %if the same, print the conditions
    ranked = ranked_th(:,[1,2])                         
else f == 0;                                                    %if not the same - display
    disp('Thresholds are not the same');
end


%% boxplot for ranked conditions

FCOMCOM_IPD0 = cat(1,JND_TP1.JND([2,3,4,5],4),JND_TP2.JND([2,3,4,5],4),JND_TP3.JND([2,3,4,5],4),JND_TP4.JND([2,3,4,5],4),JND_TP5.JND([2,3,4,5],4),JND_TP6.JND([2,3,4,5],4));
COMCOM_IPD180 = cat(1,JND_TP1.JND([2,3,4,5],6),JND_TP2.JND([2,3,4,5],6),JND_TP3.JND([2,3,4,5],6),JND_TP4.JND([2,3,4,5],6),JND_TP5.JND([2,3,4,5],6),JND_TP6.JND([2,3,4,5],6));

boxplot([COMCOM_IPD180,FCOMCOM_IPD0],'Labels',{'COMCOM IPD180','FCOMCOM IPD0'})
ylabel('JND (dB)','FontSize', 12)

%% Th_above for each participant 
above =  repmat([0;5;10;15;20;25], 1, 8);

th_above_vitr = above + repmat(th_v',6,1);
th_above_hk = above + repmat(th_h',6,1);
th_above_jotg = above + repmat(th_jotg(:,3)',6,1);
th_above_shob = above + repmat(th_shob(:,3)',6,1);
th_above_hemi = above + repmat(th_hemi(:,3)',6,1);
th_above_thom = above + repmat(th_thom(:,3)',6,1);
%% each TP: JNDs over the level where the sound was detected

th_above = cat(6,th_above_vitr, th_above_shob, th_above_hk,...
    th_above_hemi, th_above_jotg, th_above_thom);

JND_TP = cat(6, JND_TP1.JND, JND_TP2.JND, JND_TP3.JND,...
    JND_TP4.JND, JND_TP5.JND, JND_TP6.JND);

caption_TP = ["TP1","TP2","TP3","TP4","TP5","TP6"];

for m = 1:6
    figure()
    for k = 1:4
        colorcode = struct('blue',[0, 0.4470, 0.7410], 'orange',[0.8500, 0.3250, 0.0980],'yellow',[0.9290, 0.6940, 0.1250], 'purple',[0.4940, 0.1840, 0.5560]);
        colortext = [{[0, 0.4470, 0.7410]},{[0.8500, 0.3250, 0.0980]},{[0.9290, 0.6940, 0.1250]},[0.4940, 0.1840, 0.5560]];
        plot(th_above(:,k,1,1,1,m),JND_TP(:,k,1,1,1,m),'o-','Color', colortext{k},'LineWidth',2)
        hold on
        ylim([0 15])
    end
    for l = 5:8
        plot(th_above(:,l,1,1,1,m),JND_TP(:,l,1,1,1,m),'o--','Color', colortext{l-4},'LineWidth',2)
        ylim([0 15])
        legend('RANRAN IPD0','COMCOM IPD0','RANCOM IPD0','FCOMCOM IPD0','RANRAN IPD180',...
            'COMCOM IPD180','RANCOM IPD180','FCOMCOM IPD180')
        ylabel('JND (dB)');
        xlabel('Level (dB)');
    end
    title(caption_TP(m), 'FontSize', 12);
end









