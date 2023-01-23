# Get all the arguments passed to the script
packages = ARGV

packages.each do |package_name|
    # Create a new directory for the package
    system("mkdir Projects/#{package_name}")
    
    # Create a new package
    system("swift package init --package-path Projects/#{package_name}")
end