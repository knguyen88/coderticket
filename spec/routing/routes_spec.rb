describe :routing do
  it 'should not have route to delete event' do
    expect(:delete => event_path(123)).not_to be_routable
  end
  it 'should not have route to delete ticket' do
    expect(:delete => event_ticket_path(123, 456)).not_to be_routable
  end
  it 'should not have route to update ticket' do
    expect(:put => event_ticket_path(123, 456)).not_to be_routable
    expect(:patch => event_ticket_path(123, 456)).not_to be_routable
  end
end