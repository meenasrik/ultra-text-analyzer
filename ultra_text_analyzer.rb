class UltraTextAnalyzer
  def self.analyze(text)
    if !text.is_a? String
      return nil
    else
      result = ""
      total = 0

      is_regex = /[a-zA-Z]\s+is/
      let_us_regex = /let\s+us/i
      i_regex = /(\W|^)I\s+(am|have|would|had|will)/
      are_regex = /(you|they|we)\s+are/i
      not_regex = /(must|might|should|could|did|do|would|will|had|has|have|were|was|are|is)\s+not/
      will_regex = /(you|he|she|it|we|they|that|who|what|where|when|why|how)\s+will/i
      have_regex = /(you|we|they)\s+have/i
      has_regex = /(he|she|it|that|who|what|where|when|why|how)\s+has/i
      had_regex = /(you|he|she|it|we|they|that|who|what|where|when|why|how)\s+had/i
      would_regex = /(you|he|she|it|we|they|that|who|what|where|when|why|how)\s+would/i
      cannot_regex = /cannot/

      total += text.scan(is_regex).length
      total += text.scan(let_us_regex).length
      total += text.scan(i_regex).length
      total += text.scan(are_regex).length
      total += text.scan(not_regex).length
      total += text.scan(will_regex).length
      total += text.scan(have_regex).length
      total += text.scan(has_regex).length
      total += text.scan(had_regex).length
      total += text.scan(would_regex).length
      total += text.scan(cannot_regex).length

      result += "#{text.split(" ").length} words "
      result += "#{text.length} characters "
      result += "#{text.count(' ')} spaces "
      result += "Longest word: #{longest(text)} "
      result += "Most common word: #{commonWord(text)} "
      result += "Contractable phrases: #{total} "
      
      result
    end
  end
end

def longest(text)
  # use regex to clean, split to array, sort by length desc - to get longest at first index
  str = text.gsub(/[^\w\s]/, '')
  arr = str.split(' ')
  arr = arr.sort{ |a, b| b.length <=> a.length}
  arr[0]
end

def commonWord(text) 
  # use regex to clean, split, use max_by to return the item repeated most in the array
  str = text.gsub(/[^\w\s]/, '').downcase()
  arr = str.split(" ")
  common = arr.max_by { |item| arr.count(item) }
end

# https://www.theschoolrun.com/what-are-contracted-words-or-contractions
