require 'set'

def words(text)
  text.downcase.scan /[a-z]+/ 
end

def train(features)
  features.inject(Hash.new(1)){|model, f| model[f] += 1; model }
end

NWORDS = train(words(File.open('big.txt').read))

ALPHABET = 'abcdefghijklmnopqrstuvwxyz'.split //

def edits1(word)
  s = (0..word.size).map{|i| [word[0,i], word[i,word.size]]}
  deletes    = s.map{|a,b| !b.empty? ? a + b[1..-1] : nil}.compact
  transposes = s.map{|a,b| b.size > 1 ? a + b[1].chr + b[0].chr + b[2..-1] : nil}.compact
  replaces   = s.map{|a,b| !b.empty? ? ALPHABET.map{|c| a + c + b[1..-1]} : nil}.flatten.compact
  inserts    = s.map{|a,b| ALPHABET.map{|c| a + c + b}}.flatten
  Set.new(deletes + transposes + replaces + inserts)
end

def known_edits2(word)
  s = edits1(word).map do |e1| 
    edits1(e1).map{|e2| NWORDS.include?(e2) ? e2 : nil}.compact
  end.flatten
  s.empty? ? nil : Set.new(s)
end

def known(words)
  s = Set.new(words.find{|w| NWORDS.include?(w)})
  s.empty? ? nil : s
end

def correct(word)
  candidates = known([word]) || known(edits1(word)) || known_edits2(word) || [word]
  candidates.max{|a,b| NWORDS[a] <=> NWORDS[b] }
end
