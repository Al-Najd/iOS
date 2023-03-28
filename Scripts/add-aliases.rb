# Steps
# 1. Check if .zshrc exists or not
# 1.1 If not, create it
# 2. Check if aliases are already added or not
# 3. If not, add the aliases
# 4. Save & Source the file

require 'fileutils'

### Helpers Start ###
def add_aliases(aliases)
    File.open(File.expand_path('~/.zshrc'), 'a') do |file|
        file.puts "\n# Aliases added by CAFU ⛽️"
        aliases.each do |alias_struct|
            file.puts "alias #{alias_struct.name}='#{alias_struct.command}'"
        end
    end
end

def is_alias_added(alias_name)
    # Check if file contains alias_name
    return File.read(File.expand_path('~/.zshrc')).include?(alias_name.to_s)
end

def agree?(question)
    print question + " [y/n]: "
    answer = gets.chomp
    return answer == "y" || answer == "Y" || answer == "yes" || answer == "Yes" || answer == "YES" || answer == "yeah" || answer == "Yeah" || answer == "YEAH"
end

def wait_until(manual_instruction_message)
    print "#{manual_instruction_message} (Press any key to continue)"
    return gets
end

Alias = Struct.new(:name, :command)

### Helpers End ###

if !File.exist?(File.expand_path('~/.zshrc'))
    FileUtils.touch(File.expand_path('~/.zshrc'))
end

aliases = [
    Alias.new('mk', 'ruby Scripts/make.rb'),
    Alias.new('gen', 'ruby Scripts/generators.rb'),
    Alias.new('format', 'ruby Scripts/format-and-lint.rb'),
    Alias.new('hook', 'ruby Scripts/git-hooks.rb'),
    Alias.new('mock', 'mint run swiftymocky generate'),
    Alias.new('test', 'fastlane test'),
    Alias.new('fastlane', 'bundle exec fastlane'),
]

add_aliases(aliases)

wait_until('Make sure you source the file by running `source ~/.zshrc`, before continuing\n\n\nTo do so, please type CMD + T to open a new tab and run `source ~/.zshrc`')
agree?("Did you source the file?")
puts "Ok, moving forward"