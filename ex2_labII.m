%% Exercício II Laboratório II 
% Gerar 3 sinais (cosenos) nas frequências 1k, 2k e 3k
%
% Realizar a multiplexação dos sinais para as frequências 10k, 12k e 14k para a transmissão em um canal de comunicação
%
% Recuperar os sinais originais
%%
%clear all;
clc;
close all;

%Declaração dos sinais
fa = 100e3; %frequencia de amostragem
f1 = 1e3;   %1000
f2 = 2e3;   %2000
f3 = 3e3;   %3000
A = 1; %amplitude dos sinais

t = 0:1/fa:5*(1/1e3); %vetor tempo
f = -fa/2:200:fa/2;  %vetor da frequência

x_t1 = A*cos(2*pi*t*f1);    %sinal 1
x_t2 = A*cos(2*pi*t*f2);    %sinal 2
x_t3 = A*cos(2*pi*t*f3);    %sinal 3

% Transformada de fourier dos sinais
X_f1 = fftshift(fft(x_t1)/length(x_t1));
X_f2 = fftshift(fft(x_t2)/length(x_t2));
X_f3 = fftshift(fft(x_t3)/length(x_t3));

% Declaração das portadoras
fp1 = 9e3;  %frequência portadora 1
fp2 = 10e3; %frequencia portadora 2
fp3 = 11e3; %frequencia portadora 3 
c_t1 = A*cos(2*pi*t*fp1); %portadora 1
c_t2 = A*cos(2*pi*t*fp2); %portadora 2
c_t3 = A*cos(2*pi*t*fp3); %portadora 3

% Multiplexando os sinais
mult_1 = x_t1 .* c_t1;
mult_2 = x_t2 .* c_t2;
mult_3 = x_t3 .* c_t3;

% Transformada de fourier dos sinais modulados
X_s1 = fftshift(fft(mult_1)/length(mult_1));
X_s2 = fftshift(fft(mult_2)/length(mult_2));
X_s3 = fftshift(fft(mult_3)/length(mult_3));

% Projetando os filtros
n = 51;           %ordem 50
wc_pf =[(9e3/(fa/2)) (11e3/(fa/2))]; % 9 a 11 Khz
filtro_PF = fir1(n-1,wc_pf,'bandpass',rectwin(n));   %filtro passa faixa
[Hr_pf,wr_pf] = freqz(filtro_PF, 1);

wc_pf2 =[(11e3/(fa/2)) (13e3/(fa/2))]; % 11 a 13 Khz
filtro_PF2 = fir1(n-1,wc_pf2,'bandpass',rectwin(n));   %filtro passa faixa
[Hr_pf2,wr_pf2] = freqz(filtro_PF2, 1);

wc_pf3 =[(13e3/(fa/2)) (15e3/(fa/2))]; % 13 a 15 Khz
filtro_PF3 = fir1(n-1,wc_pf3,'bandpass',rectwin(n));   %filtro passa faixa
[Hr_pf3,wr_pf3] = freqz(filtro_PF3, 1);

% filtrando os sinais
y_1 = filter(filtro_PF,1,mult_1);
y_2 = filter(filtro_PF2,1,mult_2);
y_3 = filter(filtro_PF3,1,mult_3);

% plotando os sinais
figure(1)
subplot(4,1,1)
plot(t,x_t1,'g'); grid minor; ylim([-2 2]); xlim([0 3e-3]); title('Sinal no tempo'); xlabel('[t]'); ylabel('cos_1(t)');
subplot(4,1,2)
plot(t,c_t1,'g'); grid minor; ylim([-2 2]); xlim([0 3e-3]); title('Portadora no tempo'); xlabel('[t]'); ylabel('c_1(t)');
subplot(4,1,3)
hold on;
plot(t,mult_1,'g'); grid minor; ylim([-2 2]); xlim([0 3e-3]); title('Sinal modulado'); xlabel('[t]'); ylabel('c_1(t)');
plot(t,x_t1,'--black');
hold off;
subplot(4,1,4)
plot(f,abs(X_s1),'g'); grid minor; ylim([0 0.5]);xlim([-1.5e4 1.5e4]); title('Sinal modulado na frequência');...
    xlabel('[Hz]'); ylabel('C_1(f)');

figure(2)
subplot(4,1,1)
plot(t,x_t2,'b'); grid minor; ylim([-2 2]); xlim([0 3e-3]); title('Sinal no tempo'); xlabel('[t]'); ylabel('cos_2(t)')
subplot(4,1,2)
plot(t,c_t2,'b'); grid minor; ylim([-2 2]); xlim([0 3e-3]); title('Portadora no tempo'); xlabel('[t]'); ylabel('c_2(t)')
subplot(4,1,3)
hold on;
plot(t,mult_2,'b'); grid minor; ylim([-2 2]); xlim([0 3e-3]); title('Sinal modulado'); xlabel('[t]'); ylabel('c_2(t)')
plot(t,x_t2,'--black');
hold off;
subplot(4,1,4)
plot(f,abs(X_s2),'b'); grid minor; ylim([0 0.5]);xlim([-1.5e4 1.5e4]);title('Sinal modulado na frequência');...
    xlabel('[Hz]'); ylabel('C_2(f)');

figure(3)
subplot(4,1,1)
plot(t,x_t3,'r'); grid minor; ylim([-2 2]); xlim([0 3e-3]); title('Sinal no tempo'); xlabel('[t]'); ylabel('cos_3(t)')
subplot(4,1,2)
plot(t,c_t3,'r'); grid minor; ylim([-2 2]); xlim([0 3e-3]); title('Portadora no tempo'); xlabel('[t]'); ylabel('c_3(t)')
subplot(4,1,3)
hold on;
plot(t,mult_3,'r'); grid minor; ylim([-2 2]); xlim([0 3e-3]); title('Sinal modulado'); xlabel('[t]'); ylabel('c_3(t)')
plot(t,x_t3,'--black');
hold off;
subplot(4,1,4)
plot(f,abs(X_s3),'r'); grid minor; ylim([0 0.5]);xlim([-1.5e4 1.5e4]);title('Sinal modulado na frequência');...
    xlabel('[Hz]'); ylabel('C_1(f)');

% resposta em frequencia dos filtros
figure(4)
subplot(311)
plot(wr_pf*fa/(2*pi),20*log10(abs(Hr_pf)));grid minor;  %resposta em frequência do filtro passa faixa
ylim([-100 10]);xlim([6e3 20e3]);title('Resposta em frequência passa faixa');xlabel('Hertz');ylabel('(db)');
subplot(312)
plot(wr_pf2*fa/(2*pi),20*log10(abs(Hr_pf2)));grid minor;  %resposta em frequência do filtro passa faixa
ylim([-100 10]);xlim([6e3 20e3]);title('Resposta em frequência passa faixa');xlabel('Hertz');ylabel('(db)');
subplot(313)
plot(wr_pf3*fa/(2*pi),20*log10(abs(Hr_pf3)));grid minor;  %resposta em frequência do filtro passa faixa
ylim([-100 10]);xlim([6e3 20e3]);title('Resposta em frequência passa faixa');xlabel('Hertz');ylabel('(db)');

%somando os sinais em um uníco canal de transmissão
canal = y_1 + y_2 + y_3;
figure(5)
subplot(421)
plot(t,canal);title('Canal de comunicação no tempo');xlabel('c(t)');ylabel('(t)');grid minor;
subplot(422)
Canal_f = fftshift(fft(canal)/length(canal));
plot(f,abs(Canal_f));title('Canal de comunicação no frequência');xlabel('(Hz)'); ...
    ylabel('C(f)');xlim([-0.4e5 0.4e5]);ylim([0 0.3]);grid minor;

%filtrando os sinais na recepção
y_r1 = filter(filtro_PF,1,canal);
y_r2 = filter(filtro_PF2,1,canal);
y_r3 = filter(filtro_PF3,1,canal);

subplot(412)
plot(f,abs(fftshift(fft(y_r1)/length(y_r1))),'g'); xlim([-0.4e5 0.4e5]);ylim([0 0.3]);grid minor;
title('Sinal filtrado na recepção');xlabel('(Hz)');ylabel('Y1(f)')
subplot(413)
plot(f,abs(fftshift(fft(y_r2)/length(y_r2))),'b'); xlim([-0.4e5 0.4e5]);ylim([0 0.3]);grid minor;
title('Sinal filtrado na recepção');xlabel('(Hz)');ylabel('Y2(f)')
subplot(414)
plot(f,abs(fftshift(fft(y_r3)/length(y_r3))),'r'); xlim([-0.4e5 0.4e5]);ylim([0 0.3]);grid minor;
title('Sinal filtrado na recepção');xlabel('(Hz)');ylabel('Y3(f)')

%multiplicando os sinais pela portadora para sua recuperação
mult_1r = y_r1 .* c_t1;
mult_2r = y_r2 .* c_t2;
mult_3r = y_r3 .* c_t3;

figure(6)
subplot(311)
plot(f,abs(fftshift(fft(mult_1r)/length(mult_1r))),'g');grid minor;
title('Sinal 1 demodulado');xlabel('(Hz)');ylabel('Y1D(f)');ylim([0 0.15]);xlim([-0.4e5 0.4e5]);
subplot(312)
plot(f,abs(fftshift(fft(mult_2r)/length(mult_2r))),'b');grid minor;
title('Sinal 2 demodulado');xlabel('(Hz)');ylabel('Y2D(f)');ylim([0 0.15]);xlim([-0.4e5 0.4e5]);
subplot(313)
plot(f,abs(fftshift(fft(mult_3r)/length(mult_3r))),'r');grid minor;
title('Sinal 3 demodulado');xlabel('(Hz)');ylabel('Y3D(f)');ylim([0 0.15]);xlim([-0.4e5 0.4e5]);

%filtragem do sinal com filtro passa baixa para recuperar por completo a informação
%projetando o filtros passa baixa
f_low = fir1(n-1,(5e3/(fa/2)));
[Hr_low,wr_low] = freqz(f_low, 1);

figure(7)
subplot(411)
plot(wr_low*fa/(2*pi),20*log10(abs(Hr_low)));grid minor;
ylim([-100 10]);xlim([0 10e3]);title('Resposta em frequência passa paixa');xlabel('Hertz');ylabel('(db)');

x_trans_1 = filter(f_low,1,mult_1r);
x_trans_2 = filter(f_low,1,mult_2r);
x_trans_3 = filter(f_low,1,mult_3r);

subplot(423)
plot(t,x_trans_1,'g');ylim([-0.3 0.3]);grid minor;
title('Sinal recuperado no domínio do tempo');xlabel('(t)');ylabel('cos_1(t)');
subplot(424)
plot(f,abs(fftshift(fft(x_trans_1)/length(x_trans_1))),'g');xlim([-5e3 5e3]);ylim([0 0.12]);grid minor;
title('Sinal recuperado no domínio da freqência');xlabel('(Hz)');ylabel('Cos_1(f)');
subplot(425)
plot(t,x_trans_2,'b');ylim([-0.3 0.3]);grid minor;
title('Sinal recuperado no domínio do tempo');xlabel('(t)');ylabel('cos_2(t)');
subplot(426)
plot(f,abs(fftshift(fft(x_trans_2)/length(x_trans_2))),'b');xlim([-5e3 5e3]);ylim([0 0.12]);grid minor;
title('Sinal recuperado no domínio da freqência');xlabel('(Hz)');ylabel('Cos_2(f)');
subplot(427)
plot(t,x_trans_3,'r');ylim([-0.3 0.3]);grid minor;
title('Sinal recuperado no domínio do tempo');xlabel('(t)');ylabel('cos_3(t)');
subplot(428)
plot(f,abs(fftshift(fft(x_trans_3)/length(x_trans_3))),'r');xlim([-5e3 5e3]);ylim([0 0.12]);grid minor;
title('Sinal recuperado no domínio da freqência');xlabel('(Hz)');ylabel('Cos_3(f)');
