class Hangman

    def initialize
        @word = Word.new.generate_word.split('')
        @attempts = 0
        @right_letters = Array.new
        @wrong_letters = Array.new
        @progress = Array.new(@word.length, '_')
    end

    def play_game
        positions = Array.new
        puts @word
        resolving_guess(input_letter)

        check_game_state()
    end

    def input_letter
        puts "Insert letter"
        letter = gets.chomp.downcase
        until letter.length == 1 && letter <= "z" && letter >= "a" do
            puts "Please insert a letter, not some weird character"
            letter = gets.chomp.downcase
        end
        letter
    end

    def check_letter(letter)
        @word.include?(letter)
    end

    def resolving_guess(letter)
        if check_letter(letter) == true
            guess_right(letter)
        else
            guess_wrong(letter)
        end
    end

    def guess_right(letter)
        @right_letters.push(letter)
        positions.clear
        @word.each_with_index do | element, index |
            if element == letter
                @word[index] = nil
                positions.push(index)
            end
        end
        positions
    end

    def guess_wrong(letter)
        @wrong_letters.push(letter)
        @attempts += 1
    end

    def check_game_state
        if @word.empty? == true
            puts "Congratulations, you won!"
        elsif @attempts == 12
            puts "You lost, buddy. Better luck next time!"
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