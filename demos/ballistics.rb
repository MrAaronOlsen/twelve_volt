require './lib/twelve_volt'

class Balistic
  attr_reader :body, :life_span

  def initialize
    @body = Particle.new
    @born = Gosu::milliseconds
    @life_span = 0

    set
  end

  def update(duration)
    @life_span = Gosu::milliseconds - @born

    @body.integrate(duration)
  end

  def draw
    Gosu.draw_line(@body.position.x, @body.position.y, 0xff_00ff00,
					   				 @body.position.x+1, @body.position.y+1, 0xff_00ff00, 1)
  end

  def invalid?
    @life_span > 10000 || @body.position.x > 1000
  end

  private

  def set
    @body.mass = 2.0
    @body.velocity = Vector.new(500.0, 0.0)
    @body.acceleration = Vector.new(0.0, 10.0)
    @body.position = Vector.new(0, 600)
    @body.damping = 0.89
  end
end


class Window < Gosu::Window

	def initialize
    $window_width = 1200
    $window_height = 1200

    super($window_width, $window_height, false)
    self.caption = "Balistic"
    @end_time = 0
    @start_time = 0

    @shots = []
 	end

	def update

    @end_time = Gosu::milliseconds
    @delta_time = @end_time - @start_time

    unless @delta_time <= 0.0

      @shots.each do |shot|
        shot.update(@delta_time * 0.001)
        @shots.delete(shot) if shot.invalid?
      end

      @start_time = @end_time
    end
  end

	def draw
    @shots.each { |shot| shot.draw }
	end

	def button_down(id)
    close if id == Gosu::KbEscape
  end

  def button_up(id)
    @shots << Balistic.new if id == Gosu::KbSpace
  end

end

Window.new.show