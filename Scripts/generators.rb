def say(message)
    puts "#{message}"
end

say "Installing Generators"
say "Generators are tools that generates us assets & boilerplate code"

# MARK: - SwiftGen
say "⛽️ Now generating assets, localizations and fonts through SwiftGen"

system("swiftgen")

# MARK: - XcodeGen

say "⛽️ Generating Xcode project"
system("xcodegen generate")
