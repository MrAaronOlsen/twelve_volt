require './lib/twelve_volt'

class Swing
  attr_reader :p_links, :particles

  def initialize(position)
    @position = position
    @particles = []
    @p_links = []
  end

  def make_rod
    top = Particle.new
    top.position = @position

    bottom = Particle.new
    bottom.position = @position - Vector.new(0, 100)
    bottom.velocity = Vector.new(-10, 0)
    bottom.mass = 10

    @particles << top << bottom
    p_link = PLink::Rod.new(bottom, top, 200)
    @p_links << p_link
  end

  def draw
    @p_links.each do |plink|
      Gosu.draw_line( plink.p1.position.x, plink.p1.position.y, 0xff_ff0000,
				   				    plink.p2.position.x, plink.p2.position.y, 0xff_ff0000, 1 )
    end
  end

  def add_force(force)
    @particles[1].add_force(force)
  end
end

class Window < Gosu::Window

	def initialize
    $window_width = 1200
    $window_height = 1200

    super($window_width, $window_height, false)
    self.caption = "Swing"

    @end_time = 0
    @start_time = 0

    @swing = Swing.new(Vector.new(600, 600))
    @swing.make_rod

    @world = PWorld.new
    @world.p_links = @swing.p_links
    @world.particles = @swing.particles
 	end

	def update

    @end_time = Gosu::milliseconds
    delta_time = @end_time - @start_time

    unless delta_time <= 0.0
      @world.start_frame
      @world.update(delta_time)
      @start_time = @end_time
    end
  end

	def draw
    @swing.draw
	end

	def button_down(id)
    close if id == Gosu::KbEscape
    @swing.add_force(Vector.new(-100, 0)) if id == Gosu::KbLeft
    @swing.add_force(Vector.new(100, 0)) if id == Gosu::KbRight
  end
end

Window.new.show