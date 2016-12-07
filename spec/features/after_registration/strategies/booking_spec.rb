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
    @wait.until { find_el(:class, 'booking-step__external-link').displayed? }
    find_el(:class, 'booking-step__external-link').click
    sleep 2
    close_window
    @wait.until { find_el(:id, 'booking-step__how-to-buy-link').displayed? }
    find_el(:id, 'booking-step__how-to-buy-link').click
    close_window
    @wait.until { find_el(:css, '.booking-steps__control.booking-steps__control--next').displayed? }
    find_el(:css, '.booking-steps__control.booking-steps__control--next').click
   
   

    sleep 5

  end

end
