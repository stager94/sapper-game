require "scanf"

class Object
  def present?
    ([nil,"",[],{}] & [self]).length == 0
  end

  def empty?
    !present?
  end
end

class Field
  attr_accessor :width
  attr_accessor :height
  attr_accessor :bombs_number
  attr_accessor :mask  # bombs mask
  attr_accessor :map   # map displayed for player

  def initialize(params={})
    if params.empty?
      set_field_params 
    else
      @width        = params[:width].to_i
      @height       = params[:height].to_i
      @bombs_number = params[:bombs_number].to_i
    end

    if valid?
      place_bombs
      
      fill_map
    end
  end

  def display_map(with_mask = false)
    if with_mask
      current_keys = []
      
      puts
      @map.each do |key,value|
        print " #{value}"
        current_keys << key
        
        if key[1] == @width - 1
          print " |"
          current_keys.each do |mask_key|
            print " #{@mask[mask_key]}"
          end
          puts
          current_keys = []
        end

      end
    else 
      puts
      @map.each do |key,value|
        print " #{value} "
        puts if key[1] == @width - 1
      end
    end
  end

  def play_round(params=[])
    x = params[0]
    y = params[1]

    if x.empty? or y.empty?
      puts
      print "You move (X Y): "
      gets.scanf("%d%d") do |d|
        x = d[0]
        y = d[1]
      end
    end

    if (x.empty? or y.empty?) or (x >= width or y >= height)
      puts "Input data invalid! Try again."
      return play_round
    end

    if @mask[[x,y]] == 1
      "loss"
    else
      open_cell([x,y])
    end
  end

  def valid?
    return false if @width.empty? and @height.empty? and @bombs_number.empty?
    return false if @bombs_number >= @width * @height 
    return false if @bombs_number * @width * height == 0
    return true
  end

protected

  def open_cell(cell)
    set_cell_value(cell)

    auto_open(cell)

    "win" if map_cleared?
  end

  def set_cell_value(cell)
    surrounding_bombs = 0
    (cell[0]-1..cell[0]+1).each do |x|
      (cell[1]-1..cell[1]+1).each do |y|
        if x >= 0 and x < width and y >= 0 and y < height and [x,y] != cell and @mask[[x,y]] == 1
          surrounding_bombs += 1
        end
      end
    end

    @map[cell] = surrounding_bombs
  end

  def auto_open(cell)
    opened_any = true
    while opened_any do
      opened_any = false
      @map.each do |key,value|
        if value == 0
          (key[0]-1..key[0]+1).each do |x|
            (key[1]-1..key[1]+1).each do |y|
              if x >= 0 and x < width and y >= 0 and y < height and [x,y] != key and @map[[x,y]] == "X" and @mask[[x,y]] != 1
                set_cell_value([x,y])
                opened_any = true
              end
            end
          end
        end
      end
    end
  end

  def map_cleared?
    @mask.all?{|key,value| (value == 0 and @map[key] != "X") or (value == 1 and @map[key] == "X")}
  end

  def set_field_params
    # set field size
    print "Enter field size (X Y): "
    gets.scanf("%d%d") do |d|
      @width  = d[0]
      @height = d[1]
    end

    # set bombs number
    print "Enter mines count: "
    gets.scanf("%d") do |d|
      @bombs_number = d[0]
    end
  end

  def place_bombs
    @mask = {}

    free_cells  = (0..@width-1).map{|w| (0..@height-1).map{|h| [w,h]}}.flatten(1)
   
    free_cells.each{|cell| @mask[cell] = 0}

    bombs_number.times do 
      bomb         = free_cells.sample
      @mask[bomb]  = 1

      free_cells.delete(bomb)
    end
  end

  def fill_map
    @map = @mask.clone
    @map.each{|key,value| @map[key] = "X"}
  end

end