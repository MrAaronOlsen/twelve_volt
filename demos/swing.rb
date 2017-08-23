require './lib/twelve_volt'

class Swing
  attr_reader :p_links, :particles

  def initialize(position)
    @position = position
    @particles = []
    @p_links = []
  end

  def make_link
    head = Particle.new
    head.position = @position
    head.mass = 0

    link = Particle.new
    link.position = @position + Vector.new(0, 100)
    link.mass = 10

    @particles << head << link
    @p_links << PLink::Cable.new(head, link, 100, 1)
  end

  def draw
    @p_links.each do |plink|
      Gosu.draw_line( plink.p1.position.x, plink.p1.position.y, 0xff_ff0000,
                      plink.p2.position.x, plink.p2.position.y, 0xff_ff0000, 1 )
    end
  end

  def add_force(force)
    @particles.last.add_force(force)
  end

  def make_cable(last)
    bottom = Particle.new
    bottom.position = last.position + Vector.new(0, 1)
    bottom.mass = 10

    @particles << bottom
    @p_links << PLink::Cable.new(last, bottom, 1, 1)
    bottom
  end

  def make_chain
    head = Particle.new(@position)
    head.mass = 0
    @particles << head

    last = make_cable(head)

    10.times do
      last = make_cable(last)
    end
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
    @swing.make_chain

    @world = PWorld.new
    @world.p_links = @swing.p_links
    @world.particles = @swing.particles
 	end

	def update

    @end_time = Gosu::milliseconds
    @delta_time = @end_time - @start_time

    unless @delta_time <= 0.0
      @world.start_frame
      @world.update(0.16)

      @start_time = @end_time
    end
  end

	def draw
    @swing.draw
	end

	def button_down(id)
    close if id == Gosu::KbEscape
    @swing.particles.last.velocity.add!(Vector.new(-100, 0)) if id == Gosu::KbLeft
    @swing.particles.last.velocity.add!(Vector.new(100, 0)) if id == Gosu::KbRight
    @swing.particles.last.velocity.add!(Vector.new(0, -100)) if id == Gosu::KbUp
    @swing.particles.last.velocity.add!(Vector.new(0, 100)) if id == Gosu::KbDown
  end
end

Window.new.show