function plotter(nr,nc,sigma_hh,titolo);

figure,
imagesc(10*log10(sigma_hh)),colorbar
xlabel('Fields'),ylabel('Dates')
title(titolo)

figure,
for ii = 1:floor(nc/2),
subplot(floor(nc/2),1,ii)
plot(1:nr,10*log10(sigma_hh(:,ii)))
axis([1 nr -14 -8])
%axis([1 nr -28 -16])
end

figure,
ii2 = length((floor(nc/2))+1:nc);
k   = 0;
for ii = (floor(nc/2)+1) : nc,
k   = k+1;
subplot(ii2,1,k)
plot(1:nr,10*log10(sigma_hh(:,ii)))
axis([1 nr -14 -8])
%axis([1 nr -28 -16])
end
end

