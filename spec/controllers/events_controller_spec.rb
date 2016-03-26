require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:user_1) { User.create!(email: 'test1', password: 'abc', password_confirmation: 'abc') }
  let(:user_2) { User.create!(email: 'test2', password: 'abc', password_confirmation: 'abc') }
  let(:past_event) { Event.create!(name: 'past_event',
                                   extended_html_description: 'past_event',
                                   venue: Venue.create,
                                   category: Category.create,
                                   starts_at: Date.new(2001, 1, 1)) }
  let(:future_event) { Event.create!(name: 'future_event',
                                     extended_html_description: 'future_event',
                                     venue: Venue.create,
                                     category: Category.create,
                                     starts_at: Date.new(3000, 1, 1)) }
  let(:published_event) { Event.create!(name: 'published_event',
                                        extended_html_description: 'published_event',
                                        venue: Venue.create,
                                        category: Category.create,
                                        starts_at: Date.new(3000, 1, 1),
                                        published: true,
                                        creator: user_1) }
  describe 'GET index' do
    it 'show only future and published events' do
      get :index
      expect(assigns[:events]).to eq([published_event])
    end
  end

  describe 'POST update' do
    it 'redirect when user is not admin' do
      session[:user_id] = user_2.id
      post :update, :id => published_event.id
      expect(response).to redirect_to(my_events_events_path)
    end
  end

  describe 'POST publish' do
    it 'redirect when user is not admin' do
      session[:user_id] = user_2.id
      post :publish, :id => published_event.id
      expect(response).to redirect_to(event_path(published_event))
    end
  end
end
