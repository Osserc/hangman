class Hangman

    def initialize
        @word = Word.new.generate_word.split('')
        @attempts = 10
        @right_letters = Array.new
        @wrong_letters = Array.new
        @progress = Array.new(@word.length, '_')
    end

    def play_game
        puts "You made it just in time! Dirty Don is convinced Jimbo is a fed and is going to hang him in front of the whole town!\nThe only way to save him is to guess a secret password that Don made up, one letter at a time. Be careful though, we only have 10 tries!\nPlease friend, save Jimbo! He did nothing wrong!\n\n"
        puts @word.join
        display_state_of_the_game
        while @attempts > 0 do
            resolving_guess(input_action)
            display_state_of_the_game
            check_game_state()
        end
    end

    def input_action
        puts "\nCome on, let\'s try a letter!"
        letter = gets.chomp.downcase
        until letter.length == 1 && letter <= "z" && letter >= "a" && (@right_letters + @wrong_letters).include?(letter) == false do
            if (@right_letters + @wrong_letters).include?(letter) == true
                puts "\nYou already tried #{letter}, we can\'t wast any time retreading old ground!"
            else
                puts "\nPlease take this seriously, Jimbo\'s life is at stake!"
            end
            letter = gets.chomp.downcase
        end
        letter
    end

    def check_letter(letter)
        @word.include?(letter)
    end

    def resolving_guess(letter)
        if check_letter(letter) == true
            positions = guess_right(letter)
            update_progress(positions, letter)
        else
            guess_wrong(letter)
        end
    end

    def guess_right(letter)
        @right_letters.push(letter)
        positions = Array.new
        @word.each_with_index do | element, index |
            if element == letter
                positions.push(index)
            end
        end
        positions
    end

    def guess_wrong(letter)
        @wrong_letters.push(letter)
        @attempts -= 1
    end

    def save_game(letter)

    end

    def load_game(letter)

    end

    def update_progress(positions, letter)
        i = 0
        @progress.each_with_index do | element, index |
            if index == positions[i]
                @progress[index] = letter
                i += 1
            end
        end
    end

    def display_state_of_the_game
        puts "\nRight letters: #{@right_letters.join(" ")} | Wrong letters: #{@wrong_letters.join(" ")} | Turns until Jimbo gets it: #{@attempts}."
        puts @progress.join(" ")
    end

    def check_game_state()
        if @word == @progress
            puts "\nYou saved Jimbo! I\'ll forever be in your debt!\n"
            decide_future
        elsif @attempts == 0
            puts "\nYou... you killed Jimbo! And all becase you couldn\'t figure out that the secret password was '#{@word.join}'! Pray our paths never cross again...\n"
            decide_future
        end
    end

    def decide_future
        puts "\nWould you like to play again?"
        answer = gets.chomp.downcase
        until answer == "yes" || answer == "no"
            puts "\nCome on, it\'s a yes or no question."
            answer = gets.chomp.downcase
        end
        if answer == "yes"
            Hangman.new.play_game
        else
            exit
        end
    end
end

class Dictionary
    def retrieve_dictionary
        File.readlines("dictionary.txt", chomp: true)
    end

    def purge_dictionary(word_pool)
        word_pool.each_with_index do | word, index |
            if word.length < 5 || word.length > 12
                word_pool[index] = nil
            end
            word.downcase!
        end
        word_pool.compact!
    end

    def dictionary
        purge_dictionary(retrieve_dictionary)
    end
end

class Word
    def generate_word
        Dictionary.new.dictionary.sample
    end

end

Hangman.new.play_game