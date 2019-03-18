%% Exercício 1
% 1 - Gerar um sinal s(t) composto pela somatória de 3 senos com amplitudes de 6V, 2V e 4V e frequências de 1, 3 e 5 kHz, respectivamente.
%
% 2 - Plotar em uma figura os três cossenos e o sinal 's ' no domínio do tempo e da frequência.
%
% 3 - Utilizando a função 'norm', determine a potência média do sinal 's'.
%
% 4 - Utilizando a função 'pwelch', plote a Densidade Espectral de Potência do sinal 's'.
%%
%clear all;
clc;
close all;

fa = 100e3; %frequencia de amostragem
f1 = 1e3;   %1000
f2 = 3e3;   %3000
f3 = 5e3;   %5000

t = 0:1/fa:5*(1/1e3); %vetor tempo
f = -fa/2:200:fa/2;  
f_aux = 0:10:fa;

x_t1 = 6*sin(2*pi*t*f1);    %sinal 1
x_t2 = 2*sin(2*pi*t*f2);    %sinal 2
x_t3 = 4*sin(2*pi*t*f3);    %sinal 3

x_t = x_t1 + x_t2 + x_t3;   %soma de sinais

X_f = fft(x_t)/length(x_t); %trasformada de fourier
X_f_shift = fftshift(X_f);

figure(1)
subplot(311)
plot(t,x_t1,'g',t,x_t2,'b',t,x_t3,'r'); grid minor;ylim([-7 7]);title('Sinais gerados');xlabel('[t]'); ylabel('seno(t)'); legend('1 kHz','3 kHz','5 kHz');
subplot(312)
plot(t, x_t); grid minor;xlabel('[t]'); ylabel('s(t)');title('Soma dos sinais no domínio do tempo');
subplot(313)
plot(f, abs(X_f_shift)); grid minor;title('Soma dos sinais no domínio da frequência');xlabel('[Hz]'); ylabel('S(f)');xlim([-6e3 6e3]); ylim([0 4]);

%cálculo da norma = media do vetor
%norma ao quadrado = energia
%energia dividida pelo tempo = potência do sinal

norma = (norm(x_t)^2)/length(t);
string = ['Norma: ', num2str(norma)];
disp(string);
figure(2)
pwelch(x_t,[],[],[],fa); grid minor;



