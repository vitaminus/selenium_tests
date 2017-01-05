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
    sign_in_for_booking
    choose_strategy_with_enough_miles "MileagePlus®"
    choose_booking_program "MileagePlus®"

    @wait.until { find_el(:id, 'header-region').displayed? }
    header_info_data = find_els(:css, 'span.header__info-data')
    expect(header_info_data[0].text).to eq 'MileagePlus®'
    expect(header_info_data[1].text).to eq '67,500'
    expect(header_info_data[2].text).to eq 'N/A'
    expect(header_info_data[3].text).to eq '1-800-864-8331'
    
    booking_step1_links

    booking_continue

    expect(find_el(:class, 'location-field__input--from')[:value]).to eq('New York, NY, JFK')
    expect(find_el(:class, 'location-field__input--to')[:value]).to eq('London, LHR')
    expect(find_el(:class, 'booking-step__form-input')[:value]).to eq departure_date
    expect(find_el(:class, 'booking-step__return-date-picker')[:value]).to eq return_date
    expect(find_el(:class, 'parameter-field__result--economy').text).to include ('Economy').upcase
    expect(find_el(:class, 'parameter-field__result--roundtrip').text).to include ('Roundtrip').upcase
    expect(find_el(:id, 'booking-step__cost')[:value]).to eq '60000'
    expect(find_el(:id, 'booking-step__fees')[:value]).to eq '200'

    booking_continue

    @wait.until { find_el(:class, 'booking-step__transferable-rate--with_bonus').displayed? }
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

    booking_step_data = find_el(:class, 'booking-step__result--table').find_elements(:class, 'booking-step__data')
    expect(booking_step_data[0].text).to eq 'New York, NY'
    expect(booking_step_data[1].text).to eq departure_date
    expect(booking_step_data[2].text).to eq 'London'
    expect(booking_step_data[3].text).to eq return_date
    expect(booking_step_data[4].text).to eq 'Economy'
    expect(booking_step_data[5].text).to eq 'Roundtrip'
    booking_step_count = find_el(:class, 'booking-step__result--table').find_elements(:class, 'booking-step__count')
    expect(booking_step_count[0].text).to eq '60000'
    expect(booking_step_count[1].text).to eq '200'

    share_trip

    #facebook failed cause there is a bug 6630

  end

end
