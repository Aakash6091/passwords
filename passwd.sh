#!/bin/bash
# Password Change Automation Script
# This script changes passwords for a predefined list of valid users and adjusts permissions where needed.

# Function to change a user's password
change_password() {
  local username="$1"
  local password="$2"

  if id "$username" &>/dev/null; then
    echo "Changing password for user: $username"
    echo "$username:$password" | sudo chpasswd
  else
    echo "User $username does not exist, skipping..."
  fi
}

# Function to adjust user permissions
adjust_permissions() {
  local username="$1"
  local group="$2"

  if id "$username" &>/dev/null; then
    echo "Adjusting permissions for user: $username"
    sudo usermod -aG "$group" "$username"
  else
    echo "User $username does not exist, skipping..."
  fi
}

# Predefined list of users and preset passwords
# Format: username:group:password
USERS=(
  "AdmiralNelson :_This!is@Mercy#passwd$for%Admiral_"
"quartermaster :_This!is@Winston#passwd$for%quarter_"
"skulllord     :_This!is@Genji#passwd$for%skull_"
"dreadpirate   :_This!is@Sombra#passwd$for%dread_"
"blackflag     :_This!is@DVa#passwd$for%black_"
"SaltyDog23    :_This!is@Soldier76#passwd$for%Salty_"
"PlunderMate56 :_This!is@Zarya#passwd$for%Plunder_"
"RumRider12    :_This!is@Ana#passwd$for%Rum_"
"GoldTooth89   :_This!is@Junkrat#passwd$for%Gold_"
"HighTide74    :_This!is@Bastion#passwd$for%High_"
"SeaScourge30  :_This!is@Reinhardt#passwd$for%Sea_"
"ParrotJack67  :_This!is@Tracer#passwd$for%Parrot_"
"CannonDeck45  :_This!is@Moira#passwd$for%Cannon_"
"BarnacleBill98:_This!is@Roadhog#passwd$for%Barnacle_"
"StormBringer09:_This!is@Pharah#passwd$for%Storm_"
)

# Iterate through each user and perform updates
for entry in "${USERS[@]}"; do
  IFS=":" read -r username group password <<< "$entry"

  change_password "$username" "$password"
  adjust_permissions "$username" "$group"

  echo "User: $username | Password: $password | Group: $group"
done

echo "Password change and permission adjustment process completed."
