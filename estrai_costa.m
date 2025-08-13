function estrai_costa(Shh,Shv,N,Pfa,acc,M),


window  = 1/(N*N)*ones(N);

NRCS_HH  = filter2(window,Shh.*conj(Shh));
NRCS_HV  = filter2(window,Shv.*conj(Shv));

figure(), colormap(gray),imagesc(10*log10(NRCS_HH),[-40 0]),colorbar
figure(), colormap(gray),imagesc(10*log10(NRCS_HV),[-40 0]),colorbar

r        = filter2(window,abs(Shh).*abs(Shv));

figure(), colormap(jet),imagesc(10*log10(r),[-30 0]),colorbar
msgbox('Please draw a ROI ove the sea')

figure(), colormap(gray), imagesc(10*log10(NRCS_HH),[-40 0]), colorbar, 
sea      = roipoly;
sea      = double(sea);

r_sea    = r.*sea;
r_sea    = r_sea(r_sea~=0);

figure(), histogram(r_sea,100);

sigma   = raylfit(r_sea);

th      = sigma*sqrt(-2*log(Pfa));
r_inv   = ~(r < th); 

figure(), colormap(gray), imagesc(r_inv)

H       = ones(acc);

h_out_  = imfilter(r_inv,H,'replicate');
h_out   = imfill(bwareaopen(h_out_,M),4,'holes');
 
figure(), colormap(gray), imagesc(h_out)

out     = ~edge(h_out,'Canny');
 
figure(), colormap(gray), imagesc(out)

bd      =~out;
amp     = Shh.*conj(Shh);

coeff   = 0.9;
extraction_pre = cat(3,coeff*ones(size(bd)), coeff-coeff*bd,coeff-coeff*bd);   

figure(),imagesc(10*log10(amp),[-40 0]),colormap(gray), hold on 
SC = image(extraction_pre);
hold off;
set(SC, 'AlphaData', bd);
end
