

def retrieve_dictionary
    word_pool = File.readlines("dictionary.txt", chomp: true)
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
    word_pool = purge_dictionary(retrieve_dictionary)
end

def pick_word(word_pool)
    word_pool.sample
end

def test   
    puts pick_word(dictionary)
end

test