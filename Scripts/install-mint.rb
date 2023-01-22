def findOrInstall(package)
    puts "Checking if #{package} is installed..."
    if !system("which #{package} &>/dev/null;")
        puts "⛽️ Installing #{package}..."
        exit_if_failed("brew install #{package}")
    else
        puts "💡 Found #{package}"
    end
end

def exit_if_failed(command)
    if !system(command)
        say "❌ Failed to run #{command}"
        exit 1
    end
end

findOrInstall("mint")
