random_num=$(($RANDOM % 1001))
current_guess=0
guess_count=0

while [[ "$current_guess" != "$random_num" ]]; do
    read -p "Enter your guess: " current_guess
    if [[ "$current_guess" -lt "$random_num" ]]; then
        echo "Your guess was lower. Guess a higher number."
    elif [[ "$current_guess" -gt "$random_num" ]]; then
        echo "Your guess was higher. Guess a lower number."
    fi
    guess_count=$(($guess_count + 1))
done

echo "YOU GUESSED IT RIGHT!! ${random_num}. It took ${guess_count} guesses."

