require 'colorize'

puts "Ohoy m8y! ⚓️ I'm the big ol' mighty slathered-coverage.rb 💪".red

puts "-- Author: he's not, he's just some bits that runs some automation, trust me".blue

puts "Don't mind me champ, just gathering some test coverage here for ya big project!".red
puts "I'm gonna be a bit slow, so don't be alarmed if you see a lot of 'N/A' in the output.".red
puts "Hahaha, just kidding around with ya kiddo!, you won't even notice me 😎".red

puts "-- Author: Yea, real funny gramps".blue


puts "Now where did those schemes go?".red
supported_schemes = [
    "Al-Najd"
]

puts "*The pesky schemes appears*".green
puts "Oy, There them twerps!".red
puts supported_schemes.join("\n").green
puts "Alright, time to see where to put those reports in...".red
puts "Hmmm..........".red
sleep(2)
puts "Yea, `Coverage/` seems like a good place to put 'em.".red

supported_schemes.each do |scheme, directory|
    puts "Alright #{scheme}, it's time to put some report in your eyes!".red
    system("slather coverage -x --output-directory Coverages --scheme #{scheme} Al\\ Najd.xcodeproj")
    puts "Aboarded, next should be....".red
end

puts "Huh, all been aboarded? 🤔".red

puts "Well, then, let's ship that coverage, then 🚢".red

system(`curl -Ls https:\/\/coverage.codacy.com\/get.sh\ report -r Coverages\/cobertura.xml`)

puts "Looks like am done for today, gotta hook me up some rum! 🍻".red
