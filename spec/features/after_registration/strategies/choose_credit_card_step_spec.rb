describe "Choose credit card step" do

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

  it 'go back to Planning Strategies page with the help of header - NNC1' do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Aadvantage®"
    choose_credit_score 'good'
    sleep 0.5
    @wait.until { find_el(:css, '.header__wizard-link.header__wizard-link--active.header__wizard-link--card').displayed? }
    sleep 0.5
    @wait.until { find_el(:css, '.header__wizard-link.header__wizard-link--program').displayed? }
    sleep 0.5
    find_el(:css, '.header__wizard-link.header__wizard-link--program').click
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    find_el(:class, "strategies__list")
    # reset_strategy
    logout
  end

  it 'go back to Planning Strategies page with "Select Different Program" - NNC2' do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Aadvantage®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__switch-link').displayed? }
    sleep 0.5
    find_el(:css, '.select-card__switch-link').click
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    find_el(:class, "strategies__list")
    logout
  end

  it 'go back to Planning Strategies page with the help of "Back" in browser - NNC3' do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Aadvantage®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    @d.navigate.back
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    find_el(:class, "strategies__list")
    # reset_strategy
    logout
  end

  it 'check MILES NEED TO EARN FOR THIS TRIP (empty wallet) - NNC4' do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "MileagePlus®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    numbers = find_el(:class, 'select-card__balance').find_elements(:css, 'span.select-card__balance-cell')
    expect(numbers[0].text).to eq '6'
    expect(numbers[1].text).to eq '0'
    expect(numbers[2].text).to eq '0'
    expect(numbers[3].text).to eq '0'
    expect(numbers[4].text).to eq '0'
    # reset_strategy
    logout
  end

  it 'check MILES NEED TO EARN FOR THIS TRIP (wallet not empty) - NNC5, NNC7, NNC9, NNC10' do
    register
    wallet_add_new
    add_program_from_wallet 1
    close_learning_popup
    switch_to_manual
    enter_balance 5555
    sleep 2
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    wallet_add_more
    sleep 1.5
    el = find_els(:class, "accounts__block-name")[18]
    el.location_once_scrolled_into_view
    el.click
    # switch_to_manual
    sleep 1
    find_el(:class, 'cards-and-programs__save-btn').click
    enter_balance 3000
    
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "MileagePlus®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    # for NNC5
    numbers = find_el(:class, 'select-card__balance').find_elements(:css, 'span.select-card__balance-cell')
    expect(numbers[0].text).to eq '5'
    expect(numbers[1].text).to eq '4'
    expect(numbers[2].text).to eq '2'
    expect(numbers[3].text).to eq '2'
    expect(numbers[4].text).to eq '3'
    # for NNC7
    expect(find_els(:class, 'select-card__header-data-value').first.text).to eq '60,000'
    # for NNC9
    expect(find_els(:class, 'select-card__header-data-value').last.text).to eq '5,777'
    # for NNC11
    find_el(:class, 'select-card__calculations-link').click
    sleep 1
    rows = find_el(:class, 'balance-details-tooltip__body').find_elements(:class, 'balance-details-tooltip__row')
    expect(rows.first.find_element(:css, '.balance-details-tooltip__column.balance-details-tooltip__column--value').text).to eq '3,000'
    expect(rows.last.find_element(:css, 'span.balance-details-tooltip__aux-value').text).to eq '+2,777'
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    # sleep 1
    # remove_program_from_wallet
    logout
  end

  it 'check ESTIMATED AWARD TICKET COST (empty wallet) - NNC6, NNC8, NNC11, NNC12, NN14' do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "MileagePlus®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    # for NN6
    expect(find_el(:class, 'select-card__header-data-value').text).to eq '60,000'
    # for NN8
    expect(find_el(:class, 'select-card__msg').text).to eq 'Your wallet is empty'
    # for NN11
    expect(find_el(:class, 'select-card__header-program-img')[:alt]).to eq 'MileagePlus®'
    # for NN12
    expect(find_el(:css, 'p.credit-card__msg').text).to eq 'You don\'t have any credit cards that earn miles in this program. We have selected one just for you.'
    expect(find_el(:class, 'credit-card__lightbox-link').text).to eq 'Why do I need a travel credit card?'
    expect(find_el(:css, 'a.credit-card__action-link').text).to eq 'GO TO YOUR WALLET TO ADD CARDS'
    # for NN14
    find_el(:css, 'a.credit-card__action-link').click
    @wait.until { find_el(:css, 'h2.wallet__sub-heading').displayed? }
    expect(find_el(:css, 'h2.wallet__sub-heading').text).to eq 'We\'ll show you the best way to use them.'
    # reset_strategy
    logout
  end

  it 'check Earn with your credit cards box (wallet not empty) - NNC13, NNC15' do
    register
    wallet_add_new
    add_program_from_wallet 1
    close_learning_popup
    switch_to_manual
    enter_balance 5555
    sleep 2
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    wallet_add_more
    sleep 1.5
    el = find_els(:class, "accounts__block-name")[18]
    el.location_once_scrolled_into_view
    el.click
    # switch_to_manual
    sleep 1
    find_el(:class, 'cards-and-programs__save-btn').click
    enter_balance 3000
    
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "MileagePlus®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    # for NNC13
    cards_from_wallet = find_el(:class, 'select-card__list').find_elements(:class, 'credit-card__main')
    expect(cards_from_wallet.first.find_element(:css, 'h3.credit-card__name').text).to eq 'Starwood Preferred Guest® Credit Card from American Express'
    expect(cards_from_wallet.last.find_element(:css, 'h3.credit-card__name').text).to eq 'United MileagePlus® Club Card'
    # for NNC15
    cards_from_wallet.first.find_element(:css, '.credit-card__apply-action.credit-card__btn.credit-card__btn--blue').click
    @wait.until { find_el(:css, 'h1.step-card__main-heading').displayed? }
    expect(find_el(:css, 'h1.step-card__main-heading').text).to eq 'Reach your goal with this travel rewards card.'
    # sleep 0.5
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    # sleep 1
    # remove_program_from_wallet
    logout
  end

  it 'check Earn faster with sign-up bonus box (empty wallet) - NNC16, NNC18' do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Aadvantage®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    # for NNC16
    cards_with_bonus = find_el(:id, 'select-card__first-suggested-cards-region').find_elements(:class, 'credit-card__main')
    expect(cards_with_bonus.first.find_element(:css, 'h3.credit-card__name').text).to eq 'Starwood Preferred Guest® Credit Card from American Express'
    expect(cards_with_bonus.first.find_element(:css, 'span.credit-card__data').text).to eq '25,000'
    expect(cards_with_bonus.last.find_element(:css, 'h3.credit-card__name').text).to eq 'Starwood Preferred Guest® Business Credit Card'
    expect(cards_with_bonus.last.find_element(:css, 'span.credit-card__data').text).to eq '25,000'
    # for NNC18
    cards_with_bonus.first.find_element(:css, '.credit-card__skip-action.credit-card__btn.credit-card__btn--green').click
    @wait.until { find_el(:css, 'span.cabinet__program-label').displayed? }
    expect(find_el(:css, 'span.cabinet__program-label').text).to eq 'REMINDER: SIGN UP TO REWARD PROGRAM'
    # sleep 0.5
    # reset_strategy
    logout
  end

  it 'check Earn faster with sign-up bonus box (wallet not empty) - NNC17, NNC19' do
    register
    wallet_add_new
    add_program_from_wallet 1
    close_learning_popup
    switch_to_manual
    enter_balance 5555
    sleep 2
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    wallet_add_more
    sleep 1.5
    el = find_els(:class, "accounts__block-name")[18]
    el.location_once_scrolled_into_view
    el.click
    # switch_to_manual
    @wait.until { find_el(:class, 'cards-and-programs__save-btn').displayed? }
    find_el(:class, 'cards-and-programs__save-btn').click
    enter_balance 3000
    
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "MileagePlus®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    # for NNC17
    cards_with_bonus = find_el(:id, 'select-card__first-suggested-cards-region').find_elements(:class, 'credit-card__main')
    expect(cards_with_bonus.first.find_element(:css, 'h3.credit-card__name').text).to eq 'Chase Sapphire Preferred® Card'
    expect(cards_with_bonus.first.find_element(:css, 'span.credit-card__data').text).to eq '50,000'
    # expect(cards_with_bonus.last.find_element(:css, 'h3.credit-card__name').text).to eq 'Ink Plus® Business Credit Card'
    # expect(cards_with_bonus.last.find_element(:css, 'span.credit-card__data').text).to eq '60,000'
    expect(find_els(:css, 'a.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').count).to eq 1
    # for NNC19
    cards_with_bonus.first.find_element(:css, '.credit-card__skip-action.credit-card__btn.credit-card__btn--green').click
    @wait.until { find_el(:css, 'span.cabinet__program-label').displayed? }
    expect(find_el(:css, 'span.cabinet__program-label').text).to eq 'BOOK TICKET WITH'
    expect(find_el(:css, 'span.cabinet__program-name').text).to eq 'MileagePlus®'
    expect(find_el(:css, 'span.cabinet__program-mileage-count').text).to eq '3,000'
    expect(find_el(:css, 'span.cabinet__other-program-name').text).to eq 'Other programs'
    expect(find_el(:css, 'span.cabinet__program-mileage-count.cabinet__program-mileage-count--other-programs').text).to eq '2,777'
    expect(find_el(:css, 'span.ready-step-notification__text').text).to include 'Chase Sapphire Preferred® Card is still available'
    # sleep 0.5
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    # sleep 1.5
    # remove_program_from_wallet
    logout
  end

  it 'check APPLY NOW button (empty wallet) - NNC20' do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Aadvantage®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    # for NNC20
    find_el(:link, "See all cards with bonuses").click
    wait.until { find_el(:id, "select-card__suggested-cards").displayed? }
    @cards_list = find_el(:id, "select-card__suggested-cards")

    @cards_list.find_elements(:css, ".select-card__list-item.credit-card").each do |card|
      logo = card.find_element(:class, 'credit-card__img')
      if logo[:alt].downcase.include? ('Citi® / AAdvantage® Platinum Select® MasterCard®').downcase
        card.find_element(:link, ('Apply now').upcase).click
        break
      end
    end
    sleep 1
    close_window
    @wait.until { find_el(:css, 'h2.step-card__body-heading').displayed? }
    expect(find_el(:css, 'h2.step-card__body-heading').text).to eq 'My Citi® / AAdvantage® Platinum Select® MasterCard® application was:'
    sleep 0.5
    # reset_strategy
    logout
  end

  it 'check APPLY NOW button (empty not wallet) - NNC21' do
    register
    wallet_add_new
    add_program_from_wallet 1
    close_learning_popup
    switch_to_manual
    enter_balance 5555
    sleep 2
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    wallet_add_more
    sleep 1.5
    el = find_els(:class, "accounts__block-name")[18]
    el.location_once_scrolled_into_view
    el.click
    # switch_to_manual
    sleep 1
    find_el(:class, 'cards-and-programs__save-btn').click
    enter_balance 3000
    
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "MileagePlus®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    find_el(:link, "See all cards with bonuses").click
    wait.until { find_el(:id, "select-card__suggested-cards").displayed? }
    @cards_list = find_el(:id, "select-card__suggested-cards")

    @cards_list.find_elements(:css, ".select-card__list-item.credit-card").each do |card|
      logo = card.find_element(:class, 'credit-card__img')
      if logo[:alt].include? 'Chase Sapphire Preferred® Card'
        card.find_element(:link, ('Apply now').upcase).click
        break
      end
    end
    sleep 1
    close_window
    @wait.until { find_el(:css, 'h2.step-card__body-heading').displayed? }
    expect(find_el(:css, 'h2.step-card__body-heading').text).to eq 'My Chase Sapphire Preferred® Card application was:'
    # sleep 1
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    # sleep 2.5
    # remove_program_from_wallet
    logout
  end

  it 'check MORE INFO panel (wallet empty) - NNC22' do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Aadvantage®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    cards_with_bonus = find_el(:id, 'select-card__first-suggested-cards-region').find_elements(:class, 'credit-card__main')
    cards_with_bonus.first.find_element(:css, '.credit-card__show-info-link').click
    @wait.until { find_el(:css, '.credit-card__overview-title--bonus_miles').displayed? }
    expect(find_el(:css, '.credit-card__overview-title--bonus_miles').text).to eq 'BONUS MILES'
    find_el(:css, '.credit-card__nav-link--annual_fee').click
    @wait.until { find_el(:css, '.credit-card__overview-title--annual_fee').displayed? }
    expect(find_el(:css, '.credit-card__overview-title--annual_fee').text).to eq 'ANNUAL FEE'
    find_el(:css, '.credit-card__nav-link--more_perks').click
    @wait.until { find_el(:css, '.credit-card__overview-title--more_perks').displayed? }
    expect(find_el(:css, '.credit-card__overview-title--more_perks').text).to eq 'MORE PERKS'
    find_el(:css, '.credit-card__nav-link--points_transfer').click
    @wait.until { find_el(:css, '.credit-card__overview-title--points_transfer').displayed? }
    expect(find_el(:css, '.credit-card__overview-title--points_transfer').text).to eq 'POINTS TRANSFER'
    expect(find_el(:css, '.credit-card__terms-link').text).to eq 'See Terms and Conditions'
    expect(find_el(:css, 'span.credit-card__score-info').text).to include('Recommended credit score')
    # sleep 0.5
    # reset_strategy
    logout
  end

  it 'check MORE INFO panel (wallet not empty) - NNC23' do
    register
    wallet_add_new
    add_program_from_wallet 1
    close_learning_popup
    switch_to_manual
    enter_balance 5555
    sleep 2
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    wallet_add_more
    sleep 1.5
    el = find_els(:class, "accounts__block-name")[18]
    el.location_once_scrolled_into_view
    el.click
    # switch_to_manual
    sleep 1
    find_el(:class, 'cards-and-programs__save-btn').click
    enter_balance 3000
    
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "MileagePlus®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    cards_from_wallet = find_el(:id, 'select-card__first-user-cards-region').find_elements(:class, 'credit-card__main')
    cards_from_wallet.first.find_element(:css, '.credit-card__show-info-link').click
    # find_el(:css, '.credit-card__nav-link--annual_fee').click
    @wait.until { find_el(:css, '.credit-card__overview-title--annual_fee').displayed? }
    expect(find_el(:css, '.credit-card__overview-title--annual_fee').text).to eq 'ANNUAL FEE'
    find_el(:css, '.credit-card__nav-link--more_perks').click
    @wait.until { find_el(:css, '.credit-card__overview-title--more_perks').displayed? }
    expect(find_el(:css, '.credit-card__overview-title--more_perks').text).to eq 'MORE PERKS'
    find_el(:css, '.credit-card__nav-link--points_transfer').click
    @wait.until { find_el(:css, '.credit-card__overview-title--points_transfer').displayed? }
    expect(find_el(:css, '.credit-card__overview-title--points_transfer').text).to eq 'POINTS TRANSFER'
    expect(find_el(:css, '.credit-card__terms-link').text).to eq 'See Terms and Conditions'
    expect(find_el(:css, 'span.credit-card__score-info').text).to include('Recommended credit score')
    # sleep 0.5
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    # sleep 1
    # remove_program_from_wallet
    logout
  end

  it 'check all boxes (wallet not empty, adults 2) - NNC24' do
    register
    wallet_add_new
    add_program_from_wallet 1
    close_learning_popup
    switch_to_manual
    enter_balance 5555
    sleep 2
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    wallet_add_more
    sleep 1.5
    el = find_els(:class, "accounts__block-name")[18]
    el.location_once_scrolled_into_view
    el.click
    # switch_to_manual
    sleep 1
    find_el(:class, 'cards-and-programs__save-btn').click
    enter_balance 3000
    
    @wait.until { find_el(:css, 'h2.wallet__panel-heading.wallet__panel-heading--not-empty').displayed? }
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    find_els(:class, 'selectize-input')[2].click
    sleep 0.5
    find_el(:xpath,"//div[@data-value='2']").click
    find_el(:id, 'strategies-filter__submit-button').click
    sleep 0.5
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    choose_strategy_by_name "MileagePlus®"
    choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    numbers = find_el(:class, 'select-card__balance').find_elements(:css, 'span.select-card__balance-cell')
    expect(numbers[0].text).to eq '1'
    expect(numbers[1].text).to eq '1'
    expect(numbers[2].text).to eq '4'
    expect(numbers[3].text).to eq '2'
    expect(numbers[4].text).to eq '2'
    expect(numbers[5].text).to eq '3'
    expect(find_els(:class, 'select-card__header-data-value').first.text).to eq '120,000'
    expect(find_els(:class, 'select-card__header-data-value').last.text).to eq '5,777'
    # sleep 0.5
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    # sleep 1
    # remove_program_from_wallet
    logout
  end

end
