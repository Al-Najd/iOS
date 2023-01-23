# Get all the arguments passed to the script
packages = ARGV

packages.each do |package_name|
    system("tuist scaffold ufeature --name #{package_name} --company com.nerdor")
end