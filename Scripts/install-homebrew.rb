def is_homebrew_installed_correctly
    puts "Ok, let's see how Doctor Homebrew would puts about the installation"
    if system("brew doctor")
        puts "Great, it seems that Homebrew is working correctly"
        return true
    else
        puts "Hmmm, it seems that Homebrew is not working correctly"
        puts "Can you take a screenshot and contact us on Teams?"
        return false
    end
end

def prerequisite_homebrew 
    if !system("brew --version &>/dev/null;")
        # MARK: - Install Homebrew
        puts "⛽️ Installing Homebrew..."
        system("/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)\"")

        # MARK: - Add Homebrew to PATH
        puts "Okay, now to set it up in your PATH"
        
        if agree?("Do you want the script to add Homebrew to your PATH for you? or do you prefer to do that manually?")
            puts "Okay, let's do that"
            echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc && source ~/.zshrc
        else
            puts "Okay, you can do that manually by adding this line to your .zshrc file: export PATH=/opt/homebrew/bin:$PATH"
            wait_until("Waiting until you add Homebrew to your PATH")
        end

        # MARK: - Fix Homebrew permissions over ZSH folders
        puts "Now, that Homebrew is installed, you need to transfer some ZSH directories ownership to yours, so they can be used by Homebrew"
        puts "Note, these don't give Homebrew root access or special permissions, they just allow Homebrew to use them"

        puts "You can check this StackOverflow's thread for more info: https://stackoverflow.com/a/14539521/19667942"
        
        puts "Anyhow, These directories are..."
        puts "\t-/usr/local/share/zsh"
        puts "\t-/usr/local/share/zsh/site-functions"

        if agree?("Do you wish to continue?")
            system("sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions")
        else
            puts "Alright"
            wait_until("Waiting until you transfer ownership of the directories")
        end
        
        # MARK: - Check Homebrew Doctor
        if !is_homebrew_installed_correctly
            exit 1
        end
    else
        puts "💡 Found Homebrew"

        # MARK: - Check if Homebrew Doctor is working fine
        if !is_homebrew_installed_correctly
            exit 1
        end
    end
end

prerequisite_homebrew