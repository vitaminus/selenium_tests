describe "KrisFlyer" do

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
   #  fill_in_waypoint('JFK', 'SIN')
   #  monthly_spending
   #  choose_strategy_by_name "KrisFlyer"
   #  # goal_confirmation 'KrisFlyer'
   #  choose_card_by_name("Miles & More® World Elite MasterCard®")
   #  # apply_card
   #  approve_card
   #  setup_program '1-877-408-8866'
   #  activate_program true
   #  sleep 2
   #  update_automatically
   #  autoupdate_program "Miles & More"
   #  autoupdate_credentials lufthansa_user
   #  autoupdate_answer
   #  wallet_save_button
   #  get_signup_bonus
   #  remember_to_spend
   #  pie_have_program "Miles & More"
   #  set_new_goal
   #  go_to_wallet
   #  remove_program_from_wallet
   #  logout
  end

  it 'wrong credentials', :broken do
    # sign_in
    # sleep 4
    # go_to_wallet
    # wallet_add_new
    # add_program_from_wallet 71
    # close_learning_popup
    # autoupdate_wrong_credentials krisflyer_user
    # autoupdate_error 'KrisFlyer'
    # close_flash_message
    # autoupdate_credentials krisflyer_user
    # autoupdate_answer
    # close_flash_message
    # sleep 2
    # wallet_cancel_button
    # sleep 2
    # remove_program_from_wallet
    # logout
  end

  # it 'wrong credentials' do
  #   # code_word
  #   sign_in
  #   sleep 4
  #   go_to_wallet
  #   wallet_add_new
  #   add_program_from_wallet 60
  #   close_learning_popup
  #   autoupdate_wrong_credentials lufthansa_user
  #   autoupdate_error 'Iberia Plus'
  #   close_flash_message
  #   autoupdate_credentials lufthansa_user
  #   autoupdate_answer
  #   close_flash_message
  #   sleep 2
  #   # # wait_hiding_flash_message
  #   # # if @driver.find_element(:css, '.overlay-preloading.overlay-preloading--wallet')
  #   # #   p "bank-programs__editor-preloading"
  #   # # end
  #   # element = @driver.find_element(:class, "add-program__dismiss-btn")
  #   # @driver.action.move_to(element, 10, 10).click.perform
  #   wallet_cancel_button
  #   sleep 2
  #   remove_program_from_wallet
  #   logout
  # end
end
