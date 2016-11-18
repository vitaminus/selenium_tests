describe "Transferable" do

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

  it "empty wallet - good credit score - EW4" do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Executive Club"
    choose_credit_score 'good'
    choose_card_by_name("Business Platinum Card®")
    approve_card
    update_manualy
    get_signup_bonus
    activate_program false
    update_manualy
    remember_to_spend
    pie_have_program "Membership Rewards®"
    pie_have_program "Executive Club"
    miles_in_pie "0"
    logout
  end

  it 'use own card/program - good credit score - UO3' do
    register
    wallet_add_new
    add_program_from_wallet 2
    close_learning_popup
    switch_to_manual
    enter_balance 0
    sleep 2
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Executive Club"
    choose_credit_score 'good'
    choose_card_by_name("Chase Sapphire Preferred® Card")
    approve_card
    update_manualy
    get_signup_bonus
    activate_program false
    update_manualy
    remember_to_spend
    pie_have_program "Ultimate Rewards®"
    pie_have_program "Executive Club"
    sleep 0.5
    go_to_wallet
    check_other_program 'Starwood Preferred Guest®'
    logout
  end

end
