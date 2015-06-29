def greetings
    # Starts a new line after running 'greeting.rb'.
    puts ''
    
    ARGV.each do |arg|
        # Avoid print '<greeting>, <greeting>' to the screen.
        unless arg == ARGV[0]
            # DRY: Reuse the first value in the arguments array.
            # This makes the code more reusable, and it allows
            # one to inject any greeting of choice as the first
            # argument in the 'ARGV' array.
            puts "#{ARGV[0]}, #{arg}"
        end
    end
end

greetings