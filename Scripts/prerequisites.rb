# MARK: - Helpers
def exit_if_failed(command)
    if !system(command)
        puts "❌ Failed to run #{command}"
        exit 1
    end
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

findOrInstall("swiftgen")
findOrInstall("swiftformat")
findOrInstall("swiftlint")
