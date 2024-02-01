require 'ruby2d'

set title: 'Aim Trainer'
set background: 'green'

message = Text.new('Click to Begin')
hits_counter_number = 0
hits_counter = Text.new("Hits #{hits_counter_number}", 
                  x: get(:width) - 60, 
                  y: (get(:height) - get(:height) + 5))
miss_counter_number = 0
miss_counter = Text.new("Miss #{miss_counter_number}",
                        x: get(:width) - 140,
                        y: (get(:height) - get(:height) + 5))
accuracy_number = 0
accuracy = Text.new("#{accuracy_number}%",
                    x: get(:width) - 190,
                    y: (get(:height) - get(:height) + 5))

game_started = false
square = nil
start_time = nil
duration = nil

on :mouse_down do |event|
  if game_started
    if square.contains?(event.x, event.y)
      duration = ((Time.now - start_time) * 1000).round
      message = Text.new("You took #{duration},  milliseconds, Click to Begin")
      square.remove
      hits_counter_number += 1
      hits_counter.remove
      hits_counter = Text.new("Hits #{hits_counter_number}",
                         x: get(:width) - 60,
                         y: (get(:height) - get(:height) + 5))
      if miss_counter_number.zero?
        accuracy_number = 100
        accuracy.remove
        accuracy = Text.new("#{accuracy_number}%",
                           x: get(:width) - 200,
                           y: (get(:height) - get(:height) + 5))
      else
        accuracy_number = (1 - miss_counter_number.to_f / hits_counter_number)
        accuracy_number = sprintf("%.2f", accuracy_number)
        accuracy.remove
        accuracy = Text.new("#{accuracy_number}%",
                           x: get(:width) - 200,
                           y: (get(:height) - get(:height) + 5))
      end
      game_started = false
    else
      miss_counter.remove
      miss_counter_number += 1
      miss_counter =  Text.new("Miss #{miss_counter_number}",
                               x: get(:width) - 140,
                               y: (get(:height) - get(:height) + 5))
    end
  else
    message.remove

    square = Square.new(
         x: rand(get(:width) - 25), y: rand(get(:height) - 25),
         size: 25,
         color: 'purple'
       )

    start_time = Time.now
    game_started = true
  end
end



show
