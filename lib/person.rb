class Person
  attr_reader :name,
              :interests,
              :supplies

  def initialize(info)
    @name = info[:name]
    @interests = info[:interests]
    ###Understand this
    @supplies = Hash.new(0)
  end

  def add_supply(item, quantity)
    @supplies[item] += quantity
  end

  def can_build?(craft)
    craft.supplies_required.all? do |supply, quantity|
      @supplies[supply.to_s] >= quantity
    end

    # craft.supplies_required.none? do |supply, quantity|
    #   @supplies[supply.to_s] < quantity
    # end

  #   has_enough = true
  #   craft.supplies_required.each do |item, count|
  #     if @supplies[supply.to_s] < quantity
  #       has_enough = false
  #     end
  #   end
  #   has_enough

  end
end
