class WesternGame
  def initialize
    @player_health = 100
    @enemy_health = 100
  end

  def start
    puts "Welcome to the Western Game!\n"

    while @player_health > 0 && @enemy_health > 0
      # Display the current health of the player and enemy
      puts "Player Health: #{@player_health}"
      puts "Enemy Health: #{@enemy_health}"
      
      # Ask the player what action they want to take
      print "\nChoose an action (shoot or dodge): "
      action = gets.chomp.downcase

      case action
      when "shoot"
        # Randomly determine if the player or enemy is hit
        if rand(2) == 0
          puts "\nYou missed!"
        else
          damage = rand(10..20)
          @enemy_health -= damage
          puts "\nYou hit the enemy for #{damage} damage!"
        end
      when "dodge"
        # Randomly determine if the player dodges the enemy's attack
        if rand(2) == 0
          puts "\nYou dodged the enemy's attack!"
        else
          damage = rand(10..20)
          @player_health -= damage
          puts "\nThe enemy hit you for #{damage} damage!"
        end
      else
        puts "\nInvalid action"
      end
    end

    # Determine the winner
    if @player_health > 0
      puts "\nYou won! Congratulations!"
    else
      puts "\nYou lost. Better luck next time."
    end
  end
end

game = WesternGame.new
game.start
