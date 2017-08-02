module A
  def hi
    p 'hi from A'
  end
end

module B
  include A

  def hi
    p 'hi from B'
    super
  end
end

class C
  include B
end

C.new.hi
