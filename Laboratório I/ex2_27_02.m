%% Exercício 3
% 1 - Gerar um sinal s(t) composto pela somatória de 3 senos com amplitudes 5V,5/3V e 1 V e frequências de 1,3 e 5kHz, respectivamente. 
%
% 2 - Plotar em uma figura os três senos e o sinal s no domínio do tempo e da frequência.
%
% 3 - Gerar 3 filtros ideais:
%       - Passa baixa ( frequência de corte em 2kHz ).
%       - Passa alta ( banda de passagem acima de 4kHz ).
%       - Passa faixa ( banda de passagem entre 2 e 4kHz ).
%
% 4 - Plotar em uma figura a resposta em freqência dos 3 filtros.
%
% 5 - Passar o sinal s(t) através dos 3 filtros e plotar as saídas, no domínio do tempo e da frequência, para os 3 casos.
%
%%
%clear all;
clc;
close all;

fa = 50e3; %frequencia de amostragem 50 mil amostras por segundo
f1 = 1e3;   %1000
f2 = 3e3;   %3000
f3 = 5e3;   %5000

t = 0:1/fa:5*(1/1e3);
f = -fa/2:200:fa/2;

%Declaração dos sinais
x_t1 = 5*sin(2*pi*t*f1); % sinal 1
x_t2 = 5/3*sin(2*pi*t*f2);  %sinal 2
x_t3 = sin(2*pi*t*f3);  %sinal 3
x_t = x_t1 + x_t2 + x_t3;   %soma dos sinais

%transformada do sinal
X_f = fft(x_t)/length(x_t); 
X_f_shift = fftshift(X_f);

%plotando os sinais gerados no domínio do tempo e frequência
figure(1)
subplot(311)
plot(t,x_t1,'g',t,x_t2,'b',t,x_t3,'r'); grid minor; ylim([-6 6]);xlabel('[t]');ylabel('seno(t)');title('Sinais gerados');
legend('1 kHz','3 kHz','5 kHz');
subplot(312)
plot(t, x_t); grid minor; xlabel('[t]'); ylabel('s(t)'); ylim([-6 6]); title('Soma dos sinais no domínio do tempo');
subplot(313)
plot(f, abs(X_f_shift)); grid minor; xlabel('[Hz]'); ylabel('S(f)'); xlim([-6e3 6e3]); ylim([0 3]); title('Soma dos sinais no domínio da frequência');

%projetando os filtros ideais
filtro_pb = ([zeros(1,115) ones(1,21) zeros(1, 115)]);%passa baixa
filtro_pa = ([ones(1,105) zeros(1,41) ones(1,105)]);%passa alta
filtro_pf = ([zeros(1,105) ones(1,11) zeros(1,19) ones(1,11) zeros(1,105)]);%passa faixa

%plotando os filtros
figure(2)
subplot(311)
plot(f,filtro_pb); ylim([0 1.5]); grid minor; xlim([-7e3 7e3]); title('Filtro passa baixa ideal');xlabel('[Hz]');ylabel('H1(f)');
subplot(312)
plot(f,filtro_pa); ylim([0 1.5]); grid minor; xlim([-7e3 7e3]); title('Filtro passa alta ideal');xlabel('[Hz]');ylabel('H2(f)');
subplot(313)
plot(f,filtro_pf); ylim([0 1.5]); grid minor; xlim([-7e3 7e3]); title('Filtro passa faixa ideal');xlabel('[Hz]');ylabel('H3(f)');

%filtragem
Y1 = X_f_shift .* filtro_pb;
Y2 = X_f_shift .* filtro_pa;
Y3 = X_f_shift .* filtro_pf;

%voltando o sinal para o domínio do tempo
y1 = ifft(ifftshift(Y1));
y2 = ifft(ifftshift(Y2));
y3 = ifft(ifftshift(Y3));

%plotando o sinal filtrado
figure(3)
subplot(321)
plot(f,abs(Y1));ylim([0 2.6]); grid minor; xlim([-6e3 6e3]);title('Sinal filtrado no filtro passa baixa');xlabel('[Hz]');ylabel('Y1(f)');
subplot(322)
plot(t,y1); grid minor; ylim([-0.025 0.025]);title('Sinal filtrado no filtro passa baixa');xlabel('[t]');ylabel('y1(t)');
subplot(323)
plot(f,abs(Y3));ylim([0 2.6]); grid minor;xlim([-6e3 6e3]);title('Sinal filtrado no filtro passa faixa');xlabel('[Hz]');ylabel('Y2(f)');
subplot(324)
plot(t,y3); grid minor;ylim([-0.025 0.025]);title('Sinal filtrado no filtro passa faixa');xlabel('[t]');ylabel('y2(t)');
subplot(325)
plot(f,abs(Y2));ylim([0 2.6]); grid minor;xlim([-6e3 6e3]);title('Sinal filtrado no filtro passa alta');xlabel('[Hz]');ylabel('Y3(f)');
subplot(326)
plot(t,y2); grid minor;ylim([-0.025 0.025]);title('Sinal filtrado no filtro passa alta');xlabel('[t]');ylabel('y3(t)');

% convolução no tempo = multiplicação na frequência