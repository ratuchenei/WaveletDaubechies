//-- Transformada Wavelet de  Daubechies de 4o. nível

clear
clc


//-- Setup do sinal original ---------------------------------------------------

f = [4 6 10 12 8 6 5 5];


//-- Inicialização de variáveis ------------------------------------------------

N = length(f);

V1 = zeros(N,1);
W1 = zeros(N,1);

a = zeros(1, 4);
b = zeros(1, 4);

A1 = zeros(1, N/2);
D1 = zeros(1, N/2);

V21 = zeros(N+2,1);
V22 = zeros(N+6,1);

W21 = zeros(N+2,1);
W22 = zeros(N+6,1);

v2 = zeros(N+6,1);
v1 = zeros(N+2, 1);

w2 = zeros(N+6,1);
w1 = zeros(N+2, 1);

//-- Números de escala ---------------------------------------------------------

a(1) = (1+sqrt(3))/(4*sqrt(2));
a(2) = (3+sqrt(3))/(4*sqrt(2));
a(3) = (3-sqrt(3))/(4*sqrt(2));
a(4) = (1-sqrt(3))/(4*sqrt(2));


//-- Números de wavelet --------------------------------------------------------

b = flipdim(a,2,1);
b(2) = b(2)*(-1);
b(4) = b(4)*(-1);


//-- Cálculo de sinais de escala e número de wavelet de 1o. nível --------------

V1(1:4) = V1(1:4) + a';
W1(1:4) = W1(1:4) + b';

v = V1;
w = W1;

v1(1:4) = V1(1:4);
v2(1:8) = circshift(V1, 4);

w1(1:4) = V1(1:4);
w2(1:8) = circshift(V1, 4);


//-- Daub4 (1o. nível) ---------------------------------------------------------

for m = 1 : N/2 
    A1(m)= f * v;   
    D1(m)= f * w;   // Detalhe (1o. nível)
    
    v = circshift(v, 2);
    w = circshift(w, 2);
end    


//-- Cálculo de sinais de escala e número de wavelet de 2o. nível --------------

for m = 1 : N/2
    V21 = V21 +  a(m)*v1;
    V22 = V22 + a(m)*v2;

    W21 = W21 +  b(m)*w1;
    W22 = W22 + b(m)*w2;

    v1 = circshift(v1, 2);
    v2 = circshift(v2, 2);
    
    w1 = circshift(w1, 2);
    w2 = circshift(w2, 2);
end


//-- Daub4 (2o nível) ----------------------------------------------------------

A2 = [f * V21(1:8),  f * V22(1:8)];


//-- Detalhe (2o nível) --------------------------------------------------------

D2 = [f * W21(1:8), f * W22(1:8)]





/*

RESULTADOS:


--> A1: primeiro subsinal da média
 A1  = 

   7.6394739   15.884519   9.3564729   6.7175144


--> D1: primeiro detalhe
 D1  = 

   0.7071068  -0.1894687  -0.6123724  -1.3194792


--> A2: segundo subsinal da média
 A2  = 

   18.220671   10.037659


--> D2: segundo detalhe
 D2  = 

   0.0915064  -2.6895826



*/


