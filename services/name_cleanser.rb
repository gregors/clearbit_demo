# frozen_string_literal: true

class NameCleanser
  def self.clean(text)
    return 'uber' if text =~ /uber \d+ .+[*]+pool[*]+$/i
    return 'SparkFun Electronics' if text =~ /^sparkfun$/i
    text
  end
end
