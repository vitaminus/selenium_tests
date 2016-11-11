describe "Iberia", integration: true do

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

  it "valid autoupdate", :broken do
  	# sign_in
   #  fill_in_waypoint('JFK', 'LHR')
   #  monthly_spending
   #  choose_strategy_by_name "Iberia Plus"
   #  # goal_confirmation 'Iberia Plus'
   #  choose_card_by_name("Business Green Rewards Card")
   #  # apply_card
   #  approve_card
   #  sleep 3
   #  update_automatically
   #  autoupdate_program "Membership Rewards®"
   #  wallet_cancel_button
   #  get_signup_bonus
   #  activate_program false
   #  sleep 3
   #  update_automatically
   #  autoupdate_program 'Iberia Plus'
   #  autoupdate_credentials iberia_user
   #  autoupdate_answer
   #  wallet_save_button
   #  remember_to_spend
   #  pie_have_program "Membership Rewards®"
   #  pie_have_program "Iberia Plus"
   #  set_new_goal
   #  # sleep 6
   #  go_to_wallet
   #  remove_program_from_wallet
   #  sleep 1
   #  remove_program_from_wallet
   #  logout
  end

  it 'wrong credentials', :broken do
    # # code_word
    # sign_in
    # sleep 4
    # go_to_wallet
    # wallet_add_new
    # add_program_from_wallet 61
    # close_learning_popup
    # autoupdate_wrong_credentials iberia_user
    # autoupdate_error 'Iberia Plus'
    # close_flash_message
    # autoupdate_credentials iberia_user
    # autoupdate_answer
    # close_flash_message
    # sleep 2
    # # # wait_hiding_flash_message
    # # # if @driver.find_element(:css, '.overlay-preloading.overlay-preloading--wallet')
    # # #   p "bank-programs__editor-preloading"
    # # # end
    # # element = @driver.find_element(:class, "add-program__dismiss-btn")
    # # @driver.action.move_to(element, 10, 10).click.perform
    # wallet_cancel_button
    # sleep 2
    # remove_program_from_wallet
    # logout
  end

end
