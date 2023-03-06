# Define a function to display the player's inventory
show_inventory <- function(inventory) {
  cat("Your inventory:\n")
  if (length(inventory) == 0) {
    cat("Empty.\n")
  } else {
    for (item in inventory) {
      cat("*", item, "\n")
    }
  }
}

# Define the game
cat("Welcome to the Wild West!\n")
cat("You're a cowboy on a mission to save the town from bandits.\n")
cat("You'll need to search for weapons and ammunition before you can take on the bandits.\n")

# Set up the player's inventory
inventory <- c()

# Start the game loop
while (TRUE) {
  # Prompt the player for their next action
  cat("\nWhat would you like to do?\n")
  cat("1. Search for weapons and ammunition\n")
  cat("2. Go to the saloon\n")
  cat("3. Challenge the bandits\n")
  cat("4. Quit the game\n")
  choice <- as.integer(readline(prompt = "Enter your choice: "))
  
  # Handle the player's choice
  if (choice == 1) {
    # Search for weapons and ammunition
    found_item <- sample(c("Revolver", "Shotgun", "Ammunition"), 1)
    inventory <- c(inventory, found_item)
    cat("You found a", found_item, "!\n")
    show_inventory(inventory)
  } else if (choice == 2) {
    # Go to the saloon
    cat("You walk into the saloon and order a drink.\n")
    if ("Ammunition" %in% inventory) {
      inventory <- setdiff(inventory, "Ammunition")
      cat("As you're sitting at the bar, you overhear a conversation about the bandits.\n")
      cat("You learn that the bandits are hiding out in the abandoned mine just outside of town.\n")
      show_inventory(inventory)
    } else {
      cat("As you're sitting at the bar, you realize you're low on ammunition.\n")
      cat("You'll need to search for more before you can take on the bandits.\n")
    }
  } else if (choice == 3) {
    # Challenge the bandits
    if ("Revolver" %in% inventory | "Shotgun" %in% inventory) {
      cat("You head to the abandoned mine and confront the bandits.\n")
      if ("Shotgun" %in% inventory) {
        cat("Your shotgun makes quick work of the bandits!\n")
        cat("Congratulations, you saved the town!\n")
        break
      } else {
        cat("You engage in a shootout with the bandits.\n")
        cat("You manage to take down a few of them, but ultimately, you're outnumbered and outgunned.\n")
        cat("You have been defeated.\n")
        break
      }
    } else {
      cat("You don't have enough firepower to take on the bandits.\n")
      cat("You'll need to search for more weapons before you can challenge them.\n")
    }
  } else if (choice == 4) {
    # Quit the game
    cat("Thanks for playing!\n")
    break
  } else {
    # Invalid choice
    cat("Invalid choice. Try again.\n")
  }
}
