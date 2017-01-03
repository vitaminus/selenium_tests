describe "Book tickets" do

  before(:all) do
    @d = driver
    window_size
    @wait = wait
    @long_wait = long_wait
  end

  before(:each) do
    navigate_to
    code_word
  end

  after(:all) do
    quit
  end

  it 'Starwood strategy - BT1' do
    register
    wallet_add_new
    add_program_from_wallet 1
    close_learning_popup
    switch_to_manual
    enter_balance 60000
    sleep 2
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    wallet_add_more
    sleep 1.5
    el = find_els(:class, "accounts__block-name")[18]
    el.location_once_scrolled_into_view
    el.click
    sleep 1
    find_el(:class, 'cards-and-programs__save-btn').click
    enter_balance 30000
    
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_with_enough_miles "MileagePlus®"
    choose_booking_program "MileagePlus®"
    booking_step1_links

    booking_continue

    expect(find_el(:class, 'parameter-field__result--economy').text).to include ('Economy').upcase
    sleep 2
    expect(find_el(:class, 'parameter-field__result--roundtrip').text).to include ('Roundtrip').upcase
    expect(find_el(:id, 'booking-step__cost')[:value]).to eq '60000'
    expect(find_el(:id, 'booking-step__fees')[:value]).to eq '200'

    booking_continue

    expect(find_el(:class, 'booking-step__transferable-rate--with_bonus').text).to include ('2:1')
    @wait.until { find_el(:class, 'booking-step__transfer-btn').displayed? }
    find_el(:class, 'booking-step__transfer-btn').click
    sleep 2
    close_window
    @wait.until { find_el(:class, 'booking-step__transferable-help-link').displayed? }
    find_el(:class, 'booking-step__transferable-help-link').click
    sleep 2
    close_window

    booking_continue

    booking_step__data = find_el(:class, 'booking-step__result--table').find_elements(:class, 'booking-step__data')
    expect(booking_step__data[0].text).to eq 'New York, NY'
    expect(booking_step__data[1].text).to eq departure_date
    expect(booking_step__data[2].text).to eq 'London'
    expect(booking_step__data[3].text).to eq return_date
    expect(booking_step__data[4].text).to eq 'Economy'
    expect(booking_step__data[5].text).to eq 'Roundtrip'

    booking_step__count = find_el(:class, 'booking-step__result--table').find_elements(:class, 'booking-step__count')
    expect(booking_step__count[0].text).to eq '60000'
    expect(booking_step__count[1].text).to eq '200'



  end

end
