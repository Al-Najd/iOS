require 'json'
require 'fileutils'
require 'io/console'



def input(placeholder)
    print "#{placeholder}: "
    return gets.chomp
end

def secure_input(placeholder)
    print "#{placeholder}: "
    return STDIN.noecho(&:gets).chomp
end

puts("Great!, now we're going to setup fastlane for you")
# Steps
# 0. Check if LocalConfigs.json Exists, if yes, skip till # 5.
# 1. Get current user's account
# 2. Get the passphrase that is used to store the match repo
# 3. Get ID of your Developer Portal Team (denoted by team_id)
# 4. Get ID of your iTunes Connect team (denoted by itc_team_id)
# 5. Generate LocalConfigs.json
# 6. Add it to .gitignore

# 0. Check if LocalConfigs.json Exists, if yes, skip till # 5.
if File.file?("./fastlane/LocalConfigs.json")
    puts("👍 LocalConfigs.json already exists, skipping to step # 5")
else

    # 1. Get current user's account
    puts("As of now, we are only using Fastlane, so we will be needing the following...")
    puts("1. AppleID")
    puts("2. Apple Password")
    puts("We will be using Fastlane's Credential Manager for this (uses the Keychain to store them)")

    apple_id = input("Please enter your Apple ID")

    puts("Now we will need your Apple ID's password")
    puts("Don't worry, it's stored in the Keychain, and Fastlane is the one storing it so it can safely use it")

    system("fastlane fastlane-credentials add --username #{apple_id}")

    # 2. Get the passphrase that is used to store the match repo
    puts("Now you need to get the passphrase, You can find it here (ask for access if the link is inaccessible) \nhttps://menaenergyventures.atlassian.net/wiki/spaces/CafuTech/pages/2919399429/Secrets")
    match_repo_passphrase = secure_input("Once you've it, please input it here (match_git_repo_passphrase)")

    # 3. Get App Specific Password
    puts("Now, we need to get app specific password so u don't get spammed with OTPs for 2FA whenever u need to deal with the appstore")
    puts("First, go to: https://appleid.apple.com/account/manage/section/security")
    puts("Then, select App-Specific Passwords")
    puts("Then type whatever nickname you want, then copy and paste it here")

    app_specific_password = secure_input("Once you've it, please input it here (app_specific_password)")

    # 3. Generate LocalConfigs.json using the above values 
    puts("Generating LocalConfigs.json at ./fastlane/LocalConfigs.json")

    local_configs = {
        "apple_id" => apple_id,
        "match_repo_passphrase": match_repo_passphrase,
        "team_id": "793K46RDR4",
        "itc_team_id": "122051904",
        "team_name": "CAFU APP DMCC",
        "app_specific_password": app_specific_password
    }

    File.write('./fastlane/LocalConfigs.json', JSON.pretty_generate(local_configs))
end

# 6. Check if LocalConfigs.json is already added to .gitignore
puts("Checking if LocalConfigs.json is already added to .gitignore")

gitignore = File.read('.gitignore')
if !gitignore.include?("fastlane/LocalConfigs.json")
    puts("Adding fastlane/LocalConfigs.json to .gitignore")
    File.write('.gitignore', "#{gitignore} fastlane/LocalConfigs.json")
else 
    puts("fastlane/LocalConfigs.json is already added to .gitignore")
end

# Print pass for created LocalConfigs
puts("Here's the LocalConfigs.json that was created for you")
puts(JSON.pretty_generate(local_configs))

puts("All done! Now when you run fastlane, it will use the LocalConfigs.json file to get the values")
puts("This will save you time when you're running fastlane commands")

puts("Now for the fun part, running fastlane onboard")
system("fastlane onboard")

puts("Enjoy!")