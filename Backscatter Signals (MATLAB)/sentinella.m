clc
clear all
close all

[fn pe] = uigetfile(['./*.tif'],'MultiSelect','on');
a       = double(importdata([pe fn]));

vh     = complex(a(:,:,1),a(:,:,2));
vv     = complex(a(:,:,4),a(:,:,5));
lat    = a(:,:,7);
lon    = a(:,:,8);

vv2    = abs(vv).^2;
vh2    = abs(vh).^2;
figure(1),imagesc(10*log10(vv2)),colormap(gray), colorbar

bw     = roipoly();

vv_r   = vv((vv.*bw)~=0);
vh_r   = vh((vh.*bw)~=0);

%%speckle Gauss plane
figure(2),
scatter(real(vv_r),imag(vv_r));
hold on
scatter(real(vh_r),imag(vh_r));
legend('VV','VH')
xlabel('Real part speckle'),
ylabel('Imaginary part speckle')

%%speckle modulus and phase
figure(3),
vv_m   = abs(vv_r);
vh_m   = abs(vh_r);

histogram(vv_m,100,'normalization','pdf')
hold on
histogram(vh_m,100,'normalization','pdf')
legend('VV','VH')
xlabel('Amplitude speckle'),
ylabel('probability density')

%%speckle phase
figure(4),
vv_p   = angle(vv_r);
vh_p   = angle(vh_r);

histogram(vv_p,100,'normalization','pdf')
hold on
histogram(vh_p,100,'normalization','pdf')
legend('VV','VH')
xlabel('Phase speckle'),
ylabel('probability density')

%% distributionFitter to check the theoretical distribution
%% that fits best the data

%% transect analysis
figure(5),
imagesc(10*log10(vv2)),colormap(gray), colorbar
n1      = 6300;
n2      = 7000;
punto   = 3526;

figure(6),
plot(n1:n2,10*log10(vv2(punto,n1:n2)),'b',n1:n2,10*log10(vh2(punto,n1:n2)),'r')
legend('VV','VH')
xlabel('Pixel'),
ylabel('Squared-modulus')

%%multi-looking
N        = 5;
finestra = 1/(N*N)*ones(N);

vv_mlk   = filter2(finestra,vv2);
vh_mlk   = filter2(finestra,vh2);

vv2_mlk  = abs(vv_mlk).^2;
vh2_mlk  = abs(vh_mlk).^2;

figure(7),
plot(n1:n2,10*log10(vv2_mlk(punto,n1:n2)),'b',...
     n1:n2,10*log10(vh2_mlk(punto,n1:n2)),'r')
legend('VV mlk','VH mlk')
xlabel('Pixel'),
ylabel('Squared-modulus multi-looked')

N1     = 7;
N2     = 85;
fin1   = 1/(N1*N1)*ones(N1);
co     = abs(filter2(fin1,abs(vv.*conj(vh)))).^2;
inc    = 2*(stdfilt(real(vv),ones(N2))).^2;
k      = co./inc;
figure(6),imagesc(10*log10(k)>-20), colormap(gray), colorbar

Pfa    = 1e-2; %CFAR Pfa Lognormal clutter distribution
acc    = 6; %morphological filter
M      = 1000; %image processing to fill in holes

estrai_costa(vv,vh,N1,Pfa,acc,M)



