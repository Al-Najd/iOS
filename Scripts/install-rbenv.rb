############## Helpers ##############
def agree?(question)
    print question + " [y/n]: "
    answer = gets.chomp
    return answer == "y" || answer == "Y" || answer == "yes" || answer == "Yes" || answer == "YES" || answer == "yeah" || answer == "Yeah" || answer == "YEAH"
end

def wait_until(manual_instruction_message)
    print "#{manual_instruction_message} (Press any key to continue)"
    return gets
end

def findOrInstall(package)
    puts "Checking if #{package} is installed..."
    if !system("brew list #{package} &>/dev/null;")
        puts "⛽️ Installing #{package}..."
        exit_if_failed("brew install #{package}")
    else
        puts "💡 Found #{package}"
    end
end

def exit_if_failed(command)
    if !system(command)
        puts "❌ Failed to run #{command}"
        exit 1
    end
end
############## Helpers ##############

def prerequisite_ruby
    if system("test -d /$HOME/.rbenv/bin/;")then
        echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc && source ~/.zshrc
    end
    
    if !system("which rbenv >/dev/null;"); then
        findOrInstall("rbenv ruby-build")
    else
        puts "💡 Found rbenv"
    end

    # if which ruby doesn't print a path that contains '/.rbenv/shims', then run rbenv init
    if !system("which ruby | grep '/.rbenv/shims' >/dev/null;"); then
        # Create ~/.zshrc if not already created
        if !system("test -f ~/.zshrc;"); then
            system("touch ~/.zshrc")
        end

        # Check if eval "$(rbenv init -)" is not already in ~/.zshrc
        if !system("grep \"eval \"$(rbenv init -)\" ~/.zshrc >/dev/null;"); then
            system("echo \"eval \"$(rbenv init -)\" >> ~/.zshrc")
        end
        
        puts "⛽️ Initializing rbenv..."
        system("rbenv init")

        wait_until('Make sure you source the file by running `source ~/.zshrc`, before continuing\n\n\nTo do so, please type CMD + T to open a new tab and run `source ~/.zshrc`')
        agree?("Did you source the file?")
        puts "Ok, moving forward"
    end

    # Read .ruby-version file
    if !(File.exist?(".ruby-version") && File.read(".ruby-version").strip == "3.1.2")
        puts "⛽️ Installing ruby 3.1.2 ..."
        system("rbenv install 3.1.2")
    end

    system("rbenv local 3.1.2")

    puts "⛽️ Installing Gems..."
    system("bundle")
end

prerequisite_ruby
