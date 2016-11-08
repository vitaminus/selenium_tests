require 'spec_helper'
require 'selenium-webdriver'

describe "Pie" do

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

  it "co-branded Strategy (apply now, approved) - PIE1", :broken do
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
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '0'
    expect(find_el(:css, 'span.cabinet__mileage').text).to eq '0'
    expect(find_el(:css, 'span.cabinet__program-mileage-count').text).to eq '0'
    expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
    go_to_wallet
    edit_balance 30000
    go_to_current_goal
    pie_have_program "AAdvantage®"
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '66'
    expect(find_el(:css, 'span.cabinet__mileage').text).to eq '30,000'
    expect(find_el(:css, 'span.cabinet__program-mileage-count').text).to eq '30,000'
    expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
    go_to_wallet
    edit_balance 60000
    go_to_current_goal
    congratulation
    pie_have_program "AAdvantage®"
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '100'
    expect(find_el(:css, 'span.cabinet__mileage').text).to eq '60,000'
    expect(find_el(:css, 'span.cabinet__program-mileage-count').text).to eq '60,000'
    expect(find_el(:css, 'h2.ready-step-notification__heading').text).to include 'Congratulations'
    # set_new_goal
    # go_to_wallet
    # remove_program_from_wallet
    logout
  end

  # it 'point based Strategy (apply now, approved) - PIE2' do
  #   sign_in
  #   fill_in_waypoint('JFK', 'LHR')
  #   monthly_spending
  #   choose_strategy_by_name "Ultimate Rewards®"
  #   choose_card_by_name "Chase Sapphire Preferred® Card"
  #   approve_card
  #   update_manualy
  #   get_signup_bonus
  #   remember_to_spend
  #   pie_have_program "Ultimate Rewards®"
  #   expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '0'
  #   expect(find_el(:css, 'span.cabinet__mileage').text).to eq '0'
  #   expect(find_el(:css, 'span.cabinet__program-mileage-count').text).to eq '0'
  #   expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
  #   go_to_wallet
  #   edit_balance 30000
  #   go_to_current_goal
  #   pie_have_program "Ultimate Rewards®"
  #   expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '39'
  #   expect(find_el(:css, 'span.cabinet__mileage').text).to eq '30,000'
  #   expect(find_el(:css, 'span.cabinet__program-mileage-count').text).to eq '30,000'
  #   expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
  #   go_to_wallet
  #   edit_balance 300000
  #   go_to_current_goal
  #   congratulation
  #   pie_have_program "Ultimate Rewards®"
  #   expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '100'
  #   expect(find_el(:css, 'span.cabinet__mileage').text).to eq '300,000'
  #   expect(find_el(:css, 'span.cabinet__program-mileage-count').text).to eq '300,000'
  #   expect(find_el(:css, 'h2.ready-step-notification__heading').text).to include 'Congratulations'
  #   set_new_goal
  #   go_to_wallet
  #   remove_program_from_wallet
  #   logout
  # end

  it "transferable+Starwood Strategy (apply now, approved) - PIE3", :broken do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "AAdvantage®"
    choose_credit_score 'good'
    choose_card_by_name "Starwood Preferred Guest® Credit Card from American Express"
    approve_card
    setup_program '1-866-207-7970'
    activate_program false
    update_manualy
    get_signup_bonus
    activate_program false
    update_manualy
    remember_to_spend
    sleep 4
    pie_have_program "Starwood Preferred Guest®"
    pie_have_program "AAdvantage®"
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '0'
    programs = find_el(:class, 'cabinet__programs-container').find_elements(:class, 'cabinet__program-mileage')
    expect(programs.first.text).to eq '0 Starpoints®'
    expect(programs.second.text).to eq '0 miles'
    expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
    go_to_wallet
    edit_program_by_name 'Starwood Preferred Guest®'
    enter_balance 10000
    sleep 1.5
    edit_program_by_name 'AAdvantage®'
    enter_balance 5000
    sleep 1
    go_to_current_goal
    sleep 8
    @wait.until { find_el(:class, 'cabinet__programs-container').displayed? }
    programs = find_el(:class, 'cabinet__programs-container').find_elements(:class, 'cabinet__program-mileage')
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '33'
    expect(programs.first.text).to eq '10,000 Starpoints®'
    expect(programs.second.text).to eq '5,000 miles'
    expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
    go_to_wallet
    edit_program_by_name 'Starwood Preferred Guest®'
    enter_balance 25000
    sleep 1
    go_to_current_goal
    @wait.until { find_el(:class, 'cabinet__programs-container').displayed? }
    programs = find_el(:class, 'cabinet__programs-container').find_elements(:class, 'cabinet__program-mileage')
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '77'
    expect(programs.first.text).to eq '25,000 Starpoints®'
    expect(programs.second.text).to eq '5,000 miles'
    expect(find_el(:css, 'span.cabinet__other-program-name').text).to eq 'Other bonuses'
    expect(find_el(:css, 'span.cabinet__program-mileage-count.cabinet__program-mileage-count--other-bonuses').text).to eq '5,000'
    expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
    go_to_wallet
    edit_program_by_name 'AAdvantage®'
    enter_balance 30000
    sleep 1
    go_to_current_goal
    congratulation
    @wait.until { find_el(:class, 'cabinet__programs-container').displayed? }
    programs = find_el(:class, 'cabinet__programs-container').find_elements(:class, 'cabinet__program-mileage')
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '100'
    expect(programs.first.text).to eq '25,000 Starpoints®'
    expect(programs.second.text).to eq '30,000 miles'
    expect(find_el(:css, 'span.cabinet__other-program-name').text).to eq 'Other bonuses'
    expect(find_el(:css, 'span.cabinet__program-mileage-count.cabinet__program-mileage-count--other-bonuses').text).to eq '5,000'
    expect(find_el(:css, 'h2.ready-step-notification__heading').text).to include 'Congratulations'
    # set_new_goal
    # go_to_wallet
    # remove_program_from_wallet
    # remove_program_from_wallet
    logout
  end

  it "co-branded Strategy (apply now, pending) - PIE4", :broken do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "AAdvantage®"
    choose_credit_score 'good'
    choose_card_by_name "Citi® / AAdvantage® Platinum Select® MasterCard®"
    pending_card
    pie_have_reminder "AAdvantage®"
    expect(find_el(:css, 'span.ready-step-notification__text').text).to include 'When you find out the status'
    click_footer_reminder
    @wait.until { find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-approved').displayed? }
    sleep 1
    find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-approved').click
    sleep 0.5
    continue
    setup_program '1-877-905-1861'
    activate_program true
    update_manualy
    get_signup_bonus
    remember_to_spend
    sleep 0.5
    pie_have_program "AAdvantage®"
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '0'
    expect(find_el(:css, 'span.cabinet__mileage').text).to eq '0'
    expect(find_el(:css, 'span.cabinet__program-mileage-count').text).to eq '0'
    expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
    # set_new_goal
    # go_to_wallet
    # remove_program_from_wallet
    logout
  end

  it "point based Strategy (apply now, pending) - PIE5", :broken do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Ultimate Rewards®"
    choose_credit_score 'good'
    choose_card_by_name "Chase Sapphire Preferred® Card"
    pending_card
    pie_have_reminder "Ultimate Rewards®"
    expect(find_el(:css, 'span.ready-step-notification__text').text).to include 'When you find out the status'
    click_footer_reminder
    @wait.until { find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-approved').displayed? }
    sleep 0.5
    find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-approved').click
    sleep 0.5
    continue
    update_manualy
    get_signup_bonus
    remember_to_spend
    sleep 0.5
    pie_have_program "Ultimate Rewards®"
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '0'
    expect(find_el(:css, 'span.cabinet__mileage').text).to eq '0'
    expect(find_el(:css, 'span.cabinet__program-mileage-count').text).to eq '0'
    expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
    # set_new_goal
    # go_to_wallet
    # remove_program_from_wallet
    logout
  end

  it "transferable+Starwood Strategy (apply now, pending) - PIE6", :broken do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "AAdvantage®"
    choose_credit_score 'good'
    choose_card_by_name "Starwood Preferred Guest® Credit Card from American Express"
    pending_card
    pie_have_reminder "AAdvantage®"
    expect(find_el(:css, 'span.ready-step-notification__text').text).to include 'When you find out the status'
    click_footer_reminder
    @wait.until { find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-approved').displayed? }
    sleep 0.5
    find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-approved').click
    sleep 0.5
    continue
    setup_program '1-866-207-7970'
    activate_program false
    update_manualy
    get_signup_bonus
    activate_program false
    update_manualy
    remember_to_spend
    sleep 0.5
    pie_have_program "Starwood Preferred Guest®"
    pie_have_program "AAdvantage®"
    expect(find_el(:css, 'span.pie__status-percent--value').text).to eq '0'
    programs = find_el(:class, 'cabinet__programs-container').find_elements(:class, 'cabinet__program-mileage')
    expect(programs.first.text).to eq '0 Starpoints®'
    expect(programs.second.text).to eq '0 miles'
    expect(find_el(:css, 'span.ready-steps__note').text).to include '$2,500'
    # set_new_goal
    # go_to_wallet
    # remove_program_from_wallet
    # remove_program_from_wallet
    logout
  end

  it '2 adult - PIE7' do
    register
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
    choose_card_by_name "Chase Sapphire Preferred® Card"
    approve_card
    update_manualy
    get_signup_bonus
    activate_program false
    update_manualy
    remember_to_spend
    pie_have_program "Ultimate Rewards®"
    pie_have_program "MileagePlus®"
    expect(find_el(:class, 'cabinet__stats').find_elements(:css, 'span.cabinet__mileage').second.text).to include '120,000'
    expect(find_el(:class, 'header__info-block').find_elements(:css, 'span.header__info-data').last.text).to include '2'
    # set_new_goal
    # go_to_wallet
    # remove_program_from_wallet
    # remove_program_from_wallet
    logout
  end

end
