

class Utils

  def self.genRandom(times)
    i = times.to_i
    o = [('a'..'z'), ('A'..'Z'), (0..9)].map {|i| i.to_a}.flatten
    str = (0...i).map {o[rand(o.length)]}.join
    return str
  end

end