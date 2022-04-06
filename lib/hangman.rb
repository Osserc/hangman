class Hangman

    def play_game
        word = Word.new.generate_word
        puts word
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