class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    contents = File.read(filename).downcase.gsub("--", " ")
    contents = contents.gsub(/[^a-z0-9\s]/i, "")
    word_array = contents.split(" ") - STOP_WORDS

    @words = {}

    word_array.each do |word|
      if @words.include?(word)
        @words[word] += 1
      else
        @words[word] = 1
      end
  end
  top_words(5)
end



  def frequency(word)
    freq_words = 0
    @words.map {|line| freq_words += line.scan(/(\s#{word}\s)+/).length}
    freq_words
    if @words.has_key?(word)
      return frequencies[word]
    else
      0
  end
end

  def frequencies
    result = Hash.new()

    #Put every word in file into array
    array_words = []
    @words.each do |line|
      line.scan(/(\w+)+/).map {|word| array_words.push(word[0].to_s)}
  end
    #remove stop words
    array_words -= STOP_WORDS

    array_words.each do |word|
      if(result[word].nil?)
        result[word] = 1
      else
        result[word] = result[word].to_i + 1
      end
    end

    result

  end


  def top_words(number)
    result = frequencies.sort_by {|k, v| v}.reverse
    result.take(number)
    @words.sort_by { |word, count| count }.reverse.take(5)
  end


  def print_report
    
    top10 = top_words(10)
    top10 = @words.sort_by { |word, count| count }.reverse.take(10).to_h

    top10.each { |word_and_count|
    # result = top10.each do |key, value|
      stars = "*" * word_and_count[1]
      puts "#{word_and_count[0]} | #{word_and_count[1]} #{stars}"
    }
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)


      wf.top_words(8)
      wf.frequencies
      wf.print_report

    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
