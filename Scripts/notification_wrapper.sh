APP_ICON_PATH=CAFU/Core/Resources/Assets.xcassets/AppIcon.appiconset/Icon-App-1024.png
terminal-notifier -title "Testing Started" -message "Will notify you once it finishes" -sound Morse -appIcon $APP_ICON_PATH
# Fetch first argument that will be our command to run
COMMAND=$1 > /dev/null 2>&1 & disown

# Run the command and check if it succeeded

if $COMMAND; then
    terminal-notifier -title "🚀 Success" -message "Tests Ran Successfully" -sound Blow -appIcon $APP_ICON_PATH
else
    terminal-notifier -title "🌚 Failed" -message "Tests werent so lucky" -sound Funk -appIcon $APP_ICON_PATH
fi