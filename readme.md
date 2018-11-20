
## TODO:

-enable saving thumbnails when saving a watch
-copy thumbs from bundle to docs folder for loading in the main view, but do this only once ( save in preferences )

-enable swiping controls on the watch face ( L/R for prev/next , up for send to watch )

- switch to SVG files for shapes : https://github.com/mchoe/SwiftSVG or https://github.com/pocketsvg/PocketSVG
- get ring settings / editor working

## IDEAS:
- show name of current face on watch when first starting ( then fade it out )
- better highlighting of the parts ( zoomed in outline )

## COMPLETED
- switch to sending JSONData for watch comms
- add color picker
- add color for minute hand ( and subclass color picker controller )
- get rid of digital time from watch app ( from original tutorial )
- fix warnings in IB 
- fix warnings in logs
- save load themes / default faces
- add some buttons to swap out a few watch faces for testing
- start drawing the rings / fonts ( can test using default data )
- choose current options in CVs ( after loading a new faceSetting )
- add textures for backgrounds ( so we can have things like vinyl record ), if material does not have #, then try its name as a texture
- save / revert for current settings
- add a watch "frame" to the top left of the layout to better see what full screen textures look like
- send to watch sends whole list
- watch cycles thru designs using crown
- organize source files for settings view into group for view 
- fix app icon -- cannot have alpha channel in app store 
- add background shapes ( circle / square / side by side 2 color )
- make watch face chooser on main view TV + CV to allow for more settings 
- test on larger watch in simulator
- anti aliasing shapes!

