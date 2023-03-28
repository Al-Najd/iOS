# MARK: - Helpers
def say(message)
	puts "#{message}"
end

def file_exists(name)
	if(File.file?(name))
		say "#{name} exists"
		return true
	else
		say "#{name} not found"
		return false
	end
end

def run_swifty_mocky(command)
    system("mint run MakeAWishFoundation/SwiftyMocky #{command}")
end

def exit_if_failed(command)
    if !system(command)
        say "❌ Failed to run #{command}"
        exit 1
    end
end

def install_swifty_mocky
	say "Checking if SwiftyMocky is installed..."
	if !system("mint run MakeAWishFoundation/SwiftyMocky doctor &>/dev/null;")
		say "⛽️ Installing SwiftyMocky.."
		exit_if_failed("mint install MakeAWishFoundation/SwiftyMocky")
	else
		say "💡 Found SwiftyMocky"
	end
end

def setup_and_generate_mocks
	say "Checking if MockFile is found on root directory"
	if file_exists("Mockfile")
		say "⛽️ generating mocks.."
		run_swifty_mocky("generate")
	else
		say "⛽️ setup MockFile"
		run_swifty_mocky("setup")

		say "⛽️ SwiftyMocky doctor is checking if setup is successfull"
		run_swifty_mocky("doctor")

		say "⛽️ generating mocks.."
		run_swifty_mocky("generate")
	end	
end

install_swifty_mocky
setup_and_generate_mocks
