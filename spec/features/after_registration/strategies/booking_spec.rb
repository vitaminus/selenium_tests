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
    expect(find_els(:css, 'span.booking-step__data')[6].text.gsub(/(\d+ )/, '')).to eq 'miles'
    booking_open_social_link
    #share_trip
    #facebook failed cause there is a bug 6630
    logout
  end

  it 'Co-branded Strategy - BT2' do
    sign_in_for_cb_booking
    choose_strategy_with_enough_miles "AAdvantage®"
    choose_booking_program "AAdvantage®"

    @wait.until { find_el(:id, 'header-region').displayed? }
    header_info_data = find_els(:css, 'span.header__info-data')
    expect(header_info_data[0].text).to eq 'AAdvantage®'
    expect(header_info_data[1].text).to eq '60,000'
    expect(header_info_data[2].text).to eq 'N/A'
    expect(header_info_data[3].text).to eq '1-800-882-8880'
    booking_step1_links

    booking_continue

    expect(find_el(:class, 'location-field__input--from')[:value]).to eq('New York, NY, JFK')
    expect(find_el(:class, 'location-field__input--to')[:value]).to eq('London, LHR')
    expect(find_el(:class, 'booking-step__form-input')[:value]).to eq departure_date
    expect(find_el(:class, 'booking-step__return-date-picker')[:value]).to eq return_date
    expect(find_el(:class, 'parameter-field__result--economy').text).to include ('Economy').upcase
    expect(find_el(:class, 'parameter-field__result--roundtrip').text).to include ('Roundtrip').upcase
    expect(find_el(:id, 'booking-step__cost')[:value]).to eq '45000'
    expect(find_el(:id, 'booking-step__fees')[:value]).to eq '200'

    booking_continue

    booking_step_data = find_el(:class, 'booking-step__result--table').find_elements(:class, 'booking-step__data')
    expect(booking_step_data[0].text).to eq 'New York, NY'
    expect(booking_step_data[1].text).to eq departure_date
    expect(booking_step_data[2].text).to eq 'London'
    expect(booking_step_data[3].text).to eq return_date
    expect(booking_step_data[4].text).to eq 'Economy'
    expect(booking_step_data[5].text).to eq 'Roundtrip'
    booking_step_count = find_el(:class, 'booking-step__result--table').find_elements(:class, 'booking-step__count')
    expect(booking_step_count[0].text).to eq '45000'
    expect(booking_step_count[1].text).to eq '200'
    expect(find_els(:css, 'span.booking-step__data')[6].text.gsub(/(\d+ )/, '')).to eq 'miles'
    booking_open_social_link
    #share_trip
    #facebook failed cause there is a bug 6630
    logout
  end

  it 'Point Based Strategy - BT3' do
    sign_in_for_booking
    choose_strategy_with_enough_miles "Barclaycard Arrival Rewards Program"
    choose_booking_program "Barclaycard Arrival Rewards Program"

    @wait.until { find_el(:id, 'header-region').displayed? }
    header_info_data = find_els(:css, 'span.header__info-data')
    expect(header_info_data[0].text).to eq 'Barclaycard Arrival Rewards Program'
    expect(header_info_data[1].text).to eq '120,000'
    expect(header_info_data[2].text).to eq 'N/A'
    expect(header_info_data[3].text).to eq 'N/A'
    booking_step1_links

    booking_continue

    expect(find_el(:class, 'location-field__input--from')[:value]).to eq('New York, NY, JFK')
    expect(find_el(:class, 'location-field__input--to')[:value]).to eq('London, LHR')
    expect(find_el(:class, 'booking-step__form-input')[:value]).to eq departure_date
    expect(find_el(:class, 'booking-step__return-date-picker')[:value]).to eq return_date
    expect(find_el(:class, 'parameter-field__result--economy').text).to include ('Economy').upcase
    expect(find_el(:class, 'parameter-field__result--roundtrip').text).to include ('Roundtrip').upcase
    expect(find_el(:id, 'booking-step__cost')[:value]).to eq '95000'
    expect(find_el(:id, 'booking-step__fees')[:value]).to eq '0'

    booking_continue

    booking_step_data = find_el(:class, 'booking-step__result--table').find_elements(:class, 'booking-step__data')
    expect(booking_step_data[0].text).to eq 'New York, NY'
    expect(booking_step_data[1].text).to eq departure_date
    expect(booking_step_data[2].text).to eq 'London'
    expect(booking_step_data[3].text).to eq return_date
    expect(booking_step_data[4].text).to eq 'Economy'
    expect(booking_step_data[5].text).to eq 'Roundtrip'
    booking_step_count = find_el(:class, 'booking-step__result--table').find_elements(:class, 'booking-step__count')
    expect(booking_step_count[0].text).to eq '95000'
    expect(booking_step_count[1].text).to eq '0'
    expect(find_els(:css, 'span.booking-step__data')[6].text.gsub(/(\d+ )/, '')).to eq 'miles'
    booking_open_social_link
    #share_trip
    #facebook failed cause there is a bug 6630
    logout
  end

  it 'Transferable Strategy - BT4' do
    sign_in_for_booking
    choose_strategy_with_enough_miles "Iberia Plus"
    choose_booking_program "Iberia Plus"

    @wait.until { find_el(:id, 'header-region').displayed? }
    header_info_data = find_els(:css, 'span.header__info-data')
    expect(header_info_data[0].text).to eq 'Iberia Plus'
    expect(header_info_data[1].text).to eq '36,000'
    expect(header_info_data[2].text).to eq 'N/A'
    expect(header_info_data[3].text).to eq '1-800-772-4642'
    booking_step1_links

    booking_continue

    expect(find_el(:class, 'location-field__input--from')[:value]).to eq('New York, NY, JFK')
    expect(find_el(:class, 'location-field__input--to')[:value]).to eq('London, LHR')
    expect(find_el(:class, 'booking-step__form-input')[:value]).to eq departure_date
    expect(find_el(:class, 'booking-step__return-date-picker')[:value]).to eq return_date
    expect(find_el(:class, 'parameter-field__result--economy').text).to include ('Economy').upcase
    expect(find_el(:class, 'parameter-field__result--roundtrip').text).to include ('Roundtrip').upcase
    expect(find_el(:id, 'booking-step__cost')[:value]).to eq '26000'
    expect(find_el(:id, 'booking-step__fees')[:value]).to eq '240'

    booking_continue

    @wait.until { find_el(:class, 'booking-step__transferable-rate').displayed? }
    expect(find_el(:class, 'booking-step__transferable-rate').text).to include ('1:1.2')
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
    expect(booking_step_count[0].text).to eq '26000'
    expect(booking_step_count[1].text).to eq '240'
    expect(find_els(:css, 'span.booking-step__data')[6].text.gsub(/(\d+ )/, '')).to eq 'Avios'
    booking_open_social_link
    #share_trip
    #facebook failed cause there is a bug 6630
    logout
  end

  it 'Go_Back Button after step 1' do
    sign_in_for_cb_booking
    choose_strategy_with_enough_miles "AAdvantage®"
    choose_booking_program "AAdvantage®"
    @wait.until { find_el(:id, 'header-region').displayed? }
    find_el(:css, 'span.rewardexpert__mobile-invisible').click
    sleep 1
    expect(find_el(:css, 'h2.booking__body-heading').text).to eq 'Program(s) with enough miles/points to book.'
    logout
  end

  it 'Go_Back Button after step 2' do
    sign_in_for_cb_booking
    choose_strategy_with_enough_miles "AAdvantage®"
    choose_booking_program "AAdvantage®"
    @wait.until { find_el(:css, '.booking-steps__control.booking-steps__control--next').displayed? }
    booking_continue
    @wait.until { find_el(:id, 'header-region').displayed? }
    find_el(:css, 'span.rewardexpert__mobile-invisible').click
    sleep 1
    expect(find_el(:css, 'h2.booking__body-heading').text).to eq 'Program(s) with enough miles/points to book.'
    logout
  end

  it 'Go_Back Button after step 3' do
    sign_in_for_booking
    choose_strategy_with_enough_miles "Iberia Plus"
    choose_booking_program "Iberia Plus"
    @wait.until { find_el(:css, '.booking-steps__control.booking-steps__control--next').displayed? }
    booking_continue
    booking_continue
    @wait.until { find_el(:id, 'header-region').displayed? }
    find_el(:css, 'span.rewardexpert__mobile-invisible').click
    @wait.until { find_el(:css, 'h2.booking__body-heading').displayed? }
    expect(find_el(:css, 'h2.booking__body-heading').text).to eq 'Program(s) with enough miles/points to book.'
    logout
  end

  it 'Go_Back Button after step 4' do
    sign_in_for_booking
    choose_strategy_with_enough_miles "Iberia Plus"
    choose_booking_program "Iberia Plus"
    @wait.until { find_el(:css, '.booking-steps__control.booking-steps__control--next').displayed? }
    booking_continue
    booking_continue
    booking_continue
    @wait.until { find_el(:id, 'header-region').displayed? }
    find_el(:css, 'span.rewardexpert__mobile-invisible').click
    @wait.until { find_el(:css, 'h2.booking__body-heading').displayed? }
    expect(find_el(:css, 'h2.booking__body-heading').text).to eq 'Program(s) with enough miles/points to book.'
    logout
  end

  it 'Click on previous button after step 1' do
    sign_in_for_booking
    choose_strategy_with_enough_miles "Iberia Plus"
    choose_booking_program "Iberia Plus"
    @wait.until { find_el(:css, '.booking-steps__control.booking-steps__control--next').displayed? }
    booking_continue
    booking_previous
    expect(find_el(:css, 'h1.booking-step__heading').text).to eq 'Time to Check the Availability of Your Award Ticket'
    logout
  end

  it 'Click on previous button after step 2' do
    sign_in_for_booking
    choose_strategy_with_enough_miles "Iberia Plus"
    choose_booking_program "Iberia Plus"
    @wait.until { find_el(:css, '.booking-steps__control.booking-steps__control--next').displayed? }
    booking_continue
    booking_continue
    booking_previous
    expect(find_els(:css, 'h1.booking-step__heading')[1].text).to eq 'Check the value of the ticket you are planning to book.'
    logout
  end

  it 'Click on previous button after step 3' do
    sign_in_for_booking
    choose_strategy_with_enough_miles "Iberia Plus"
    choose_booking_program "Iberia Plus"
    @wait.until { find_el(:css, '.booking-steps__control.booking-steps__control--next').displayed? }
    booking_continue
    booking_continue
    booking_continue
    booking_previous
    expect(find_els(:css, 'h1.booking-step__heading')[2].text).to eq 'Ready to Book? You need to transfer points first.'
    logout
  end

  it 'Click on previous button after step 3 to step 1' do
    sign_in_for_booking
    choose_strategy_with_enough_miles "Iberia Plus"
    choose_booking_program "Iberia Plus"
    @wait.until { find_el(:css, '.booking-steps__control.booking-steps__control--next').displayed? }
    booking_continue
    booking_continue
    booking_continue
    booking_previous
    booking_previous
    booking_previous
    expect(find_els(:css, 'h1.booking-step__heading')[0].text).to eq 'Time to Check the Availability of Your Award Ticket'
    logout
  end

  it 'Click on upper book_block on strategies_page' do
    sign_in_for_booking
    @wait.until { find_el(:class, 'strategies__book-link').displayed? }
    find_el(:class, 'rewardexpert__mobile-invisible').click
    sleep 1
    expect(find_el(:css, 'h1.booking__panel-heading').text).to include ('London')
    choose_booking_program "Iberia Plus"
    @wait.until { find_el(:css, '.booking-steps__control.booking-steps__control--next').displayed? }
    expect(find_els(:css, 'h1.booking-step__heading')[0].text).to eq 'Time to Check the Availability of Your Award Ticket'
    logout
  end

  it 'Tooltip Starwood strategy' do
      sign_in_for_booking
      @wait.until { find_el(:class, 'strategies__book-link').displayed? }
      sleep 3
      find_el(:class, 'strategies__book-link').click
      choose_booking_program_column 'Executive Club', 'estimated_cost'
      #booking_program_tooltip 'Executive Club', 'starwood'

      logout
  end

end
