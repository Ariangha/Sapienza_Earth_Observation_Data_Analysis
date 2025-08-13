//aoi
var california = ee.FeatureCollection('TIGER/2018/States')
                .filter(ee.Filter.eq('NAME','California'));
               
//intervallo di date
var startDate='2025-01-01';
var endDate= '2025-01-31';

var s2= ee.ImageCollection("COPERNICUS/S2_SR_HARMONIZED")
       .filterBounds(california)
       .filterDate(startDate,endDate)
       .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE',30));

//mosaic
var image=s2.mosaic();
Map.centerObject(california,6);
Map.addLayer(image,{bands:['B4','B3','B2']},'RGB Mosaic Image');

//visualizzazione immagine
var randomimage= ee.Image(s2.toList(s2.size()).get(2));
Map.centerObject(randomimage,10);
Map.addLayer(randomimage,{bands:['B4','B3','B2']},'Immagine #3');

//roi
var s2_la= ee.ImageCollection("COPERNICUS/S2_SR_HARMONIZED")
       .filterBounds(losAngeles)
       .filterDate(startDate,endDate)
       .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE',30));
       
var s2_clipped= s2_la.map(function(image){
  return image.clip(losAngeles);
});

// prima immagine
var firstImage= s2_clipped.first();
Map.centerObject(firstImage,10);
Map.addLayer(firstImage,{bands:['B4','B3','B2'],min:0, max:3000},'First Image Clipped');


// NDVI = (NIR - RED) / (NIR + RED)
var B8=firstImage.select('B8'); //NIR
var B4=firstImage.select('B4');  //RED

var numerator= B8.subtract(B4);
var denominator= B8.add(B4);
var ndvi_manual=numerator.divide(denominator).rename('NDVI Manuale');

Map.centerObject(firstImage,10);
Map.addLayer(ndvi_manual,{min:-1, max:+1},'NDVI_manual');

var ndvi_normalized=firstImage.normalizedDifference(['B8','B4']).rename('NDVI Normalizzato');
Map.centerObject(firstImage,10);
Map.addLayer(ndvi_normalized,{min:-1, max:+1,palette:['blue', 'white','green']},'NDVI_normalized');


var lastImage= ee.Image(s2_clipped.toList(s2_clipped.size()).get(s2_clipped.size().subtract(4)));
Map.centerObject(lastImage,10);
Map.addLayer(lastImage,{bands:['B4','B3','B2'],min:0, max:3000},'Last Image Clipped');

var ndvi_normalized_last=lastImage.normalizedDifference(['B8','B4']).rename('NDVI Normalizzato Last');
Map.centerObject(lastImage,10);
Map.addLayer(ndvi_normalized_last,{min:-1, max:+1,palette:['blue', 'white','green']},'NDVI_normalized Last');

//differenza tra ndvi post e pre

var ndvi_diff= ndvi_normalized_last.subtract(ndvi_normalized);
Map.centerObject(ndvi_diff,10);
Map.addLayer(ndvi_diff,{min:-2, max:+2,palette:['red','white','green']},'NDVI_normalized Diff');



//BI= (NIR-SWIR)/  //b8 e b12

var bi_first=firstImage.normalizedDifference(['B8','B12']).rename('BI');
Map.centerObject(bi_first,10);
Map.addLayer(bi_first,{min:-1, max:+1,palette:['red','white','green']},'Burn Index First Image');

var bi_last=lastImage.normalizedDifference(['B8','B12']).rename('BI');
Map.centerObject(bi_last,10);
Map.addLayer(bi_last,{min:-1, max:+1,palette:['red','white','green']},'Burn Index Last Image');

var bi_diff= bi_last.subtract(bi_first);
Map.centerObject(bi_diff,10);
Map.addLayer(bi_diff,{min:-2, max:+2,palette:['red','white','green']},' Burn Index Difference');