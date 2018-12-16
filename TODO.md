## TO DO:
- ring cells less / more with edit mode on by default

- get ring settings / editor working
- scroll to new item ( esp. important for long list )
- UX for patterns ?

- allow editing of hand movments ( need thumbnails ? )
- undo / redo in editor ( save prev state each time )

- crash when sending to watch 5 times -- https://stackoverflow.com/questions/52860566/error-when-running-xcode-simulator-framework-cuithemestore-no-theme-regist
- !! save json data into JPEG for import / export over social  https://stackoverflow.com/questions/40175160/exif-data-read-and-write
- switch to SVG files for shapes : https://github.com/mchoe/SwiftSVG or https://github.com/pocketsvg/PocketSVG
- push app to hockeyapp for beta testing

## REFACTORS:
- guard lets instead of if lets
- refactor AppUISettings
- rename KKInterfaceController
- test with other screen sizes - fix layouts

## IDEAS:
- allow for user to choose background from camera roll ( memory only ), on save it copies to /docs folder
- options for main screen
- screen saver mode where it switches face on each new watch rise
- skin-see thru / tattoo watch
- show name of current face on watch when first starting ( then fade it out )
- better highlighting of the parts ( zoomed in outline )
- tinting colors for textures?

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
- enable saving thumbnails when saving a watch
- copy thumbs from bundle to docs folder for loading in the main view, but do this only once ( save in preferences )
- BUG: settings arent loading in properly when selecting a watch from chooser ( seems to take two times )
- get textures working for hands
- enable swiping controls on the watch face ( L/R for prev/next , up for send to watch )
- clean up layout / UI for settings 
- move save to top action
- hide revert button ( not needed )
- add more buttons for random ( color, face )
- add edit table modal for chooser to be able to reorder, delete and add faces
- add third color to ring materials
- add watch frame to chooser edit view
- show title & allow editing of titles in settings ( tap on it fo a popup )
- clean up title table cell ( tighten height )
- add decorator themes to main selector table
- make new button ( debug only )  that regenerates all the default thumbnails
- bug when rendering text items < 12 ( IE 6 or 4 showg wrong numbers )
- fix the need for always having a spacer as first item ( better top level scale / drawing ) 
- add option to show hand outlines
- draw hand outlines ( white initially )
- add option for hand outline color
- implement some of the smooth animations for second / minute hand
- fix default the indicators to work better for watch
- ring editor: select cell when editing any of the items
- ring editor: show selected cell in preview ( just bloom effect current item )

