%% Exercício 3
% 1 - Gerar um vetor representando ruído com distribuição normal utilizando a função 'rand' do Matlab. Gere 1 segundo de ruído considerando um tempo de amostragem de 1/10k. 
%
% 2 - Plotar o histograma do ruído para observar a distribuição gaussiana. Utilizar a função 'histogram'.
%
% 3 - Plotar o ruído no domínio do tempo e frequência.
%
% 4 - Utilizando a função 'xcorr', plote a função de autocorrelação do ruído.
%
% 5 - Utilizando a funçao 'filtro=fir1(50,(1000*2)/fs)', realize uma operação de filtragem passa baixa do ruído. Para visualizar a resposta em frequência do filtro projetado, utilize a função 'freqz'.
%
% 6 - Plote, no domínio do tempo e da frequência, a saída do filtro e o histograma do sinal filtrado.
%%
clear all
close all
clc

fs = 10e3; % frequencia de amostragem 10 mil amostras por segundo
ts = 1/fs;  %tempo de amostragem
fc = 1e3;  % frequencia de corte do filtro = banda passante -1k a 1k
n = 50; % ordem do filtro
t = 0:ts:1-ts; %vetor tempo
f = -fs/2: 1 : (fs/2)-1;

ruido = randn(1,fs); %criando o ruido
fft_ruido = fftshift(fft(ruido)/length(ruido)); %transformada do ruído

figure(1)
subplot(411)
hist(ruido,100)
title('Função densidade de probabilidade do ruído');xlim([-4 4]); ylim([0 400]);xlabel('[n]'); ylabel('r(n)');
subplot(412)
plot(t,ruido); ylim([-5 5]);xlabel('[t]'); ylabel('r(t)');title('Ruído no domínio do tempo');
subplot(413)
plot(f,abs(fft_ruido));
xlabel('[Hz]'); ylabel('R(f)');title('Ruído no domínio da frequência');xlim([-4e3 4e3]);ylim([-5e-3 4e-2]);
subplot(414)
t_autocorr = -1:ts:1-(2*ts);
plot(t_autocorr,xcorr(ruido)); ylim([-5e-3 12e3]);title('Autocorrelação'); % funcao autocorrelação do ruido

figure(2)
filtro  = fir1(n,(fc*2)/fs)'; 
freqz(filtro)

% A filtragem é utilizada para delimitar a potência do ruido
y = conv(ruido,filtro); %filtragem, usando a convolucao
y_f = fftshift(fft(y)/length(y));

figure(3)
subplot(311)
plot(t,y(1:end-50)); ylim([-5 5]);
xlabel('[t]'); ylabel('r(t)');title('Ruído filtrado no domínio do tempo');
subplot(312)
plot(f,abs(y_f(1:end-50)));
xlabel('[Hz]'); ylabel('R(f)');title('Ruído filtrado no domínio da frequência');
xlim([-4e3 4e3]);ylim([-5e-3 4e-2]);
subplot(313)
hist(y,100) %histograma
xlim([-4 4]); ylim([0 400]);title('Função densidade de probabilidade do ruído filtrado');xlabel('[n]'); ylabel('r(n)');
