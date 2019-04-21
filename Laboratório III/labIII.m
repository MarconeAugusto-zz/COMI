%% Laborat�rio III

%clear all
close all
clc

filename = 'SistemasI.wav'; 

[x_n_in,fa] = audioread(filename);
x_n = x_n_in(:,1);  %pegando apenas a primeira coluna do vetor, som stereo

vpp = 2; % escala de tens�o
k = 5; % quantidade de bits do quantizador
passo_quant = vpp/(2^k); % passo de quantiza��o

intervalo = (size(x_n,1)/fa) - (1/fa);
t = 0: 1/fa : intervalo;
f = -fa/2 : 1/intervalo : fa/2; 

figure(1)
subplot(211)
plot(t,x_n'); xlim([0 intervalo]); title('Sinal de entrada no dom�nio do tempo');xlabel('t');ylabel('s(t)');ylim([-0.5 0.5]);grid minor;
X_in = fft(x_n);
subplot(212)
plot(f,(abs(fftshift((X_in))))); xlim([0 8e3]);xlabel('f');ylabel('S(f)');title('Sinal de entrada no dom�nio da freq�ncia');grid minor;

x_quant_1 = x_n + ((vpp/2) - (passo_quant/2)); %x quantizado, desloca o sinal
x_quant_2 = x_quant_1/passo_quant;
x_quant_3 = round(x_quant_2); %arredondar o valor das amostras

%pontos criticos da amplitudes, retirando as amplitudes m�ximas e m�nimas
aux1 = x_quant_3 == 2^k;
aux2 = x_quant_3 == -1; 
x_quant_4 = x_quant_3 - aux1;   % ajusta o m�ximo at� 2^k -1
x_quant = x_quant_4 + aux2;   % ajusta m�nimo em zero

x_bin1 = de2bi(x_quant); % converter decimal para bin�rio
[linha, coluna] = size(x_bin1);
x_bin = reshape(transpose(x_bin1) , 1 , linha*coluna); %converte uma matriz(que era de 3 linhas) em um unico vetor, sequ�ncia bin�ria

%voltando para as amostras
x_dec1 = reshape(x_bin, coluna, linha); % converte um vetor em uma matriz
x_dec2 = transpose(x_dec1);
x_dec = bi2de(x_dec2); % converter bin�rio para 

%recuperar o sinal
x_n_rec_1 = x_dec * passo_quant;
x_n_rec = x_n_rec_1 - ((vpp/2) - (passo_quant/2));

figure(2)
%subplot(211)
hold on;
title('Sinal de entrada e sinal modulado por codifica��o de pulso')
plot(t,x_n,'--black'); grid minor;
plot(t,x_n_rec,'green');xlim([0.7 0.705]);xlabel('t');ylabel('v(t)')
legend('Sinal de entrada','PCM');
hold off;
Xn = fftshift(fft(x_n));
Xn_rec = fftshift(fft(x_n_rec));

% projetando o filtro passa baixa
f_cut = 2e3;
filtro_pb = fir1(50,(f_cut*2)/fa,'low');
[Hr,wr] = freqz(filtro_pb, 1);

% filtrando o sinal
y = filter(filtro_pb,1,x_n_rec);
Y = fftshift(fft(y));

figure(3)
subplot(321)
plot(f,abs(Xn));xlim([0 8e3]);xlabel('f');ylabel('S(f)');title('Sinal de entrada no dom�nio da frequ�ncia');grid minor;
subplot(322)
plot(f,abs(Xn_rec));xlim([0 8e3]);xlabel('f');ylabel('S(f)');title('Sinal recuperado antes da filtragem no dom�nio da frequ�ncia');grid minor;
subplot(3,2,[3 4])
plot(wr*fa/(2*pi),20*log10(abs(Hr)));grid minor;  %resposta em frequ�ncia do filtro passa faixa
ylim([-100 10]);xlim([0 8e3]);title('Resposta em frequ�ncia do filtro passa baixa');xlabel('Hertz');ylabel('(db)');
subplot(325)
plot(t,y);ylim([-0.5 0.5]);title('Sinal filtrado no dom�nio do tempo');xlabel('t');ylabel('s(t)'); xlim([0 intervalo]);grid minor;
subplot(326)
plot(f,(abs(Y))); xlim([0 4e3]);xlabel('f');ylabel('S(f)');title('Sinal filtrado no dom�nio da frequ�ncia');grid minor;

sound(y,fa);

