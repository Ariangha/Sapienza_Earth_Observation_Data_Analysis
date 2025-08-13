clc
clear all
close all

[filename perc] = uigetfile(['.tif'],'MultiSelect','on');

sf      = shaperead('./dati/shape/ns_particelle.shp'); 
nc      = size(sf,1);
nr      = length(filename);
nrcs_hh = zeros(nr,nc);
coe     = zeros(nr,nc);
inco    = zeros(nr,nc);

for tt = 1:nr,
	a    = double(importdata([perc filename{tt}]));
	hh   = complex(a(:,:,1),a(:,:,2));
	hh2  = double(a(:,:,3));
	lat  = double(a(:,:,4));
	lon  = double(a(:,:,5));

%devo avere le lat e lon del dato SAR (quadratone)
% prendo lat e lon dallo shapefile
for campo = 1: size(sf,1),
	
        X = sf(campo).X;     
	X = X(~isnan(X));
	Y = sf(campo).Y;
	Y = Y(~isnan(Y));

	BW_distretto = inpolygon(lon,lat,X,Y);  
% operazione logica = avrò 1 nel quadratone SAR in corrispondenza dei valori di lat e lon dello shapefile
	d_sm_ptc_c           = hh2.*BW_distretto;
	d_sm_ptc_co          = hh.*BW_distretto;
	nrcs_hh(tt,campo)    = mean(nonzeros(d_sm_ptc_c));
	coe(tt,campo)        = abs(mean(nonzeros(d_sm_ptc_co)))^2;
	inc(tt,campo)        =2*var(nonzeros(d_sm_ptc_co));
end
end
plotter(nr,nc,nrcs_hh,'nrcs_hh');
plotter(nr,nc,coe,'coherent component');
