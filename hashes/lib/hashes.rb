# EASY

# Define a method that, given a sentence, returns a hash of each of the words as
# keys with their lengths as values. Assume the argument lacks punctuation.
def word_lengths(str)
    str.split.reduce({}) do |acc, word|
        acc[word] = word.length
        acc
    end 
end

# Define a method that, given a hash with integers as values, returns the key
# with the largest value.
def greatest_key_by_val(hash)
    result, max = '', -1.0/0
    hash.each do |key, val|
     result = val > max ? key : result
     max = [max, val].max
    end
    result
 end

# Define a method that accepts two hashes as arguments: an older inventory and a
# newer one. The method should update keys in the older inventory with values
# from the newer one as well as add new key-value pairs to the older inventory.
# The method should return the older inventory as a result. march = {rubies: 10,
# emeralds: 14, diamonds: 2} april = {emeralds: 27, moonstones: 5}
# update_inventory(march, april) => {rubies: 10, emeralds: 27, diamonds: 2,
# moonstones: 5}
def update_inventory(older, newer)
    newer.each { |key, val| older[key] = val }
    older
end

# Define a method that, given a word, returns a hash with the letters in the
# word as keys and the frequencies of the letters as values.
def letter_counts(word)
    word.chars.reduce({}) do |acc, char|
        acc[char] = word.count(char)
        acc
    end
end

# MEDIUM

# Define a method that, given an array, returns that array without duplicates.
# Use a hash! Don't use the uniq method.
def my_uniq(arr)
    counts = Hash.new(0)
    arr.each { |val| counts[val] = true }
    counts.keys
end

# Define a method that, given an array of numbers, returns a hash with "even"
# and "odd" as keys and the frequency of each parity as values.
def evens_and_odds(numbers)
    counts = Hash.new(0)
    numbers.each { |num| counts[num % 2 == 0 ? :even : :odd] += 1 }
    counts
end

# Define a method that, given a string, returns the most common vowel. Do
# not worry about ordering in the case of a tie. Assume all letters are 
# lower case.
def most_common_vowel(string)
    vowels = 'aeiou'  
    counts = Hash.new(0)

    string.chars.each { |char| counts[char] += 1 if vowels.include?(char) }
    
    counts
      .sort_by { |char, _| char }
      .max_by { |_, count| count }.first
end

# HARD

# Define a method that, given a hash with keys as student names and values as
# their birthday months (numerically, e.g., 1 corresponds to January), returns
# every combination of students whose birthdays fall in the second half of the
# year (months 7-12). students_with_birthdays = { "Asher" => 6, "Bertie" => 11,
# "Dottie" => 8, "Warren" => 9 }
# fall_and_winter_birthdays(students_with_birthdays) => [ ["Bertie", "Dottie"],
# ["Bertie", "Warren"], ["Dottie", "Warren"] ]
def fall_and_winter_birthdays(students)
    valid_students = students.select { |_, month| month >= 7 && month <= 12 }.keys

    result = []

    valid_students.each_with_index do |s1, idx|
      (idx + 1...valid_students.length).each { |idx2| result.push([s1, valid_students[idx2]]) }
    end

    result
end

# Define a method that, given an array of specimens, returns the biodiversity
# index as defined by the following formula: number_of_species**2 *
# smallest_population_size / largest_population_size biodiversity_index(["cat",
# "cat", "cat"]) => 1 biodiversity_index(["cat", "leopard-spotted ferret",
# "dog"]) => 9
def biodiversity_index(specimens)
    specimen_map = Hash.new(0)
    
    specimens.each { |specimen| specimen_map[specimen] += 1 }
    
    min = specimen_map.max_by { |specimen, count| count }.last
    max = specimen_map.min_by { |specimen, count| count }.last
    
    specimen_map.count ** 2 * min / max
end

# Define a method that, given the string of a respectable business sign, returns
# a boolean indicating whether pranksters can make a given vandalized string
# using the available letters. Ignore capitalization and punctuation.
# can_tweak_sign("We're having a yellow ferret sale for a good cause over at the
# pet shop!", "Leopard ferrets forever yo") => true
def build_map(string)
    string.delete("'.!,;?'")
    string.chars.reduce(Hash.new(0)) do |map, char|
        map[char.downcase] += 1
        map
    end
end

def can_tweak_sign?(normal_sign, vandalized_sign)
    normal_map, vandalized_map = build_map(normal_sign), build_map(vandalized_sign)

    vandalized_map.keys.all? do |char|
         normal_map[char] >= vandalized_map[char]
    end
end
