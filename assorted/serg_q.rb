def substrings(string, results, tracker)
  return if string == ""
  if tracker[string].nil?
    results << string
    tracker[string] = true
  end
  string.chars.each_with_index do |char,index|
    new_string = string.dup
    new_string[index] = ''
    substrings(new_string, results, tracker)
  end
  return results
end

def get_longest_intersect(subs1, subs2)
  intersection = subs1 & subs2
  return intersection.sort_by{ |x| x.length}.last.length
end

def keystrokes(orig_s, new_s)
  worst_case = orig_s.length + new_s.length
  substring1 = substrings(orig_s, [], {})
  substring2 = substrings(new_s, [], {})
  longest_sub = get_longest_intersect(substring1, substring2)
  return (worst_case - (longest_sub * 2))
end
#
keystrokes('abcd', 'dbca')
keystrokes('abcdefg', 'bofgi')
