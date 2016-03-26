require 'rails_helper'
require 'spec_helper'

RSpec.describe 'events/show' do
  before do
    @event = Event.new(
        id: 1,
        extended_html_description: 'somewhere',
        venue: Venue.create,
        category: Category.create,
        starts_at: Date.today,
        ticket_types: [])
    @related_events = []
  end

  context 'when user is not authenticated' do
    before do
      allow(view).to receive(:can_edit?).and_return(false)
    end

    it 'should not show edit link' do
      render :template => 'events/show'
      expect(rendered).not_to match /Edit/
    end
  end

  context 'when user is authenticated' do
    before do
      allow(view).to receive(:can_edit?).and_return(true)
    end

    it 'should show edit link' do
      render :template => 'events/show'
      expect(rendered).to match /Edit/
    end
  end
end