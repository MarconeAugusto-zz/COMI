% Modulacao 16-QAM 
clear all
close all
clc

N = 40; %fator de superamostragem
M = 16;

vpp = 2;    % escala de tensão
k = 4;  % qauntidade de bits do quantizador

fc = 10e3;  % frequência da portadora
fm = 2e3;   % frequência do sinal
fs = 8e3;   % frequência de amostragem

% Informação
info = randi([0,1],1,M);
info_rect = rectpulse(info, N); % sinal PAM
passo = ((2*length(info))/fs)/(length(info)*N);
t = 0:passo:((2*length(info))/fs)-passo;

% Amostragem e quantização do seno
x_n = sin(2*pi*fm*t); % amostras do seno
x_quant_1 = x_n + ((vpp/2) - (passo/2)); %x quantizado, desloca o sinal
x_quant_2 = x_quant_1/passo;
x_quant = round(x_quant_2); %arredondar o valor das amostras
x_bin1 = de2bi(x_quant); % converter decimal para binário
[linha, coluna] = size(x_bin1);
x_bin = reshape(transpose(x_bin1) , 1 , linha*coluna); %converte uma matriz(que era de 3 linhas) em um unico vetor, sequência binária
sinal_QAM = qammod(info_rect, M); % modulação 16-QAM

% cosseno e seno
s_fase = real(sinal_QAM);
s_quad = imag(sinal_QAM);
tx_f = cos(2*pi*fc*t).*s_fase;
tx_q = sin(2*pi*fc*t).*s_quad;
tx = tx_f - tx_q;
% plot
figure(1)
subplot(311)
plot(t, s_fase);grid minor;
title('Fase');xlabel('Tempo [s]');ylabel('Amplitude [V]')
subplot(312)
plot(t, s_quad);grid minor;
title('Quadratura');xlabel('Tempo [s]');ylabel('Amplitude [V]');ylim([0.5 3.5]);
subplot(313)
plot(t, tx);grid minor;
title('Sinal Modulado');xlabel('Tempo [s]');ylabel('Amplitude [V]')

% exponêncial = e^jwct
tx_exp = real(sinal_QAM.*exp(1i*2*pi*fc*t));
% plot
figure(2)
subplot(211)
plot(t, tx);grid minor;
title('Sinal Modulado (Seno/Cosseno)');xlabel('Tempo [s]');ylabel('Amplitude [V]')
subplot(212)
plot(t, tx_exp);grid minor;
title('Sinal Modulado (Exponêncial)');xlabel('Tempo [s]');ylabel('Amplitude [V]')

