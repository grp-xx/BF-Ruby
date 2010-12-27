require 'rubygems'
require 'bloomfilter'

options = {
  :size => 100,       # size of bit vector
  :hashes => 2,       # number of hash functions
  :seed => rand(10),  # seed value for the filter
  :bucket => 1        # number of bits for the counting filter
}
 
# Regular, in-memory counting bloom filter	
bf = BloomFilter.new(options)

puts "List of words in the dictionary"

if ARGV.length != 1
  puts "usage: ruby bf-words <filename>"
  exit
end

filename = ARGV[0]

inputfile=File.open(filename)

inputfile.each do |word|
  bf.insert(word)
  puts word
end

inputfile.close

print "Check a word (Ctrl + D to terminate): "
while s = STDIN.gets do 
  puts bf.include?(s) 
  print "Check a word (Ctrl + D to terminate): "
end

puts "Statistics"

bf.stats
