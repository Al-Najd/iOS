require 'json'
require 'fileutils'
require 'io/console'

def say(message)
    puts "#{message}"
end

def get_notifiable_command(command, should_notify)
    if should_notify
        return "#{command} && echo '✅ Finished running #{command}' | terminal-notifier -title 'Git Hook Command' -sound default"
    else 
        return command
    end
end

def make_script_body(commands)
    say "these following commands are used in this hook: "
    
    commands.each do |command|
        say "- #{command}"
    end

    return  """
            #!/usr/bin/env

            #{commands.join('\n')}
            """
end

# Steps
# 1. Notify user that we're going to setup git hooks
# 2. Define hash of hooks & commands to run in each hook
# 3. Check if the hook file exist in .git/hooks/#{hook}, if it doesn't we create the hook script, if not we overwrite it
# 4. Make the hook script executable
# 5. Notify user that we're done

# 1. Notify user that we're going to setup git hooks
say "⛽️ Setting up git hooks..."

# 2. Define hash of hooks & commands to run in each hook
hooks_and_commands = {
    "pre-commit" => [
            "swiftformat .",
        ],
    "post-checkout" => [
            "ruby Scripts/generators.rb",
        ]
}

# 3. Check if hooks folder exists, if not, create it
say "Checking if hooks folder exists..."
if !File.directory?(".git/hooks")
    FileUtils.mkdir_p(".git/hooks")
else
    say "💡 hooks folder found"
end

# 4. Check if the hook file exist in .git/hooks/#{hook}, if it doesn't we create the hook script, if not we overwrite it
hooks_and_commands.each do |hook, commands|
    hook_file_path = ".git/hooks/#{hook}"
    if !File.exist?(hook_file_path)
        say "⛽️ Creating #{hook} hook..."
        File.open(hook_file_path, "w") do |file|
            file.write(make_script_body(commands))
        end
    else
        say "⛽️ Overwriting #{hook} hook..."
        File.open(hook_file_path, "w") do |file|
            file.write(make_script_body(commands))
        end
    end
end

# 5. Make the hook script executable
hooks_and_commands.each do |hook, commands|
    hook_file_path = ".git/hooks/#{hook}"
    say "⛽️ Making #{hook} hook executable..."
    system("chmod +x #{hook_file_path}")
end

# 6. Notify user that we're done
say "⛽️ Done setting up git hooks!"
