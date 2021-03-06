describe "Co-branded" do

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

  it "empty wallet - good credit score - EW2" do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "AAdvantage®"
    choose_credit_score 'good'
    choose_card_by_name "Citi® / AAdvantage® Platinum Select® MasterCard®"
    approve_card
    setup_program '1-877-905-1861'
    activate_program true
    update_manualy
    get_signup_bonus
    remember_to_spend
    pie_have_program "AAdvantage®"
    logout
  end

  it 'use own card/program - good credit score - UO2' do
    register
    sleep 1
    wallet_add_new
    add_program_from_wallet 27
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
    choose_card_by_name("British Airways Visa Signature® Card")
    approve_card
    setup_program '1-800-432-3117'
    activate_program true
    update_manualy
    get_signup_bonus
    remember_to_spend
    pie_have_program "Executive Club"
    sleep 1
    go_to_wallet
    check_other_program 'Ultimate Rewards®'
    logout
  end

  it "empty wallet - good credit score - skip card - SC1" do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "AAdvantage®"
    choose_credit_score 'good'
    choose_card_by_name "Citi® / AAdvantage® Platinum Select® MasterCard®", false
    pie_have_reminder "AAdvantage®"
    find_el(:css, '.cabinet__program-popup-link').click
    activate_program false
    update_manualy
    pie_have_program "AAdvantage®"
    click_footer_reminder
    @wait.until { find_el(:css, 'h1.step-card__main-heading').displayed? }
    sleep 0.5
    expect(find_el(:css, 'h1.step-card__main-heading').text).to include("There's still time to get")
    go_to_wallet
    @wait.until { find_el(:class, 'wallet-program__img').displayed? }
    expect(find_el(:class, 'wallet-program__img')['alt']).to include 'AAdvantage®'
    expect(find_el(:class, 'wallet-program__credit-cards-msg').text).to include 'You have no credit cards'
    logout
  end

  # it "empty wallet - good credit score - pending - AP1" do
  #   sign_in
  #   fill_in_waypoint('JFK', 'LHR')
  #   monthly_spending
  #   choose_strategy_by_name "AAdvantage®"
  #   choose_card_by_name "Citi® / AAdvantage® Platinum Select® MasterCard®"
  #   pending_card
  #   pie_have_reminder "AAdvantage®"
  #   expect(find_el(:css, 'span.ready-step-notification__text').text).to include 'When you find out the status'
  #   click_footer_reminder
  #   @wait.until { find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-approved').displayed? }
  #   sleep 0.5
  #   go_to_wallet
  #   @wait.until { find_el(:css, 'h2.wallet__sub-heading').displayed? }
  #   expect(find_el(:css, 'h2.wallet__sub-heading').text).to include "We'll show you the best way to use them."
  #   reset_strategy
  #   logout
  # end

end
