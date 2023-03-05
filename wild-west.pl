#!/usr/bin/perl

# Western game in Perl

# Define the possible actions and their corresponding functions
my %actions = (
    "look" => \&look,
    "move" => \&move,
    "shoot" => \&shoot,
    "quit" => \&quit,
);

# Define the game world as a hash of locations
my %world = (
    "saloon" => {
        "description" => "You are in the saloon. There are people drinking and playing cards.",
        "north" => "town_square",
        "south" => "hotel",
        "items" => ["whiskey", "poker_chips"],
    },
    "town_square" => {
        "description" => "You are in the town square. There is a sheriff's office and a bank.",
        "south" => "saloon",
        "east" => "bank",
        "west" => "sheriffs_office",
        "items" => ["wanted_poster"],
    },
    "bank" => {
        "description" => "You are in the bank. There is a teller behind a counter.",
        "west" => "town_square",
        "items" => ["gold"],
    },
    "sheriffs_office" => {
        "description" => "You are in the sheriff's office. There is a jail cell and a desk.",
        "east" => "town_square",
        "items" => ["handcuffs"],
    },
    "hotel" => {
        "description" => "You are in the hotel. There are people sleeping in the rooms.",
        "north" => "saloon",
        "items" => ["key"],
    },
);

# Define the player's starting location and inventory
my $location = "saloon";
my @inventory = ();

# Start the game
print "Welcome to the western game!\n";
print "You are in the $world{$location}->{'description'}.\n";

while (1) {
    # Prompt the player for their action
    print "> ";
    my $action = lc(<STDIN>);
    chomp($action);

    # Execute the player's action if it's valid
    if (exists $actions{$action}) {
        $actions{$action}->();
    } else {
        print "I don't understand that command.\n";
    }
}

# Function to look around the current location
sub look {
    print "$world{$location}->{'description'}\n";
    if (@{$world{$location}->{'items'}}) {
        print "You see the following items: ";
        print join(", ", @{$world{$location}->{'items'}}) . ".\n";
    } else {
        print "You don't see any items.\n";
    }
}

# Function to move to a different location
sub move {
    print "Which direction do you want to go? ";
    my $direction = lc(<STDIN>);
    chomp($direction);
    if (exists $world{$location}->{$direction}) {
        $location = $world{$location}->{$direction};
        print "You are now in the $world{$location}->{'description'}.\n";
    } else {
        print "You can't go that way.\n";
    }
}

# Function to shoot at something
sub shoot {
    print "What do you want to shoot? ";
    my $target = lc(<STDIN>);
    chomp($target);
    if ($target eq "enemy") {
        print "You don't see any enemies.\n";
    } elsif ($target eq "self") {
        print "You shoot yourself in the foot. Ouch!\n";
        quit();
    } elsif (grep {$_ eq $target} @{$world{$location}->{'items'}}) {
        print "You shoot the $target.\n";
        # Remove the item from the current location
        @{$world{$location}->{'items'}} = grep {$_ ne $target} @{$world{$location}->{'items'}};
    } else {
        print "You can't shoot that.\n";
    }
}

# Function to quit the game
sub quit {
    print "Thanks for playing!\n";
    exit;
}
