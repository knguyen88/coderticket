class TicketType < ActiveRecord::Base
  belongs_to :event

  def min_quantity_to_purchase
    if !!min_quantity && 0 < min_quantity && min_quantity <= 10
      min_quantity
    else
      1
    end
  end

  def max_quantity_to_purchase
    if !!max_quantity && max_quantity <= 10
      max_quantity
    else
      10
    end
  end
end
