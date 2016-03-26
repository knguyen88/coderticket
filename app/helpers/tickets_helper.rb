module TicketsHelper
  def min_quantity(type)
    if type.min_quantity && type.min_quantity > 0
      type.min_quantity
    else
      1
    end
  end

  def max_quantity(type)
    if type.max_quantity && type.max_quantity <= 10
      type.max_quantity
    else
      10
    end
  end
end
