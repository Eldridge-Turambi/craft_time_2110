require './lib/person'
require './lib/craft'
require './lib/event'

RSpec.describe Event do
  before :each do
    @person = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})
    @toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
    @tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting']})
    @hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing']})


    @craft = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    @sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1, sewing_needles: 1})
    @knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    @painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})


    @event = Event.new("Carla's Craft Connection", [@craft], [@person])
    @event1 = Event.new("Carla's Craft Connection", [@sewing, @knitting], [@hector, @toni])
    @event2 = Event.new("Carla's Craft Connection", [@knitting, @painting, @sewing], [@hector, @toni, @tony])
  end

  it 'exists' do
    expect(@event).to be_an_instance_of(Event)
  end

  it 'has attributes' do
    expect(@event.name).to eq("Carla's Craft Connection")
    expect(@event.crafts).to eq([@craft])
    expect(@event.attendees).to eq([@person])
  end

  it '#attendee_names' do
    expect(@event1.attendee_names).to eq(['Hector', 'Toni'])
  end

  it '#craft_with_most_supplies' do
    expect(@event1.craft_with_most_supplies).to eq('sewing')
  end

  it '#supply_list' do
    expect(@event1.supply_list).to eq(["fabric", "scissors", "thread", "sewing_needles", "yarn", "knitting_needles"])
  end

  it '#attendees_interested_in_craft' do
    expect(@event2.attendees_interested_in_craft('sewing')).to eq([@hector, @toni])

  end

  it '#attendees_by_craft_interest' do
    expected = {
      "knitting"=>[@toni,@tony],
      "painting"=>[],
      "sewing"=>[@hector, @toni]
    }
    expect(@event2.attendees_by_craft_interest).to eq(expected)
  end

  it '#crafts_that_use' do
    expect(@event2.crafts_that_use('scissors')).to eq([@knitting, @sewing])
    expect(@event2.crafts_that_use('fire')).to eq([])
  end

  it '#assign_attendees_to_crafts' do
    hector = Person.new({name: 'Hector', interests: ['sewing', 'millinery', 'drawing', 'painting']})
    toni = Person.new({name: 'Toni', interests: ['sewing', 'knitting']})
    tony = Person.new({name: 'Tony', interests: ['drawing', 'knitting', 'painting']})

    knitting = Craft.new('knitting', {yarn: 20, scissors: 1, knitting_needles: 2})
    sewing = Craft.new('sewing', {fabric: 5, scissors: 1, thread: 1})
    painting = Craft.new('painting', {canvas: 1, paint_brush: 2, paints: 5})

    event_3 = Event.new("Carla's Craft Connection", [knitting, painting, sewing], [hector, toni, tony])

    @toni.add_supply('yarn', 30)
    @toni.add_supply('scissors', 2)
    @toni.add_supply('knitting_needles', 5)
    @toni.add_supply('fabric', 10)
    @toni.add_supply('scissors', 1)
    @toni.add_supply('thread', 2)
    @toni.add_supply('paint_brush', 10)
    @toni.add_supply('paints', 20)
    @tony.add_supply('yarn', 20)
    @tony.add_supply('scissors', 2)
    @tony.add_supply('knitting_needles', 2)
    @hector.add_supply('fabric', 5)
    @hector.add_supply('scissors', 1)
    @hector.add_supply('thread', 1)
    @hector.add_supply('canvas', 5)
    @hector.add_supply('paint_brush', 10)
    @hector.add_supply('paints', 20)

    # hector can build painting and sewing
    # toni can build knitting and sewing
    # tony can build knitting
    ## All are interested in everything they are able to build

    expected = {
      knitting => [],
      sewing => [],
     sewing => []
    }

    assigned_attendees = event_3.assign_attendees_to_crafts
    expect(assigned_attendees[knitting]).to be_an(Array)
    expect(assigned_attendees[sewing]).to be_an(Array)
    expect(assigned_attendees[painting]).to be_an(Array)
    expect(assigned_attendees.count).to eq(3)
  end
end
