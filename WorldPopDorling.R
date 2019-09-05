# ----------------
# N. LAMBERT, 2019
# ----------------

# Packages

library(raster)
library(sf)
library(cartogram)

# Variable

fact <- 2

# Total population grid

r <- raster("data/gpw_v4_population_count_rev11_2020_1_deg.asc")
dots <- aggregate(r, fact=fact, fun=sum)
dots <- as(dots, 'SpatialPointsDataFrame')
dots <- st_as_sf(dots)
colnames(dots) <- c("pop","geometry")

# Dorling

dorlingpop <- cartogram_dorling(x = st_jitter(dots),weight = "pop", k = .1)
plot(st_geometry(dorlingpop), col= "#eb3850", border ="white")