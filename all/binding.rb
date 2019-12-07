# frozen_string_literal: true

puts [1, 2, 3].inject(&:+) # 6

def get_binding
  binding
end

class Monk
  def get_binding
    binding
  end
end

puts eval('self', get_binding) # main
puts eval('self', Monk.new.get_binding) # #<Monk:0x00007fab4c1aa2f8>
