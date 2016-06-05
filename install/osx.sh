#! /bin/bash

############################################################
# A modified version of the work done by Mathias Bynens
# See: https://github.com/mathiasbynens/dotfiles/
############################################################
# Require: null

echo "--------------------------------------
    Starting OSX configuration
--------------------------------------"


###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "Marnu"
sudo scutil --set HostName "marnu"
sudo scutil --set LocalHostName "marnu"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "marnu"


# Disable transparency in the menu bar and elsewhere on Yosemite
defaults write com.apple.universalaccess reduceTransparency -bool true

# Menu bar: hide the Time Machine, Volume, and User icons
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
  defaults write "${domain}" dontAutoLoad -array \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
    "/System/Library/CoreServices/Menu Extras/User.menu"
done
defaults write com.apple.systemuiserver menuExtras -array \
  "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
  "/System/Library/CoreServices/Menu Extras/Battery.menu" \
  "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Set highlight color to grey
defaults write NSGlobalDomain AppleHighlightColor -string "0.500000 0.500000 0.500000"

# Set sidebar icon size
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 3

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Fix for the ancient UTF-8 bug in QuickLook (https://mths.be/bbo)
# Commented out, as this is known to cause problems in various Adobe apps :(
# See https://github.com/mathiasbynens/dotfiles/issues/237
#echo "0x08000100:0" > ~/.CFUserTextEncoding

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false


###############################################################################
# SSD-specific tweaks                                                         #
###############################################################################

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
sudo rm /private/var/vm/sleepimage
# Create a zero-byte file instead…
sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
sudo chflags uchg /private/var/vm/sleepimage

# Disable the sudden motion sensor as it’s not useful for SSDs
sudo pmset -a sms 0

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: It's gonna die right here.
#

defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad -array \
  '"Clicking" = 1; "DragLock" = 0; "Dragging" = 0; "TrackpadCornerSecondaryClick" = 0; "TrackpadFiveFingerPinchGesture" = 2; "TrackpadFourFingerHorizSwipeGesture" = 2; "TrackpadFourFingerPinchGesture" = 2; "TrackpadFourFingerVertSwipeGesture" = 2; "TrackpadHandResting" = 1; "TrackpadHorizScroll" = 1; "TrackpadMomentumScroll" = 1; "TrackpadPinch" = 1; "TrackpadRightClick" = 1; "TrackpadRotate" = 1; "TrackpadScroll" = 1; "TrackpadThreeFingerDrag" = 1; "TrackpadThreeFingerHorizSwipeGesture" = 0; "TrackpadThreeFingerTapGesture" = 0; "TrackpadThreeFingerVertSwipeGesture" = 0; "TrackpadTwoFingerDoubleTapGesture" = 1; "TrackpadTwoFingerFromRightEdgeSwipeGesture" = 3; "USBMouseStopsTrackpad" = 0; "UserPreferences" = 1;'


defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true


# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a fast enough keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en"
defaults write NSGlobalDomain AppleLocale -string "en_ZA@currency=ZAR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Africa/Johannesburg" > /dev/null

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Stop iTunes from responding to the keyboard media keys
#launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "jpg"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# Use folder view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "Flwv"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Reset Launchpad, but keep the desktop wallpaper intact
find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

# Add a spacer to the left side of the Dock (where the applications are)
defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'

# Add a spacer to the right side of the Dock (where the Trash is)
defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using OS X 10.9 or older):
#   MENU_DEFINITION
#   MENU_CONVERSION
#   MENU_EXPRESSION
#   MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
#   MENU_WEBSEARCH             (send search queries to Apple)
#   MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1

# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null

# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Solarized Dark theme by default in Terminal.app
osascript <<EOD
tell application "Terminal"
  local allOpenedWindows
  local initialOpenedWindows
  local windowID
  set themeName to "Highway ansi"
  (* Store the IDs of all the open terminal windows. *)
  set initialOpenedWindows to id of every window
  (* Open the custom theme so that it gets added to the list
     of available terminal themes (note: this will open two
     additional terminal windows). *)
  do shell script "open '$HOME/init/" & themeName & ".terminal'"
  (* Wait a little bit to ensure that the custom theme is added. *)
  delay 1
  (* Set the custom theme as the default terminal theme. *)
  set default settings to settings set themeName
  (* Get the IDs of all the currently opened terminal windows. *)
  set allOpenedWindows to id of every window
  repeat with windowID in allOpenedWindows
    (* Close the additional windows that were opened in order
       to add the custom theme to the list of terminal themes. *)
    if initialOpenedWindows does not contain windowID then
      close (every window whose id is windowID)
    (* Change the theme for the initial opened terminal windows
       to remove the need to close them in order for the custom
       theme to be applied. *)
    else
      set current settings of tabs of (every window whose id is windowID) to settings set themeName
    end if
  end repeat
end tell
EOD

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

# Install the Solarized Dark theme for iTerm
open "${HOME}/init/Solarized Dark.itermcolors"


###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################
#
# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# Transmission.app                                                            #
###############################################################################

# Use `~/Downloads/Tv-shows` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Tv-shows"

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false

# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false
###############################################################################
# Spectacle.app                                                               #
###############################################################################

# Set up my preferred keyboard shortcuts
defaults read com.divisiblebyzero.Spectacle MakeLarger -data "62706c69 73743030 d4010203 04050619 1a582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a4 07081112 55246e75 6c6cd409 0a0b0c0d 0e0f1059 6d6f6469 66696572 73546e61 6d65576b 6579436f 64655624 636c6173 73111a00 8002107c 80035a4d 616b654c 61726765 72d21314 15165a24 636c6173 736e616d 65582463 6c617373 6573585a 4b486f74 4b6579a2 1718585a 4b486f74 4b657958 4e534f62 6a656374 5f100f4e 534b6579 65644172 63686976 6572d11b 1c54726f 6f748001 08111a23 2d32373c 424b555a 62696c6e 70727d82 8d969fa2 abb4c6c9 ce000000 00000001 01000000 00000000 1d000000 00000000 00000000 00000000 d0"
defaults write com.divisiblebyzero.Spectacle MakeSmaller -data "62706c69 73743030 d4010203 04050619 1a582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a4 07081112 55246e75 6c6cd409 0a0b0c0d 0e0f1059 6d6f6469 66696572 73546e61 6d65576b 6579436f 64655624 636c6173 73111a00 8002107b 80035b4d 616b6553 6d616c6c 6572d213 1415165a 24636c61 73736e61 6d655824 636c6173 73657358 5a4b486f 744b6579 a2171858 5a4b486f 744b6579 584e534f 626a6563 745f100f 4e534b65 79656441 72636869 766572d1 1b1c5472 6f6f7480 0108111a 232d3237 3c424b55 5a62696c 6e70727e 838e97a0 a3acb5c7 cacf0000 00000000 01010000 00000000 001d0000 00000000 00000000 00000000 00d1"
defaults write com.divisiblebyzero.Spectacle MoveToFullscreen -data "62706c69 73743030 d4010203 04050619 1a582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a4 07081112 55246e75 6c6cd409 0a0b0c0d 0e0f1059 6d6f6469 66696572 73546e61 6d65576b 6579436f 64655624 636c6173 73110900 80021024 80035f10 104d6f76 65546f46 756c6c73 63726565 6ed21314 15165a24 636c6173 736e616d 65582463 6c617373 6573585a 4b486f74 4b6579a2 1718585a 4b486f74 4b657958 4e534f62 6a656374 5f100f4e 534b6579 65644172 63686976 6572d11b 1c54726f 6f748001 08111a23 2d32373c 424b555a 62696c6e 7072858a 959ea7aa b3bcced1 d6000000 00000001 01000000 00000000 1d000000 00000000 00000000 00000000 d8"
defaults write com.divisiblebyzero.Spectacle MoveToLeftHalf -data "62706c69 73743030 d4010203 04050619 1a582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a4 07081112 55246e75 6c6cd409 0a0b0c0d 0e0f1059 6d6f6469 66696572 73546e61 6d65576b 6579436f 64655624 636c6173 73110900 8002107b 80035e4d 6f766554 6f4c6566 7448616c 66d21314 15165a24 636c6173 736e616d 65582463 6c617373 6573585a 4b486f74 4b6579a2 1718585a 4b486f74 4b657958 4e534f62 6a656374 5f100f4e 534b6579 65644172 63686976 6572d11b 1c54726f 6f748001 08111a23 2d32373c 424b555a 62696c6e 70728186 919aa3a6 afb8cacd d2000000 00000001 01000000 00000000 1d000000 00000000 00000000 00000000 d4"
defaults write com.divisiblebyzero.Spectacle MoveToNextDisplay -data "62706c69 73743030 d4010203 04050619 1a582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a4 07081112 55246e75 6c6cd409 0a0b0c0d 0e0f1059 6d6f6469 66696572 73546e61 6d65576b 6579436f 64655624 636c6173 73111900 8002107c 80035f10 114d6f76 65546f4e 65787444 6973706c 6179d213 1415165a 24636c61 73736e61 6d655824 636c6173 73657358 5a4b486f 744b6579 a2171858 5a4b486f 744b6579 584e534f 626a6563 745f100f 4e534b65 79656441 72636869 766572d1 1b1c5472 6f6f7480 0108111a 232d3237 3c424b55 5a62696c 6e707286 8b969fa8 abb4bdcf d2d70000 00000000 01010000 00000000 001d0000 00000000 00000000 00000000 00d9"
defaults write com.divisiblebyzero.Spectacle MoveToPreviousDisplay -data "62706c69 73743030 d4010203 04050619 1a582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a4 07081112 55246e75 6c6cd409 0a0b0c0d 0e0f1059 6d6f6469 66696572 73546e61 6d65576b 6579436f 64655624 636c6173 73111900 8002107b 80035f10 154d6f76 65546f50 72657669 6f757344 6973706c 6179d213 1415165a 24636c61 73736e61 6d655824 636c6173 73657358 5a4b486f 744b6579 a2171858 5a4b486f 744b6579 584e534f 626a6563 745f100f 4e534b65 79656441 72636869 766572d1 1b1c5472 6f6f7480 0108111a 232d3237 3c424b55 5a62696c 6e70728a 8f9aa3ac afb8c1d3 d6db0000 00000000 01010000 00000000 001d0000 00000000 00000000 00000000 00dd"
defaults write com.divisiblebyzero.Spectacle MoveToRightHalf -data "62706c69 73743030 d4010203 04050619 1a582476 65727369 6f6e5824 6f626a65 63747359 24617263 68697665 72542474 6f701200 0186a0a4 07081112 55246e75 6c6cd409 0a0b0c0d 0e0f1059 6d6f6469 66696572 73546e61 6d65576b 6579436f 64655624 636c6173 73110900 8002107c 80035f10 0f4d6f76 65546f52 69676874 48616c66 d2131415 165a2463 6c617373 6e616d65 5824636c 61737365 73585a4b 486f744b 6579a217 18585a4b 486f744b 6579584e 534f626a 6563745f 100f4e53 4b657965 64417263 68697665 72d11b1c 54726f6f 74800108 111a232d 32373c42 4b555a62 696c6e70 72848994 9da6a9b2 bbcdd0d5 00000000 00000101 00000000 0000001d 00000000 00000000 00000000 000000d7"
###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
  "Dock" "Finder" "Google Chrome" "Google Chrome Canary" "Mail" "Messages" \
  "Opera" "Photos" "Safari" "SizeUp" "Spectacle" "SystemUIServer" "Terminal" \
  "Transmission" "Tweetbot" "Twitter" "iCal"; do
  killall "${app}" &> /dev/null
done

echo "Done."
