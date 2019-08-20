clear all;
close all;
clc

% Dados
fc = 10e3;
N = 100;
qtd_info = 20;

% Informação
info = randi([0,1],1,qtd_info);
info_format = rectpulse(info, N);
passo = (2*length(info)/fc)/(length(info)*N);
t = [0:passo:(2*length(info)/fc)-passo];

% Sinal
x_t_FSK = cos(2*pi*t*fc.*(info_format+1));
x_f_FSK = fftshift(fft(x_t_FSK)/length(x_t_FSK));
fa = 1/passo;

% Plot 1
figure(1)
subplot(211)
plot(t,info_format);ylim([-0.2 1.2]);xlim([0 2e-3]);grid minor;
title('Informação');
xlabel('t(s)'); ylabel('Amplitude (V)');
subplot(212)
plot(t,x_t_FSK); grid minor;xlim([0 0.002]);ylim([-1.2 1.2]);
title('Sinal BFSK');
xlabel('t(s)'); ylabel('Amplitude (V)');

% Filtros passa faixa
pf_10 = fir1(100,([5e3 15e3]*2)/fa);
pf_20 = fir1(100,([15e3 25e3]*2)/fa);

% Sinal filtrado
info_10 = filter(pf_10,1,x_t_FSK);
info_20 = filter(pf_20,1,x_t_FSK);

% Plot 2
figure(2)
subplot(211)
plot(t, info_10);ylim([-1.2 1.2]);grid minor;
title('Frequência 10 KHz');
xlabel('t(s)'); ylabel('Amplitude (V)');
subplot(212)
plot(t, info_20);ylim([-1.2 1.2]);grid minor;
title('Frequencia 20 KHz');
xlabel('t(s)'); ylabel('Amplitude (V)');

% valor absoluto dos sinais
abs_10 = abs(info_10);
abs_20 = abs(info_20);

% Plot 3
figure(3)
subplot(211)
plot(t, abs_10);ylim([-0.2 1.2]);grid minor;
title('Valor absoluto do sinal de 10 KHz');
xlabel('t(s)'); ylabel('Amplitude (V)');
subplot(212)
plot(t, abs_20);ylim([-0.2 1.2]);grid minor;
title('Valor absoluto do sinal de 20 KHz');
xlabel('t(s)'); ylabel('Amplitude (V)');

% Filtros passa baixa
pb_10 = fir1(100,(5e3*2)/fa);
pb_20 = fir1(100,(10e3*2)/fa);

% Sinal filtrado
info_10_out = filter(pb_10,1,abs_10);
info_20_out = filter(pb_20,1,abs_20);

% Plot 4
figure(4)
subplot(211)
plot(t, info_10_out);ylim([-0.2 0.8]);grid minor;
title('Envoltória de 10 KHz');
xlabel('t(s)'); ylabel('Amplitude (V)');
subplot(212)
plot(t, info_20_out);ylim([-0.2 0.8]);grid minor;
title('Envoltória de 20 KHz');
xlabel('t(s)'); ylabel('Amplitude (V)');