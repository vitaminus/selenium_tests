require 'spec_helper'
require 'selenium-webdriver'

describe "Point based" do

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

  it "empty wallet - good credit score - EW3" do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Ultimate Rewards®"
    choose_credit_score 'good'
    choose_card_by_name "Chase Sapphire Preferred® Card"
    approve_card
    update_manualy
    get_signup_bonus
    sleep 0.5
    remember_to_spend
    pie_have_program "Ultimate Rewards®"
    # set_new_goal
    # go_to_wallet
    # remove_program_from_wallet
    logout
  end

  it "empty wallet - good credit score - skip card - SC3" do
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
    choose_strategy_by_name "Membership Rewards®"
    choose_credit_score 'good'
    choose_card_by_name "Premier Rewards Gold Card from American Express", false
    pie_have_reminder "Membership Rewards®"
    click_footer_reminder
    @wait.until { find_el(:css, 'h1.step-card__main-heading').displayed? }
    sleep 0.5
    expect(find_el(:css, 'h1.step-card__main-heading').text).to include "There's still time to get"
    go_to_wallet
    @wait.until { find_el(:css, 'h2.wallet__sub-heading').displayed? }
    expect(find_el(:css, 'h2.wallet__sub-heading').text).to include "We'll show you the best way to use them."
    # reset_strategy
    logout
  end

  # it "empty wallet - good credit score - pending - AP3" do
  #   sign_in
  #   fill_in_waypoint('JFK', 'LHR')
  #   monthly_spending
  #   choose_strategy_by_name "Membership Rewards®"
  #   choose_card_by_name "Premier Rewards Gold Card from American Express"
  #   pending_card
  #   pie_have_reminder "Membership Rewards®"
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
