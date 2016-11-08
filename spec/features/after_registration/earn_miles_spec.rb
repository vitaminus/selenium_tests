require 'spec_helper'
require "selenium-webdriver"

describe "Earn miles" do

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

  it 'neither route no strategy chosen - EM1' do
    register
    go_to_current_goal
    @wait.until { find_el(:class, 'step-form__heading').displayed? }
    go_to_earn_miles
    all_promos
    find_el(:css, '.earn-miles__nav-button.earn-miles__nav-button--personal-deals').click
    @wait.until { find_el(:class, 'deals__empty-title').displayed? }
    expect(find_el(:class, 'deals__empty-title').text).to include('No active promos found.')
    logout
  end

  it 'both route and strategy chosen - EM2' do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Aadvantage®"
    choose_credit_score 'good'
    sleep 0.5
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    choose_card_by_name 'Citi® / AAdvantage® Platinum Select® MasterCard®'
    approve_card
    setup_program '1-877-905-1861'
    activate_program true
    update_manualy
    get_signup_bonus
    remember_to_spend
    sleep 5
    pie_have_program "AAdvantage®"
    go_to_earn_miles
    promos_for 'aadvantage'
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    logout
  end

  it 'users save promos - EM3' do
    register
    go_to_current_goal
    # @wait.until { find_el(:class, 'step-form__heading').displayed? }
    go_to_earn_miles
    all_promos
    find_el(:css, '.earn-miles__nav-button.earn-miles__nav-button--favorite-deals').click
    @wait.until { find_el(:class, 'deals__empty-title').displayed? }
    expect(find_el(:class, 'deals__empty-title').text).to include('Click the star in the upper right hand corner of a promo to bookmark it.')
    find_el(:css, '.earn-miles__nav-button.earn-miles__nav-button--all-deals').click
    sleep 1
    save_promos
    check_saved_promos
    unsave_promos
    unsave_promos
    sleep 0.5
    expect(find_el(:class, 'deals__empty-title').text).to include('Click the star in the upper right hand corner of a promo to bookmark it.')
    logout
  end

end
