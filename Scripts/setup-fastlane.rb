require 'json'
require 'fileutils'
require 'io/console'

puts("Now, the fun part, fastlane is going to onboard you")
# Steps
# 0. Check if LocalConfigs.json Exists, if yes, skip till # 5.
# 1. Get current user's account
# 2. Get the passphrase that is used to store the match repo
# 3. Get ID of your Developer Portal Team (denoted by team_id)
# 4. Get ID of your iTunes Connect team (denoted by itc_team_id)
# 5. Generate LocalConfigs.json
# 6. Add it to .gitignore

puts("This will save you time when you're running fastlane commands")

puts("running fastlane onboard")
system("fastlane onboard")

puts("Enjoy!")