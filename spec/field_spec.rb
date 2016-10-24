require_relative '../field'

describe Field do
  it "should be created" do
    expect(Field.new({width: 4, height: 4, bombs_number: 8})).to be_present
  end

  it "should perform validation" do
    field = Field.new({width: 4, height: 4, bombs_number: 3})
    
    expect(field.send("valid?")).to be true
  end

  it "should not create invalid mask" do
    field = Field.new({width: 4, height: 4, bombs_number: 20})

    expect(field.mask).to be nil
  end

  it "should not create invalid map" do
    field = Field.new({width: 4, height: 4, bombs_number: "three"})

    expect(field.map).to be nil
  end

  it "should win the game" do
    field = Field.new({width: 4, height: 4, bombs_number: 1})

    empty_cell = field.mask.keys.select{|key| field.mask[key] == 0}.sample

    field.mask.each do |key,value|
      field.send("set_cell_value", key) if value != 1 and key != empty_cell
    end

    expect(field.play_round(empty_cell)).to eq "win"
  end

  it "should loose the game" do
    field = Field.new({width: 4, height: 4, bombs_number: 1})

    bomb_cell = field.mask.keys.select{|key| field.mask[key] == 1}.sample

    expect(field.play_round(bomb_cell)).to eq "loss"
  end
end