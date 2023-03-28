package main

import (
	"fmt"
	"math/rand"
	"time"
)

type Player struct {
	name   string
	health int
}

type Enemy struct {
	name   string
	health int
}

func main() {
	rand.Seed(time.Now().UnixNano())
	fmt.Println("Welcome to the Wild West game!")
	player := Player{name: "Player", health: 100}
	enemy := Enemy{name: "Bandit", health: 100}
	for {
		fmt.Printf("\n%s's Health: %d\n%s's Health: %d\n", player.name, player.health, enemy.name, enemy.health)
		fmt.Print("Choose your action (1 - Attack, 2 - Heal): ")
		var choice int
		fmt.Scan(&choice)
		switch choice {
		case 1:
			player.attack(&enemy)
		case 2:
			player.heal()
		default:
			fmt.Println("Invalid choice. Try again.")
		}
		if enemy.health <= 0 {
			fmt.Printf("\nYou defeated %s! Congratulations, cowboy!\n", enemy.name)
			break
		}
		enemy.attack(&player)
		if player.health <= 0 {
			fmt.Printf("\n%s defeated you. Game over, cowboy!\n", enemy.name)
			break
		}
	}
}

func (p *Player) attack(e *Enemy) {
	damage := rand.Intn(20) + 10
	e.health -= damage
	fmt.Printf("\n%s attacked %s for %d damage.\n", p.name, e.name, damage)
}

func (p *Player) heal() {
	heal := rand.Intn(20) + 10
	p.health += heal
	fmt.Printf("\n%s healed for %d health.\n", p.name, heal)
}

func (e *Enemy) attack(p *Player) {
	damage := rand.Intn(20) + 10
	p.health -= damage
	fmt.Printf("\n%s attacked %s for %d damage.\n", e.name, p.name, damage)
}
