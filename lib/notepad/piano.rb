module Notepad
  class Piano

    SOUND_FOLDER = File.expand_path('../sounds/piano', ROOT) + '/'

    def initialize(size)
      @size = size
      @pressed = []
    end

    def press(i)
      i = i.to_i
      fork do
        exec("mplayer -ao oss #{SOUND_FOLDER}/#{"%02d" % i}.wav 2>/dev/null >/dev/null")
      end
    end

    def set_pressed(i)
      return if i < 1 || i > @size
      val = @pressed[i]
      @pressed[i] = 1
      if val == 0
        press(i)
      end
    end

    def set_released(i)
      return if i < 1 || i > @size
      @pressed[i] = 0
    end

  end
end
