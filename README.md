# Vineyard Growth Assessment and Ground Movement Observation
This project monitors vineyard growth in South Pavia using NDVI (optical) and NRCS (radar) to compare North-South vs East-West row orientations, and analyzes the March 2021 Greece Earthquake with InSAR imagery to detect fringe patterns, measuring ground deformation and crustal displacement.

# Intro
Remote sensing offers an efficient way to monitor vast regions repeatedly and remotely. In agriculture, this means we can leverage it for vineyard vigor assessment, irrigation stress detection, and early yield prediction—all in near real-time, at a fraction of the cost of traditional methods, by comparing radar and optical images. Simultaneously, these same sensors let us monitor Earth's crust, pinpointing subtle surface deformations along fault lines over time to flag earthquake risks before they escalate.

# Goals of The Project
<img src="https://github.com/Ariangha/vineyard_growth_assessment/blob/main/Slides/3.png" alt="image" width="500"/>
Our initial primary objective is to monitor vineyard growth stages in the South of Pavia. This involves a year-round analysis of vineyard health and development. We achieve this through seasonal trend analysis using both NDVI (Normalized Difference Vegetation Index) from optical data and NRCS (Normalized Radar Cross Section) from radar data. A crucial aspect of this analysis is accounting for field orientation, comparing vineyards with North-South rows against those with East-West rows.

Our second key objective shifts to observing the March 2021 Greece Earthquake. Here, our goal is to precisely analyze the seismic event's effects on the Earth's surface. We utilize InSAR images, which display characteristic "fringes". The fringe patterns directly correspond to variations in the distance between the satellite sensor and the Earth's crust , providing vital information about the area and magnitude of ground deformation and displacement caused by the earthquake.

# Methodology
<img src="https://github.com/Ariangha/vineyard_growth_assessment/blob/main/Slides/4.png" alt="image" width="500"/>
"For Vineyard Observation using the SAR Method, our goal is to understand how vineyards change over time, even through clouds or rain, which is where SAR excels. We start with raw Sentinel-1 Single Look Complex products.

These are very detailed radar images, containing complex numerical data that includes both in-phase and quadrature components, as well as two polarization channels: VV and VH.

The first step in processing is TOPS-Split. Sentinel-1 images cover a wide area, divided into sections called 'sub-swaths' and 'bursts'. This step allows us to isolate just the specific sub-swaths and bursts that cover our vineyard area.

Next is Calibration. Raw radar data are in 'Digital Numbers,' which aren't directly comparable. Calibration converts these numbers into 'floating point' values, representing the radar's intensity. We select both VV and VH polarization channels for this.

after calibration, we perform Debursting. Sentinel-1 images, often show subtle horizontal 'stripes' or gaps. Debursting stitches these segments together and we create a seamless, continuous image.

Finally, we apply Terrain Correction. This is vital for accurate mapping. It geometrically corrects the image to a standard map projection, like WGS84. This rectifies distortions caused by terrain variations.

After these foundational steps, in post-processing we aim to extract specific backscatter information for each individual vineyard field. we calculate (NRCS) for both VV and VH polarizations within those field boundaries.

for our optical method, the data were a higher level product so it didnt need much preprocessing so the only thing we did was to filter by cloud coverage for about 30%. and from there we calculated the NDVI metric for each field and month.

in the InSAR process we took two satellite photos of the same place at different times, then comparing them to see if the ground moved. It all starts with two Sentinel-1 radar images.

The two Sentinel-1 SLD data to be downloaded for the project related to SAR interferometry for Earthquakes observation are:
S1B_IW_SLC__1SDV_20210224T163129_20210224T163157_025751_0311F3_5D4D
S1B_IW_SLC__1SDV_20210308T163129_20210308T163157_025926_0317AF_8EB1

Then comes 'Coregistration', which is like perfectly aligning the two images, pixel by pixel, so they exactly match up.
Once aligned, we create the 'Interferogram'. and then we move on to 'TOPSAR Deburst'.

For finding ground movement, especially from things like earthquakes, we use 'Topographic Phase Removal'. This removes the part of the signal that's just from the hills and valleys, leaving only the signal caused by actual ground movement. We then use 'Phase Filtering' (like Goldstein filtering) to clean up the image and reduce speckle, making the movement patterns clearer. Finally, 'Terrain Correction'.

# Experiments
<img src="https://github.com/Ariangha/vineyard_growth_assessment/blob/main/Slides/5.png" alt="image" width="500"/>
First, for Vineyard Observation, our region of interest comprises 24 distinct fields located in the South of Pavia, specifically along the banks of the Po River. These fields are strategically chosen with 12 oriented East-West and 12 North-South to analyze different row orientations. For data acquisition, we utilize both Sentinel-1 SAR (Synthetic Aperture Radar) and Sentinel-2 Multispectral Instrument data, allowing us to leverage both radar's all-weather capabilities and optical's spectral insights. The period of interest for this study spans a full year, from 1 January 2022 to 31 December 2022, enabling us to monitor seasonal growth cycles.

We combine optical and SAR data to fully assess vineyard health and structure. From optical imagery, we compute the NDVI (Normalized Difference Vegetation Index)—using near-infrared and red bands—to measure vegetation vigor, density, and photosynthetic activity. From SAR, we derive the NRCS (Normalized Radar Cross Section) in VV and VH polarizations to assess physical properties like plant structure, biomass, and moisture. VV highlights vertical structures and surface roughness, while VH shows canopy volume scattering tied to biomass. Together, NDVI’s “greenness” and NRCS’s structural and moisture insights deliver a comprehensive view of vineyard dynamics.

Our second experiment focuses on the 2021 Greece Earthquake. The region of interest is Central Greece, specifically the Thessaly region, with Larisa identified as a major city to the east/southeast of the epicenter. For this event, we exclusively used Sentinel-1 SAR data, as its interferometric capabilities are ideal for detecting ground deformation. The critical period of interest involved two specific dates: 24 February 2021, representing the pre-earthquake acquisition, and 8 March 2021, for the post-earthquake data. The earthquake's precise location was at latitude 39.7, longitude 22.08, and a depth of 20 kilometers.

These two experiments highlight how different satellite data and processing techniques can be applied to diverse environmental monitoring challenges."

# Results
<img src="https://github.com/Ariangha/vineyard_growth_assessment/blob/main/Slides/6.png" alt="image" width="500"/>

Here you can see the matrices of the Normalized Radar Cross Section for EW and NS oriented fields and for both polarizations VV and VH. In general VV is always higer than VH.

<img src="https://github.com/Ariangha/vineyard_growth_assessment/blob/main/Slides/7.png" alt="image" width="500"/>

Going deeper we can analyze each field. We computed the ratio between the NRCS_vh and NRCS_vv and this ratio is able to underlyne the volume of vegetation. Field 3 has a good behavior, because during the vegetative season (from April to March) has higher values of the ratio. Instead, field 12 does not show such a trend and this can be due to a sparser vegetation.

<img src="https://github.com/Ariangha/vineyard_growth_assessment/blob/main/Slides/8.png" alt="image" width="500"/>

For the optical results we computed the NDVI for EW and NS oriented fields. In general values of NS fields are lower with respect to the EW fields.

<img src="https://github.com/Ariangha/vineyard_growth_assessment/blob/main/Slides/9.png" alt="image" width="500"/>

Now that we have both optical and SAR results, we can cross-check them. Taking the same previous fields, we can notice that field number 3 has a higher value of NDVI during the vegetative season, while field 12 has a very strange negative trend. These results can help the decidion-making for Smart Agricolture: we can act immediately when a field is not behaving as expected. Maybe this field needs some more fertilizer or maybe it has some kind of disease.

<img src="https://github.com/Ariangha/vineyard_growth_assessment/blob/main/Slides/10.png" alt="image" width="500"/>

Next, we have the interferometric results. We obtain the interferogram of the relative phase due to displacements. In the area where we can see the fringes, there was a movement of the crust of the Earth. In this case, we can validate our results with the INGV on-site data. From INGV we know that during our period of interest, a set of earthquakes occurred. The two strongest ones were on March 3rd and March 4th. Using the coordinates of INGV we can notice that the earthquake occured exactly in the area in which we have fringes.

<img src="https://github.com/Ariangha/vineyard_growth_assessment/blob/main/Slides/11.png" alt="image" width="500"/>

# Conclusion
Concluding, we have seen that with Sentinel-1 and Sentinel-2 data we can monitor the growth stage of vineyards and we have also seen that we are able to observe the relative phase due to displacement after an earthquake. These kinds of instruments and these kinds of products are very powerful and effective in this and in many other applications and contexts.

# Future Work
Beyond just monitoring vigor and stress, future work can involve developing and training machine learning models using historical multispectral (NDVI, NRCS) and SAR data to accurately predict vineyard yield before harvest. This could involve regression models or time series analysis.

Instead of manual interpretation of interferogram fringes, future work can focus on implementing automated algorithms for unwrapping InSAR data to derive precise displacement maps. This would involve advanced signal processing and potentially deep learning techniques to identify and quantify subtle surface deformations along fault lines, improving earthquake risk assessment.

# References
Bakon, M.; Teixeira, A.C.; Pádua, L.; Morais, R.; Papco, J.; Kubica, L.; Rovnak, M.; Perissin, D.; Sousa, J.J. Synthetic Aperture Radar in Vineyard Monitoring: Examples, Demonstrations, and Future Perspectives. Remote Sens. 2024, 16, 2106. https://doi.org/10.3390/rs16122106

Nunziata, F. (2025). Why observing the Earth from the space? Earth Observation Data Analysis. Sapienza University of Rome.

Nunziata, F. (2025). Basic EM concepts and propagation mechanisms: Earth Observation Data Analysis. Sapienza University of Rome.

Stramondo, S. (2025). Earth Observation Data Analysis Slides. Sapienza University of Rome.
