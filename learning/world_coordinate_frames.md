- Geodetic: latitude (north and south), longitude (east or west), altitude (above elipsoid usually WGS84, i.e. height above ellipsoid HAE)
- NED: north, east and down from a reference origin (lat, lon, alt)
- MSL: mean sea level (geoid), gravity based, lumpy
- WGS84: ellipsoid, smooth, ideal
    - HAE: height above ellipsoid
- 

# World Geodetic System (WGS)

- Multiple iterations, WGS84 = most recent
- Standard used by Global Positioning System (GPS)
- 3D coordinate reference: latitude, longitude, and elevation
    - Longitude: ranges from -180 to 180, represents east-west position (east is positive)
    - Latitude: ranges from -90 to 90, represents north-south (north is positive)
    - Elevation: represented as ellipsoidal height
- Ellipsoid model: approximates the Earth's surface as an ellipsoid
- Geoid model: defines zero elevation based on gravity readings (+ other stuff?)
    - Accounts for variation in size, shape and mass distribution
    - Geoid height = geoid point - ellipsoid height

# Heights

- Ellipsoid height: aka height above ellipsoid (HAE) or geodetic height, it's the height of a point relative to the ellipsoid
- Orthometric height: height of a point relative to the geoid, aka ellispsoid height - geoid height