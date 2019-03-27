%% Exerc�cio 3
% 1 - Gerar um vetor representando ru�do com distribui��o normal utilizando a fun��o 'rand' do Matlab. Gere 1 segundo de ru�do considerando um tempo de amostragem de 1/10k. 
%
% 2 - Plotar o histograma do ru�do para observar a distribui��o gaussiana. Utilizar a fun��o 'histogram'.
%
% 3 - Plotar o ru�do no dom�nio do tempo e frequ�ncia.
%
% 4 - Utilizando a fun��o 'xcorr', plote a fun��o de autocorrela��o do ru�do.
%
% 5 - Utilizando a fun�ao 'filtro=fir1(50,(1000*2)/fs)', realize uma opera��o de filtragem passa baixa do ru�do. Para visualizar a resposta em frequ�ncia do filtro projetado, utilize a fun��o 'freqz'.
%
% 6 - Plote, no dom�nio do tempo e da frequ�ncia, a sa�da do filtro e o histograma do sinal filtrado.
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
fft_ruido = fftshift(fft(ruido)/length(ruido)); %transformada do ru�do

figure(1)
subplot(411)
hist(ruido,100)
title('Fun��o densidade de probabilidade do ru�do');xlim([-4 4]); ylim([0 400]);xlabel('[n]'); ylabel('r(n)');
subplot(412)
plot(t,ruido); ylim([-5 5]);xlabel('[t]'); ylabel('r(t)');title('Ru�do no dom�nio do tempo');
subplot(413)
plot(f,abs(fft_ruido));
xlabel('[Hz]'); ylabel('R(f)');title('Ru�do no dom�nio da frequ�ncia');xlim([-4e3 4e3]);ylim([-5e-3 4e-2]);
subplot(414)
t_autocorr = -1:ts:1-(2*ts);
plot(t_autocorr,xcorr(ruido)); ylim([-5e-3 12e3]);title('Autocorrela��o'); % funcao autocorrela��o do ruido

figure(2)
filtro  = fir1(n,(fc*2)/fs)'; 
freqz(filtro)

% A filtragem � utilizada para delimitar a pot�ncia do ruido
y = conv(ruido,filtro); %filtragem, usando a convolucao
y_f = fftshift(fft(y)/length(y));

figure(3)
subplot(311)
plot(t,y(1:end-50)); ylim([-5 5]);
xlabel('[t]'); ylabel('r(t)');title('Ru�do filtrado no dom�nio do tempo');
subplot(312)
plot(f,abs(y_f(1:end-50)));
xlabel('[Hz]'); ylabel('R(f)');title('Ru�do filtrado no dom�nio da frequ�ncia');
xlim([-4e3 4e3]);ylim([-5e-3 4e-2]);
subplot(313)
hist(y,100) %histograma
xlim([-4 4]); ylim([0 400]);title('Fun��o densidade de probabilidade do ru�do filtrado');xlabel('[n]'); ylabel('r(n)');
