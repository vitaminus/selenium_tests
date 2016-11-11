describe "Aeroplan" do

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
   #  choose_strategy_by_name "Aeroplan®"
   #  # goal_confirmation 'Aeroplan®'
   #  choose_card_by_name "TD AeroplanTM Visa Signature® Credit Card"
   #  # apply_card
   #  approve_card
   #  setup_program '1-888-561-8861'
   #  activate_program true
   #  update_automatically
   #  autoupdate_program "Aeroplan®"
   #  autoupdate_credentials aeroplan_user
   #  autoupdate_answer
   #  wallet_save_button
   #  get_signup_bonus
   #  remember_to_spend
   #  pie_have_program "Aeroplan®"
   #  go_to_wallet
   #  # sleep 3
   #  autoupdate_status('AUTO UPDATE', 1)
   #  go_to_current_goal
   #  set_new_goal
   #  # sleep 3
   #  go_to_wallet
   #  remove_program_from_wallet
   #  logout
  end

end
