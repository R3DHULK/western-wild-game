@echo off
title Wild West Game

setlocal enabledelayedexpansion

:: Initialize variables
set "health=100"
set "ammo=6"
set "game_over=false"

:: Game loop
:game_loop
cls
echo Wild West Game
echo.
echo Status:
echo Health: %health%
echo Ammo: %ammo%
echo.

:: Get user input
set /p "action=What do you want to do? (shoot, reload, run): "

:: Validate input and execute action
if /i "%action%" equ "shoot" (
  if %ammo% equ 0 (
    echo You don't have any ammo left.
  ) else (
    set /a "ammo-=1"
    set /a "enemy_health=%random% %% 20 + 50"
    echo You shot the enemy. Their health is now %enemy_health%.
    if %enemy_health% leq 0 (
      echo You killed the enemy!
    ) else (
      set /a "enemy_damage=%random% %% 20 + 10"
      set /a "health-=enemy_damage"
      echo The enemy shot back and hit you for %enemy_damage% damage.
    )
  )
) else if /i "%action%" equ "reload" (
  set /a "ammo=6"
  echo You reloaded your gun.
) else if /i "%action%" equ "run" (
  set /a "health-=10"
  echo You ran away from the enemy but got hit in the process.
) else (
  echo Invalid action. Please try again.
  pause >nul
)

:: Check status
if %health% leq 0 (
  echo You died in the wild west shootout.
  set "game_over=true"
) else if %enemy_health% leq 0 (
  echo You won the wild west shootout!
  set "game_over=true"
)

:: Check game over
if %game_over% equ true (
  pause >nul
  exit
)

:: Loop
goto game_loop
