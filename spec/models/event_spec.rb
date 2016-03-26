require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#outdated?' do
    context 'when starts_at is before today' do
      it 'should return true' do
        event = Event.new(starts_at: Date.new(2001, 2, 3))
        expect(event.outdated?).to eq true
      end
    end
    context 'when starts_at is after today' do
      it 'should return false' do
        event = Event.new(starts_at: Date.new(3000, 2, 3))
        expect(event.outdated?).to eq false
      end
    end
  end

  describe '#can_publish?' do
    subject(:event) { Event.create!(extended_html_description: 'somewhere',
                                    venue: Venue.create,
                                    category: Category.create,
                                    starts_at: Date.today) }
    context 'when event is already published' do
      it 'should return false' do
        event.published = true
        expect(event.can_publish?).to eq false
      end
    end

    context 'when event is not published' do
      context 'when event has no ticket type' do
        it 'should return false' do
          expect(event.can_publish?).to eq false
        end
      end
      context 'when event has at least 1 ticket type' do
        it 'should return true' do
          TicketType.create(event: event)
          expect(event.can_publish?).to eq true
        end
      end
    end
  end

  describe '#create' do
    context 'when an event is created' do
      it 'should add creator as admin' do
        event = Event.create!(extended_html_description: 'somewhere',
                              venue: Venue.create,
                              category: Category.create,
                              starts_at: Date.today,
                              creator: User.create!(email: 'test', password: 'abc', password_confirmation: 'abc'))
        expect(event.admins).to include(event.creator)
      end
    end
  end
end
