require 'rails_helper'

RSpec.describe TicketType, type: :model do
  describe '#min_quantity_to_purchase' do
    subject(:ticket_type) { TicketType.create! }
    context 'when min_quantity is not set' do
      it 'return 1' do
        expect(ticket_type.min_quantity_to_purchase).to eq 1
      end
    end
    context 'when min_quantity is less than 0' do
      it 'return 1' do
        ticket_type.min_quantity = -10
        expect(ticket_type.min_quantity_to_purchase).to eq 1
      end
    end
    context 'when min_quantity is more than 10' do
      it 'return 1' do
        ticket_type.min_quantity = 11
        expect(ticket_type.min_quantity_to_purchase).to eq 1
      end
    end
    context 'when min_quantity is between 1 and 10' do
      it 'return min_quantity' do
        ticket_type.min_quantity = 5
        expect(ticket_type.min_quantity_to_purchase).to eq 5
      end
    end
  end

  describe '#max_quantity_to_purchase' do
    subject(:ticket_type) { TicketType.create! }
    context 'when max_quantity is not set' do
      it 'return 10' do
        expect(ticket_type.max_quantity_to_purchase).to eq 10
      end
    end
    context 'when max_quantity is less than 0' do
      it 'return 10' do
        ticket_type.min_quantity = -10
        expect(ticket_type.max_quantity_to_purchase).to eq 10
      end
    end
    context 'when max_quantity is more than 10' do
      it 'return 10' do
        ticket_type.min_quantity = 11
        expect(ticket_type.max_quantity_to_purchase).to eq 10
      end
    end
    context 'when max_quantity is between 1 and 10' do
      it 'return max_quantity' do
        ticket_type.max_quantity = 5
        expect(ticket_type.max_quantity_to_purchase).to eq 5
      end
    end
  end
end
