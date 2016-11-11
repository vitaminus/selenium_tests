describe "Set new goal" do

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

  it "add FF program (manual update) with balance = 0 - WL01" do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "AAdvantage®"
    choose_credit_score 'good'
    choose_card_by_name "Citi® / AAdvantage® Platinum Select® MasterCard®"
    pending_card
    pie_have_reminder "AAdvantage®"
    @wait.until { find_el(:link_text, 'SET NEW GOAL').displayed? }
    sleep 0.3
    find_el(:link_text, 'SET NEW GOAL').click
    sleep 0.3
    @wait.until { find_el(:id, 'confirmation-popup__cancel').displayed? }
    sleep 0.3
    find_el(:id, 'confirmation-popup__cancel').click
    sleep 0.5
    pie_have_reminder "AAdvantage®"
    # reset_strategy
    logout
  end

end
