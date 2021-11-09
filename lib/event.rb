class Event
  attr_reader :name,
              :crafts,
              :attendees

  def initialize(name, crafts, attendees)
    @name = name
    @crafts = crafts
    @attendees = attendees
  end

  def attendee_names
    @attendees.map do |attendee|
      attendee.name
    end
  end

  def craft_with_most_supplies
    craft = @crafts.max_by do |craft|
      craft.supplies_required.keys.count
    end
    craft.name
  end

  def supply_list
    @crafts.map do |craft|
      craft.supplies_required.keys.map do |key|
        key.to_s
      end
    end.flatten.uniq
  end

  def attendees_interested_in_craft(craft_string)
    @attendees.find_all do |attendee|
      attendee.interests.include?(craft_string)
    end
  end

  def attendees_by_craft_interest
    new_hash = {}
    keys = @crafts.map do |craft|
      craft.name
    end

    keys.each do |key|
      new_hash[key] = @attendees.find_all { |attendee|  attendee.interests.include?(key) }
    end
    new_hash
  end

  def crafts_that_use(supply_string)
    @crafts.find_all do |craft|
      craft.supplies_required.keys.include?(supply_string.to_sym)
    end
  end
end
