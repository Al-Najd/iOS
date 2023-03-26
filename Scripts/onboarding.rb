# 1. Create Config.local.json in Fastlane folder
# 2. Ask the user to enter...
    # 1. Apple ID
    # 2. Apple Password
# 3. Add the collected data to the config.local.json file

require 'json'
require 'fileutils'

# Make sure all project ruby dependencies are installed
begin
  require 'bundler'
  require 'fastlane'
  require 'cocoapods'
rescue LoadError
  `sudo gem install bundler`
  `bundle update`
end

puts "Hi, Basically this is just a simple quick script to onboard you :)"
puts "As of now, we are only using Fastlane, so we will be needing the following..."
puts "1. AppleID"
puts "2. Apple Password"
puts "We will be using Fastlane's Credential Manager for this"
puts "Please enter your Apple ID"
apple_id = gets.chomp
system("fastlane fastlane-credentials add --username #{apple_id}")

system("fastlane match development")
system("fastlane match adhoc")
system("fastlane match appstore")

puts "✅ All Done! ✅"
