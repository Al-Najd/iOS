def say(message)
    puts "#{message}"
end

def exit_if_failed(command)
    if !system(command)
        say "❌ Failed to run #{command}"
        exit 1
    end
end

system("clear")

say "Hello! Welcome Onboard & Glad to have you around!"

say "It has some steps to run, each one identifies itself when it runs, so you'll know what's going on."

say "First, let's make sure that you've Homebrew installed correctly"


steps = [ 
    "ruby Scripts/install-homebrew.rb",
    "ruby Scripts/install-rbenv.rb",
    "ruby Scripts/install-mint.rb",
    "ruby Scripts/prerequisites.rb",
    "ruby Scripts/generators.rb",
    "ruby Scripts/swifty-mocky.rb",
    "ruby Scripts/format-and-lint.rb",
    "ruby Scripts/git-hooks.rb",
    "ruby Scripts/add-aliases.rb",
    "ruby Scripts/setup-fastlane.rb"
]

steps.each do |step|
    exit_if_failed(step)
end

say "🎉 We're done! Enjoy your time here!"
