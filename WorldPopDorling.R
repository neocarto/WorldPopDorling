# ----------------
# N. LAMBERT, 2019
# ----------------

# Packages

library(raster)
library(sf)
library(cartogram)


# ----------------------
# Data import & handling
# ----------------------


# Variables

fact <- 3
res <- 1
# Countries

world <- st_read("data/world.shp")
# prj <- "+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"
# world <- st_transform(world, prj)

# Total population grid

r <- raster("data/gpw_v4_population_count_rev11_2020_1_deg.asc")
dots <- aggregate(r, fact=fact, fun=sum)
dots <- as(dots, 'SpatialPointsDataFrame')
dots <- st_as_sf(dots)
colnames(dots) <- c("pop","geometry")

# ------------
# Dorling
# ------------

dorlingpop <- cartogram_dorling(x = st_jitter(dots),weight = "pop", k = .1)

plot(st_geometry(dorlingpop), col= "#eb3850", border ="white")

# -----
# Export
# ------
# smooth <- st_cast(contourpoly, "POLYGON")
# geojson_write(input=smooth, object_name = "smooth", file = "../data/smooth.geojson", overwrite = T)
# View(smooth)
# 
# legend <- as.data.frame(smooth)
# legend <- legend[,c("id","max","cols")]
# legend <- unique (legend)
# colnames(legend) <- c("id","val","col")
# legend$val <- round(legend$val,0)
# legend <- legend[order(-legend$val),]
# 
# write.csv(x = legend,file = "../data/legend.csv", row.names = F)
