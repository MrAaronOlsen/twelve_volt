require 'date'

class Frame

  def initialize
    @frame_number = 0
    @last_frame_timestamp = DateTime.now.strftime('%Q').to_i
    @last_frame_duration = 0
    @last_frame_clockstamp = DateTime.now
    @last_frame_clockTicks = 0;

    @paused = false;
    @average_frame_duration = 0;
    @fps = 0;
  end

  def update
    @frame_number += 1 unless @paused
  end
end