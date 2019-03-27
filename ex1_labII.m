%% %% Exercício I Laboratório II 
% Realizar um processo de modulação AM DSB e AM DSB-SC.
%
% Para o caso da modulação AM DSB-SC, realizar o processo de demodulação utilizando a função 'fir1'.
%
% Para o caso da modulaçao AM DSB, variar o 'fator de modulação' (0.25 ; 0.5 ; 0.75 ; 1 e 1.5) e observar os efeitos no sinal modulado.
%%
%clear all
close all
clc

Ac = 1;
Am = 1;
fc = 30e3;  %frequência portadora
fm = 1e3;   %frequência sinal
fa = 20*fc; %frequência de amostragem
t = 0:1/fa:1; %tempo
n = 100; %ordem do filtro
f_cut = 2e3;

% AM DSB SC

c_t = Ac*cos(2*pi*fc*t);
m_t = Am*cos(2*pi*fm*t);
s_t = c_t .* m_t;   %sinal modulado
r_t = s_t .* c_t;   %sinal demodulado

filtro_pb = fir1(100,(f_cut*2)/fa,'low');
info = filter(filtro_pb,1,r_t);

figure(1)
subplot(511)
plot(t,m_t); grid minor;
title('Informação'); ylim([-1.5 1.5]); xlim([0 2/fm]);xlabel('[t]'); ylabel('m(t)');
subplot(512)
plot(t,c_t); grid minor;
title('Portadora'); ylim([-1.5 1.5]);xlim([0 2/fm]);xlabel('[t]'); ylabel('c(t)');
subplot(513)
plot(t,s_t); grid minor;
hold on;
title('Sinal modulado'); ylim([-1.5 1.5]);xlim([0 2/fm]);xlabel('[t]'); ylabel('s(t)');
plot(t,m_t,'--red');
hold off;
subplot(514)
plot(t,r_t); grid minor;
hold on;
title('Sinal demodulado'); ylim([-1.5 1.5]);xlim([0 2/fm]);xlabel('[t]'); ylabel('s2(t)');
plot(t,m_t,'--red');
hold off;
subplot(515)
plot(t,info); grid minor;
title('Sinal demodulado'); ylim([-1.5 1.5]);xlim([0 2/fm]);xlabel('[t]'); ylabel('s3(t)');

% AM DSB

Ac = 1; % amplitude da portadora
fc = 30e3;  %frequência portadora
Am = 1; % amplitude do sinal
fm = 1e3;   %frequência sinal
fa = 20*fc; %frequência de amostragem
t = 0:1/fa:1; %tempo
% m = 0.25; %Indice de modulação
% string = ['Fator de modulação: ', num2str(m)];
% disp(string);
%A0 = Am/m; %nível dc

c_t = Ac*cos(2*pi*fc*t);    %portadora
m_t = Am*cos(2*pi*fm*t);     %sinal

m_t_DC = m_t + Am/0.25;  %0,25
m_t_DC2 = m_t + Am/0.50;  %0,5
m_t_DC3 = m_t + Am/0.75;  %0,75
m_t_DC4 = m_t + Am/1;  %1
m_t_DC5 = m_t + Am/1.5;  %1.5

s_t_dsb = (m_t_DC).*c_t;  %0,25
s_t_dsb2 = (m_t_DC2).*c_t;  %0,5
s_t_dsb3 = (m_t_DC3).*c_t;  %0,75
s_t_dsb4 = (m_t_DC4).*c_t;  %1
s_t_dsb5 = (m_t_DC5).*c_t;  %1,5

figure(2)
subplot(321)
plot(t,m_t);title('Sinal');xlabel('[t]'); ylabel('m(t)'); ylim([-3 3]); xlim([0 2/fm]); grid minor;
subplot(322)
plot(t,c_t);title('Portadora');xlabel('[t]'); ylabel('c(t)'); ylim([-2 2]); xlim([0 1/fm]); grid minor;
subplot(323)
plot(t,m_t_DC);title('Sinal + DC');xlabel('[t]'); ylabel('m(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
subplot(324)
hold on;
plot(t,s_t_dsb);title('Modulação AM DSB fator 0,25');xlabel('[t]'); ylabel('s(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
plot(t,m_t_DC,'--red');
hold off;
subplot(325)
plot(t,m_t_DC2);title('Sinal + DC');xlabel('[t]'); ylabel('m(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
subplot(326)
hold on;
plot(t,s_t_dsb2);title('Modulação AM DSB fator 0,5');xlabel('[t]'); ylabel('s(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
plot(t,m_t_DC2,'--red');
hold off;
figure(3)
subplot(321)
plot(t,m_t_DC3);title('Sinal + DC');xlabel('[t]'); ylabel('m(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
subplot(322)
hold on;
plot(t,s_t_dsb3);title('Modulação AM DSB fator 0,75');xlabel('[t]'); ylabel('s(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
plot(t,m_t_DC3,'--red');
hold off;
subplot(323)
plot(t,m_t_DC4);title('Sinal + DC');xlabel('[t]'); ylabel('m(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
subplot(324)
hold on;
plot(t,s_t_dsb4);title('Modulação AM DSB fator 1');xlabel('[t]'); ylabel('s(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
plot(t,m_t_DC4,'--red');
hold off;
subplot(325)
plot(t,m_t_DC5);title('Sinal + DC');xlabel('[t]'); ylabel('m(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
subplot(326)
hold on;
plot(t,s_t_dsb5);title('Modulação AM DSB fator 1,5');xlabel('[t]'); ylabel('s(t)'); ylim([-6 6]); xlim([0 2/fm]); grid minor;
plot(t,m_t_DC5,'--red');
hold off;
