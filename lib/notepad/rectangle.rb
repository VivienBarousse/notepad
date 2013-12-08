module Notepad
  class Rectangle

    attr_accessor :top, :bottom, :left, :right
    
    def initialize(top, bottom, left, right)
      @top = top
      @bottom = bottom
      @left = left
      @right = right
    end

    def area
      (@right - @left) * (@bottom - @top)
    end

    def intersect?(other)
      intersect_area(other) > 0
    end

    def intersect_area(other)
      x = [0, [right, other.right].min - [left, other.left].max].max
      y = [0, [bottom, other.bottom].min - [top, other.top].max].max
      x * y
    end

    def inspect
      [top, bottom, left, right].inspect
    end

    def width
      right - left
    end

    def height
      bottom - top
    end

    def ratio
      [height.to_f / width.to_f, width.to_f / height.to_f].min
    end

    def ==(other)
      [top, bottom, left, right] == [other.top, other.bottom, other.left, other.right]
    end

    def eql?(other)
      self == other
    end

    def hash
      top + bottom + left + right
    end

  end
end
