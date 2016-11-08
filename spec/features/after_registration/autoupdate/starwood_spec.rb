require 'spec_helper'
require 'selenium-webdriver'

describe "Starwood autoupdate" do

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

  it "have status 'Enter login info'", :broken do
  	# sign_in
   #  fill_in_waypoint('JFK', 'LHR')
   #  monthly_spending
   #  choose_strategy_by_name "Mileage Bank"
   #  # goal_confirmation
   #  choose_card_by_name "Starwood Preferred Guest® Business Credit Card"
   #  # apply_card
   #  approve_card
   #  setup_program '1-866-207-7970'
   #  activate_program true
   #  update_automatically
   #  autoupdate_program "Starwood Preferred Guest®"
   #  wallet_cancel_button
   #  get_signup_bonus
   #  activate_program false
   #  sleep 3
   #  update_automatically
   #  autoupdate_program "Mileage Bank"
   #  wallet_cancel_button
   #  remember_to_spend
   #  pie_have_program "Starwood Preferred Guest®"
   #  pie_have_program "Mileage Bank"
   #  go_to_wallet
   #  autoupdate_status('ENTER LOGIN INFO', 2)
   #  edit_program_on_wallet
   #  autoupdate_credentials starwood_user
   #  starwood_question
   #  autoupdate_answer
   #  wallet_save_account_btn
   #  go_to_current_goal    
   #  set_new_goal
   #  go_to_wallet
   #  remove_program_from_wallet
   #  remove_program_from_wallet
   #  logout
  end

  # it "have status 'Locked'" do
  #   sign_in
  #   fill_in_waypoint('JFK', 'LHR')
  #   monthly_spending
  #   choose_strategy_by_name "Mileage Bank"
  #   # goal_confirmation
  #   choose_card_by_name "Starwood Preferred Guest® Business Credit Card"
  #   # apply_card
  #   approve_card
  #   setup_program '1-866-207-7970'
  #   activate_program true
  #   update_automatically
  #   autoupdate_program "Starwood Preferred Guest®"
  #   wallet_cancel_button
  #   get_signup_bonus
  #   activate_program false
  #   sleep 3
  #   update_automatically
  #   autoupdate_program "Mileage Bank"
  #   wallet_cancel_button
  #   remember_to_spend
  #   pie_have_program "Starwood Preferred Guest®"
  #   pie_have_program "Mileage Bank"
  #   go_to_wallet
  #   autoupdate_status('ENTER LOGIN INFO', 2)
  #   edit_program_on_wallet
  #   autoupdate_credentials starwood_user
  #   starwood_question
  #   autoupdate_answer
  #   wallet_save_account_btn
  #   go_to_current_goal    
  #   set_new_goal
  #   sleep 6
  #   go_to_wallet
  #   remove_program_from_wallet
  #   remove_program_from_wallet
  #   logout
  # end

end
