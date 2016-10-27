module FeatureSeleniumHelpers
  def driver
  	Selenium::WebDriver.for(:chrome)
  end

  def window_size
  	target_size = Selenium::WebDriver::Dimension.new(1024, 2048)
    @d.manage.window.size = target_size
  end

  def wait
  	Selenium::WebDriver::Wait.new(:timeout => 15)
  end

  def long_wait
  	Selenium::WebDriver::Wait.new(:timeout => 180)
  end

  def navigate_to
    url =
      case ENV["URL"]
      when 'stage'
        "https://stage.rewardexpert.com"
      when 'preprod'
        "https://preprod.rewardexpert.com"
      when 'prod'
        "https://www.rewardexpert.com"
      end
  	@d.navigate.to (url)
  end

  def quit
  	@d.quit
  end

  def new_user
    "selenium_#{[*('a'..'z'),*('0'..'9')].shuffle[0,15].join}@selenium.com"
  end

	def test_user
    {email: 'vitamin@vitamin.com', passwd: '123456789', name: 'vitaminus'}
  end

  ####### Autoupdate users ########

  def starwood_user
  	{login: '44950701797', passwd: '@believeU2'}
  end

  def aeroplan_user
  	{login: '970 001 715', passwd: '123A456b789C'}
  end

  def executive_club_user
    { login: 'vitaliy.t@rewardexpert.com', passwd: '123456789a' }
  end

	def alaska_mileage_plan_user
		{ login: '170771650', passwd: '123A456b789C' }
	end

	def jal_user
		{ login: '405236319', passwd: '121618' }
	end

	def iberia_user
		{ login: '73546251', passwd: '484654' }
	end

	def lufthansa_user
		{ login: 'vitaminus', passwd: '123A456b789C' }
	end

	def krisflyer_user
		{ login: '8820674659', passwd: '121618' }
	end

  ################### Helpers ###########################

  def click_upcase_link text
    find_el(:link, (text).upcase).click
  end

  def expect_rating rate, num
    expect(@strategies_list.find_elements(:class, "strategy")[num].find_element(:css, ".strategy__rating-mark.strategy__rating-mark--rating-#{rate}").text).to eq rate
  end

  def find_el by, cl
    @d.find_element(by, cl)
  end

  def find_els by, cl
    @d.find_elements(by, cl)
  end

	#######################################################

  def code_word
    lockup_codeword = find_els(:css, "input#lockup_codeword")
    if lockup_codeword.size > 0
      find_el(:css, "input#lockup_codeword").send_keys('r3ward')
      find_el(:xpath, "//button[contains(text(),'Go')]").click
    end
    logout if find_els(:css, 'a.button--register').size == 0
  end

  def sign_in
  	@wait.until { find_el(:link_text, "LOG IN").displayed? }
    find_el(:link_text, "LOG IN").click
    find_el(:id, "auth__email").send_keys(test_user[:email])
    find_el(:id, "auth__password").send_keys(test_user[:passwd])
    find_el(:xpath,"//input[@value='Log in']").click
  end

  def register
    # puts find_els(:css, 'a.button--register').empty?
    # logout if find_els(:css, 'a.button--register').size == 0
    @new_user = new_user
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys(@new_user)
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys(@new_user)
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, ".wallet__secondary-btn.wallet__choice-btn").displayed? }
    expect(find_el(:css, ".wallet__secondary-btn.wallet__choice-btn").text).to include(("Not now. Continue to goal").upcase)
    expect(find_el(:css, ".wallet__primary-btn.wallet__choice-btn").text).to include(("Add your miles and points").upcase)
  end

  def social_sign_in name
    @wait.until { find_el(:link, "LOG IN").displayed? }
    find_el(:link, "LOG IN").click
    find_el(:link, "LOG IN WITH #{name.upcase}").click
  end

  def go_to_profile_settings
    @wait.until { find_el(:class, "aside__panel-avatar").displayed? }
    find_el(:class, "aside__panel-avatar").click
    @wait.until { find_el(:class, "aside__dropdown-link--settings").displayed? }
    find_el(:class, "aside__dropdown-link--settings").click
  end

  def profile_change_name
    @wait.until { find_el(:class, "settings__name-cell").displayed? }
    find_el(:class, "settings__name-cell").click
    @wait.until { find_el(:class, "settings-field-group__input--name").displayed? }
    find_el(:class, "settings-field-group__input--name").click
    find_el(:class, "settings-field-group__input--name").send_keys('012345678901234567890123456789012345678901')
    find_el(:class, "settings-field-group__textarea--about").click
  end

  def exit_profile_settings
    find_el(:class, "settings-field-group__cancel-btn").click
    @wait.until { find_el(:class, "settings__close-btn").displayed? }
    find_el(:class, "settings__close-btn").click
  end

  def continue
    sleep 0.5
    find_el(:id, "step-card__next-step").click
  end

  def fill_in_waypoint(from, to)
  	@wait.until { find_el(:class, "location-field__input--from").displayed? }
    find_el(:class, "location-field__input--from").send_keys(from)

    @wait.until {find_el(:class, "location-field__short-city").displayed?}
    find_el(:class, "location-field__short-city").click
    find_el(:class, "location-field__input--to").send_keys(to)

    @wait.until { find_el(:class, "location-field__short-city").displayed?}
    find_el(:class, "location-field__short-city").click
    continue
  end

  def fill_in_waypoint_homepage(from, to)
    find_el(:class, "location-field__input--from").send_keys(from)

    @wait.until {find_el(:class, "location-field__short-city")}.click
    find_el(:class, "location-field__input--to").send_keys(to)

    @wait.until { find_el(:class, "location-field__short-city")}.click
  end

  def monthly_spending
  	@wait.until { find_el(:id, "range-slider__input").displayed? }
    expect(find_el(:class, "step-card__main-heading").text).to include("Your everyday credit card purchases = miles you'll earn.")
    continue
  end

  def choose_strategy_by_name name
  	@long_wait.until { find_el(:class, "strategies__list").displayed? }
  	@strategies_list = find_el(:class, "strategies__list")
       
    @strategies_list.find_elements(:class, "strategy").each do |s|
      logo = s.find_element(:class, 'strategy__program-logo')
      if logo[:alt].downcase.include? (name).downcase
        s.find_element(:css, '.strategy__select.strategy__select-btn').click
        break
      end
    end
  end

  def choose_credit_score score
    @wait.until { find_el(:css, "label.step-card__radio-label.step-card__radio-label--credit-score-#{score}").displayed? }
    expect(find_el(:css, "h1.step-card__main-heading").text).to include "Jumpstart your mileage balance"
    find_el(:css, "label.step-card__radio-label.step-card__radio-label--credit-score-#{score}").click
    continue
  end

  def frequent_flying
    sleep 1
    continue
  end

  def goal_confirmation program_name
  	@wait.until { expect(find_el(:class, "step-card__main-heading").text).to include(program_name + ' is the way to go') }
    continue
  end

  def choose_card_by_name(card_name, apply = true)
    wait.until { find_el(:css, ".select-card__title.select-card__title--earn").displayed? }
    expect(find_el(:css, ".select-card__title.select-card__title--earn").text).to include("Earn with one of your credit cards")
    expect(find_el(:css, ".select-card__title.select-card__title--bonus").text).to include("Earn faster with a sign-up bonus")
    show_all = find_els(:link, "See all cards with bonuses")
    find_el(:link, "See all cards with bonuses").click if show_all.count > 0
    wait.until { find_el(:id, "select-card__suggested-cards").displayed? }
    @cards_list = find_el(:id, "select-card__suggested-cards")

    @cards_list.find_elements(:css, ".select-card__list-item.credit-card").each do |card|
      logo = card.find_element(:class, 'credit-card__img')
      if logo[:alt].downcase.include? (card_name).downcase
        card.find_element(:link, ('Apply now').upcase).click if apply == true
        card.find_element(:css, '.credit-card__skip-action.credit-card__btn').click if apply == false
        break
      end
    end
  end

  def apply_card
  	sleep 1
    @wait.until { find_el(:link_text, "APPLY NOW") }.click
  end

  def approve_card
  	sleep 2
  	@d.keyboard.send_keys [:control, :f4]
  	sleep 2
    @wait.until { find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-approved').displayed? }
    find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-approved').click
    sleep 1
    continue
  end

  def pending_card
    sleep 2
    @d.keyboard.send_keys [:control, :f4]
    sleep 1.5
    # @wait.until { find_el(:css, 'label.step-card__radio-label.step-card__radio-label--credit-card-pending').displayed? }
    find_el(:class, 'step-card__choice-container').find_elements(:css, 'span.step-card__radio-status').last.click
    sleep 0.5
    continue
  end

  def setup_program phone
    @wait.until { find_el(:class, "step-card__phone-link").displayed? }
    expect(find_el(:class, "step-card__phone-link").text).to include(phone)
    sleep 0.5
    find_el(:name, 'number').send_keys '12345'
    continue
  end

  def activate_program account_number
  	sleep 2
  	short_account_number = find_el(:css, "span.step-card__short-account-number") if account_number
    @wait.until { expect(short_account_number.text).to include('12345') } if short_account_number
    @wait.until { find_el(:css, 'span.step-card__checkbox-text').displayed? }
    find_el(:css, 'span.step-card__checkbox-text').click
    continue
  end

  def update_manualy
  	@wait.until { find_el(:css, 'label.step-card__radio-label.step-card__radio-label--tracking-manual').displayed? }
    sleep 0.5
    find_el(:css, 'label.step-card__radio-label.step-card__radio-label--tracking-manual').click
    continue
  end

  def update_automatically
  	sleep 2
    @wait.until { find_el(:css, 'label.step-card__radio-label.step-card__radio-label--tracking-auto') }.click
    continue
  end

  def get_signup_bonus
  	@wait.until { find_el(:css, '.step-card__terms-link').displayed? }
    expect(find_el(:class, "step-card__main-heading").text).to include("To get your sign-up bonus, you need to meet the minimum spend.")
    continue
  end

  def remember_to_spend
    @wait.until { find_el(:css, '.step-card__credit-card-img').displayed? }
    @wait.until { expect(find_el(:class, "step-card__main-heading").text).to include("Reach your goal with this travel rewards card.") }
    continue
  end

  def congratulation
    @wait.until { find_el(:css, "h1.step-card__main-heading").displayed? }
    expect(find_el(:css, "h1.step-card__main-heading").text).to include('Congratulations')
    find_el(:class ,'step-card__submit-notification').click
  end

  def go_to_current_goal
  	#TODO:сделать что-то с паузой
  	sleep 1
    find_el(:css, ".aside__menu-item.aside__menu-item--progress").click
  end	

  def set_new_goal
    @wait.until { find_el(:link_text, 'SET NEW GOAL').displayed? }
    sleep 0.5
  	find_el(:link_text, 'SET NEW GOAL').click
    sleep 0.5
    @wait.until { find_el(:id, 'confirmation-popup__submit').displayed? }
    sleep 0.5
    find_el(:id, 'confirmation-popup__submit').click
    @wait.until { find_el(:css, "h2.step-form__heading").displayed? }
    find_el(:css, "h2.step-form__heading").text.include? "I want to travel"
  end

  def tell_me_more program_name
    @strategies_list.find_elements(:class, "strategy").each do |s|
      logo = s.find_element(:class, 'strategy__program-logo')
      if logo[:alt].downcase.include? (program_name).downcase
        s.find_element(:class, 'strategy__toggle-info').click
        break
      end
    end
  end

  def reset_strategy
    find_el(:css, "span.aside__panel-avatar").click
    @wait.until { find_el(:link_text, "Settings").displayed? }
    find_el(:link_text, "Settings").click
    @wait.until { find_el(:link_text, "Reset strategy").displayed? }
    find_el(:link_text, "Reset strategy").click
    @wait.until { find_el(:css, 'a.reset-strategy-popup__btn.reset-strategy-popup__reset-btn').displayed? }
    sleep 1
    find_el(:css, 'a.reset-strategy-popup__btn.reset-strategy-popup__reset-btn').click
    @wait.until { find_el(:css, "h2.step-form__heading").displayed? }
    sleep 0.5
  end

  def logout
  	sleep 1.5
  	find_el(:css, "span.aside__panel-avatar").click
    @wait.until { find_el(:link_text, "Log Out").displayed? }
    find_el(:link_text, "Log Out").click
    sleep 1
    @wait.until { find_el(:css, "span.home__map-heading--newline").displayed? }
    expect(find_el(:css, "span.home__map-heading--newline").text).to include("Just plan it.")
  end

  ######## EARN MILES ##############

  def go_to_earn_miles
    sleep 0.5
    find_el(:css, ".aside__menu-icon.aside__menu-icon--earn").click
  end

  def all_promos
    @wait.until { find_el(:css, 'h2.earn-miles__sub-heading').displayed? }
    expect(find_el(:css, 'h2.earn-miles__sub-heading').text).to include('Here are some deals to earn miles we found for you:')
  end

  def promos_for program_name
    all_promos
    @wait.until { find_el(:css, '.deals__list').displayed? }
    all_deals = find_el(:css, '.deals__list').find_elements(:class, 'blog-post-lead__body')
    all_deals.each do |deal|
      expect(deal.find_element(:css, 'img.blog-post-lead__program-logo')['src']).to include("#{program_name}.png").or include('multiple_rewards.png')
    end
  end

  def save_promos
    @wait.until { find_el(:css, '.deals__list').displayed? }
    sleep 0.5
    all_deals = find_el(:css, '.deals__list').find_elements(:class, 'blog-post-lead__body')
    all_deals.first.find_element(:css, '.blog-post-lead__save-btn').click
    all_deals[5].find_element(:css, '.blog-post-lead__save-btn').click
  end

  def check_saved_promos
    find_el(:css, '.earn-miles__nav-button.earn-miles__nav-button--favorite-deals').click
    @wait.until { find_el(:css, '.deals__list').displayed? }
    sleep 1
    all_deals = find_el(:css, '.deals__list').find_elements(:class, 'blog-post-lead__body')
    expect(all_deals.size).to eq 2
    # for preprod
    # expect(all_deals.first.find_element(:css, '.blog-post-lead__promo').text).to include('Stay at IHG Hotels and Get Double United Miles')
    # expect(all_deals.second.find_element(:css, '.blog-post-lead__promo').text).to include('Double United Miles for Stays at Marriott')
    # for prod
    # expect(all_deals.first.find_element(:css, '.blog-post-lead__promo').text).to include('Get 1,500 Iberia Avios for Weekend Stays at NH Hotels')
    # expect(all_deals.second.find_element(:css, '.blog-post-lead__promo').text).to include('Take a Cruise and Get 10,000 AAdvantage Miles')
  end

  def unsave_promos
    find_el(:css, '.blog-post-lead__save-btn').click
    # @all_deals.secon.find_element(:css, '.blog-post-lead__save-btn').click
  end

  ######### WALLET #################

  def go_to_wallet
  	@wait.until { find_el(:css, ".aside__menu-icon.aside__menu-icon--wallet").displayed? }
  	find_el(:css, ".aside__menu-icon.aside__menu-icon--wallet").click
  end

  def wallet_add_new
  	@wait.until { find_el(:css, ".wallet__primary-btn.wallet__choice-btn").displayed? }
    find_el(:css, ".wallet__primary-btn.wallet__choice-btn").click
  end

  def wallet_add_more
  	@wait.until { find_el(:css, 'a.wallet__add-btn').displayed? }
    find_el(:css, 'a.wallet__add-btn').click
  end

  def add_program_from_wallet num
  	@wait.until { find_el(:class, "accounts__block").displayed? }
    sleep 0.5
    el = find_els(:class, "accounts__block-name")[num]
    el.location_once_scrolled_into_view
    el.click
    # all_programs_and_cards.find_elements(:class, "accounts__block-body").each do |pc|
    # 	# p pc.find_element(:class, 'accounts__block-name')
    #   if pc.find_element(:class, 'accounts__block-name').text.downcase.include? (name).downcase
    #     pc.find_element(:class, 'accounts__block-name').click
    #     break
    #   end
    # end
    sleep 1
    find_el(:link_text, 'CONTINUE').click
  end

  def add_only_program num
    @wait.until { find_el(:class, "accounts__block").displayed? }
    find_el(:xpath,"//span[@data-value='all']").click
    sleep 0.5
    find_el(:xpath,"//div[@data-value='programs']").click
    sleep 0.5
    el = find_els(:class, "accounts__block-name")[num]
    el.location_once_scrolled_into_view
    el.click
    sleep 1
    find_el(:link_text, 'CONTINUE').click
  end

  def edit_balance miles
    # @wait.until { find_el(:css, '').displayed? }
    # find_el(:css, '')
    @wait.until { find_el(:class, "wallet-program__tooltip-btn").displayed? }
    sleep 1
    find_el(:class, "wallet-program__tooltip-btn").click
    @wait.until { find_el(:css, "a.wallet-program__tooltip-item.wallet-program__tooltip-item--edit").displayed? }
    sleep 0.5
    find_el(:css, "a.wallet-program__tooltip-item--edit").click
    @wait.until { find_el(:id, "account-form__miles").displayed? }
    enter_balance miles
  end

  def close_learning_popup
    sleep 1
  	submit_button = find_els(:class, 'cards-and-programs__learning-popup-submit-button')
  	find_el(:class, 'cards-and-programs__learning-popup-submit-button').click unless submit_button.empty?
  end

  def switch_to_manual
    sleep 1.5
    manual = find_els(:css, ".account-form__switching-link.account-form__switching-link--manual")
  	find_el(:css, ".account-form__switching-link.account-form__switching-link--manual").click if manual.size > 0
  end

  def enter_balance balance
    @wait.until { find_el(:class, "account-form__input--account-balance").displayed? }
  	account_balance = find_el(:class, "account-form__input--account-balance")
  	account_balance.clear
  	account_balance.send_keys(balance)
    find_el(:class, "add-program__save-btn").click
  end

  def remove_program_from_wallet
  	@wait.until { find_el(:class, "wallet-program__tooltip-btn").displayed? }
    sleep 1.5
    find_el(:class, "wallet-program__tooltip-btn").click
    @wait.until { find_el(:css, "a.wallet-program__tooltip-item--delete").displayed? }
    sleep 0.5
    find_el(:css, "a.wallet-program__tooltip-item--delete").click
    @wait.until { find_el(:css, "#confirmation-popup__submit").displayed? }
    sleep 0.5
    find_el(:css, "#confirmation-popup__submit").click
  end

  def remove_card_from_program
    @wait.until { find_el(:class ,'programs-credit-cards__card-close-btn').displayed? }
    find_el(:class ,'programs-credit-cards__card-close-btn').click
  end

  def edit_program_on_wallet
  	@wait.until { find_el(:link_text, "EDIT") }.click
    sleep 1
    find_el(:link_text, "Change settings").click
  end

  def add_card_by_name card_name
    @wait.until { find_el(:class, 'credit-cards__list').displayed? }
    cards = find_el(:class, 'credit-cards__list').find_elements(:class, 'credit-cards__card')
    cards.each do |card|
      logo = card.find_element(:class, 'credit-cards__card-img')
      if logo[:alt].downcase.include? (card_name).downcase
        card.find_element(:css, '.credit-cards__card-img').click
        break
      end
    end
    find_el(:class ,'credit-cards__save-btn').click
  end

  def edit_program_by_name program_name
    @wait.until { find_el(:class, 'wallet__programs').displayed? }
    wallet_programs = find_el(:class, 'wallet__programs').find_elements(:class, 'wallet-program')
    wallet_programs.each do |p|
      logo = p.find_element(:class, 'wallet-program__img')
      if logo[:alt].downcase.include? (program_name).downcase
        p.find_element(:css, 'a.wallet-program__tooltip-btn').click
        sleep 1
        p.find_element(:css, 'a.wallet-program__tooltip-item.wallet-program__tooltip-item--edit').click
        break
      end
    end
  end

  def check_other_program program_name
    @wait.until { find_el(:class, 'wallet__programs').displayed? }
    wallet_programs = find_el(:class, 'wallet__programs')
    wallet_programs.find_elements(:class, 'wallet-program').each do |p|
      logo = p.find_element(:class, 'wallet-program__img')
      if logo[:alt].downcase.include? (program_name).downcase
        expect(p.find_element(:css, 'a.wallet-program__tag--other.wallet-program__tag-other').text).to eq 'OTHER'
        break
      end
    end
  end

  def autoupdate_program name
  	sleep 3
  	@wait.until { expect(find_el(:css, "h2.program-info__name").text).to include(name) }
  end

  def autoupdate_credentials user
  	# sleep 3
  	@wait.until { find_el(:id, "account-form__login").displayed? }
  	form_login = find_el(:id, "account-form__login")
  	form_login.clear
  	form_login.send_keys(user[:login])
  	form_password = find_el(:id, "account-form__password")
  	form_password.clear
  	form_password.send_keys(user[:passwd])
  	find_el(:link_text, "CHECK BALANCE").click
  end

  def autoupdate_wrong_credentials user
  	sleep 2
  	find_el(:id, "account-form__login").send_keys('erdsasad')
  	find_el(:id, "account-form__password").send_keys(user[:passwd])
  	find_el(:link_text, "CHECK BALANCE").click
  end

  def autoupdate_error program
  	@long_wait.until { find_el(:class, 'flash-message__content').displayed? }
  	if find_el(:class, 'flash-message__content').text == "Your request of balance #{program} is being processed. Please wait."
      sleep 10
      @long_wait.until { find_el(:class, 'flash-message__content').displayed? }
    end
  	expect(find_el(:class, 'flash-message__content').text).to include("We are having problems with your #{program} ID and/or auto update.")
  	# @long_wait.until { find_el(:css, 'p.account-form__connection-error') }
  end

  def close_flash_message
  	find_el(:class, 'flash-message__close-btn').click
  end

  def starwood_question
  	question_text = @long_wait.until { find_el(:css, 'p.account-form__status-msg.account-form__status-msg--pre-label') }.text
  	# p question_text
  	case question_text
  	when /In what city or town was your first job?/
  		find_el(:id, "account-form__answer").send_keys('Kiev')
  	when /What is your favorite type of food?/
  		find_el(:id, "account-form__answer").send_keys('Pizza')
  	when /Where did you go on your first flight?/
  		find_el(:id, "account-form__answer").send_keys('Simferopol')
  	when /What is your favorite vacation destination?/
  		find_el(:id, "account-form__answer").send_keys('New York')
    else
      puts "Error"
  	end
    find_el(:link_text, "UPDATE BALANCE").click
  end

  def autoupdate_answer
  	@long_wait.until { expect(find_el(:css, "p.account-form__success-msg").text).to include('Your balance updated successfully!') }
  end

  def wallet_save_account_btn
    @wait.until { find_el(:class, 'add-program__save-btn').displayed? }
  	find_el(:class, 'add-program__save-btn').click
  end

  def wallet_cancel_button
  	# @wait.until { find_el(:class, "add-program__dismiss-btn").text > 0 }
  	find_el(:class, "add-program__dismiss-btn").click
  end

  def wallet_save_button
  	# @wait.until { find_el(:class, "add-program__save-btn").text > 0 }
  	find_el(:link_text, "SAVE").click
  end

  def wallet_add_new_button
  	@wait.until { find_el(:link_text, "Add your miles and points".upcase) }
  end

  def autoupdate_status(status, count) 
  	sleep 3
  	wallet_programs = find_el(:class, "wallet__programs")
  	programs = wallet_programs.find_elements(:class, 'wallet-program__status-edit-link')
  	expect(programs.count).to eq(count)
  	if programs.first.text == 'CONNECTING ...'
  		@long_wait.until { find_el(:class, 'wallet-program__status-edit-link').text == status }
  	end
  	expect(programs.first.text).to include(status) if programs.first
  	expect(programs.second.text).to include(status) if programs.second
  end

  ##### Wallet blocks #####

  def add_program_from_wallet_block num
  	go_to_wallet
  	wallet_add_more
    add_program_from_wallet num
    close_learning_popup
    switch_to_manual
    enter_balance '150'
    go_to_current_goal
  end

  ########## PIE ################### 

  def pie_have_program name
  	@wait.until { find_el(:class, "cabinet__programs").displayed? }
  	cabinet_programs = find_el(:class, "cabinet__programs")
  	cabinet_programs.find_elements(:class, 'cabinet__program').each do |program|
  		program_name = program.find_element(:css, "span.cabinet__program-name").text
  		expect(program_name).to include(name) if program_name == name
  		# p program_name if program_name == name
  	end
    # @wait.until { expect(find_el(:css, "span.cabinet__program-name").text).to include(name) }
  end

  def pie_have_other_program
    @wait.until { expect(find_el(:css, "span.cabinet__other-program-name").text).to include("Other programs") }
  end

  def pie_have_reminder program_name
    @wait.until { find_el(:css, '.cabinet__program-popup-link').displayed? }
    expect(find_el(:css, '.cabinet__program-popup-link').text).to include("Sign Up for #{program_name}")
  end

  def click_footer_reminder
    @wait.until { find_el(:css, 'span.ready-steps__toggle-btn.ready-steps__toggle-link').displayed? }
    sleep 1
    find_el(:css, 'span.ready-steps__toggle-btn.ready-steps__toggle-link').click
  end

  def miles_in_pie miles
  	sleep 3
    @wait.until { expect(find_el(:css, "span.cabinet__mileage").text).to include(miles) }
  end

########## Award Wallet ################

  def award_starwood_question
  	question_text = @wait.until { find_el(:css, 'p.question') }.text
  	p question_text
  	case question_text
  	when 'What is your favorite airport?'
  		@d.execute_script("return $('input#securityAnswer').val('JFK');")
  	when 'In what city or town was your first job?'
  		@d.execute_script("return $('input#securityAnswer').val('Nikolaev');")
  	when 'What is the location of your favorite family photo?'
  		@d.execute_script("return $('input#securityAnswer').val('Odessa');")
  	when 'What is your favorite city in the world to visit?'
  		@d.execute_script("return $('input#securityAnswer').val('London');")
  	end
  	find_el(:xpath,"//label[@data-form='securityQForm']").click
  	find_el(:id, 'checkSubmit').click
    # find_el(:link_text, "UPDATE BALANCE").click
  end
end
