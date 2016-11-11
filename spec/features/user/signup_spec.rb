describe "Registration" do

  before(:all) do
    @d = driver
    window_size
    @wait = wait
    @long_wait = long_wait
  end

  before(:each) do
    navigate_to
    code_word
    @new_user = new_user
  end

  after(:all) do
    quit
  end

  it "valid - UR1" do
  	register
    logout
  end

  it "with empty name - UR2" do
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys('')
    find_el(:id, "auth__email").send_keys(@new_user)
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys(@new_user)
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, "p.auth__tooltip-message").displayed? }
    expect(find_el(:css, "p.auth__tooltip-message").text).to include "Please enter your name"
  end

  it "with empty email - UR3" do
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys('')
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys(@new_user)
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, "p.auth__tooltip-message").displayed? }
    expect(find_el(:css, "p.auth__tooltip-message").text).to include "Please enter a valid email"
  end

  it "with invalid email - UR4" do
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys('asd@asdsad')
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys(@new_user)
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, "p.auth__tooltip-message").displayed? }
    expect(find_el(:css, "p.auth__tooltip-message").text).to include "Please enter a valid email"
  end

  it "with taken email - UR5" do
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys('vitamin@vitamin.com')
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys(@new_user)
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, "p.auth__tooltip-message").displayed? }
    expect(find_el(:css, "p.auth__tooltip-message").text).to include "This email has already been taken"
  end

  it "with empty password - UR6" do
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys(@new_user)
    find_el(:id, "auth__password").send_keys('')
    find_el(:id, "auth__password_confirmation").send_keys(@new_user)
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, "p.auth__tooltip-message").displayed? }
    expect(find_el(:css, "p.auth__tooltip-message").text).to include "Please enter a password"
  end

  it "with too short password - UR7" do
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys(@new_user)
    find_el(:id, "auth__password").send_keys('passwor')
    find_el(:id, "auth__password_confirmation").send_keys('passwor')
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, "p.auth__tooltip-message").displayed? }
    expect(find_el(:css, "p.auth__tooltip-message").text).to include "Password should be 8 chars minimum"
  end

  it "with empty password confirmation - UR8" do
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys(@new_user)
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys('')
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, "p.auth__tooltip-message").displayed? }
    expect(find_el(:css, "p.auth__tooltip-message").text).to include "Please enter a password confirmation"
  end

  it "with wrong confirmation - UR9" do
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys(@new_user)
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys('passwords')
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, "p.auth__tooltip-message").displayed? }
    expect(find_el(:css, "p.auth__tooltip-message").text).to include "Password confirmation should match password"
  end

  it "with unchecked terms and conditions - UR10" do
    click_upcase_link 'Register'
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys(@new_user)
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys(@new_user)
    # find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, "p.auth__tooltip-message").displayed? }
    expect(find_el(:css, "p.auth__tooltip-message").text).to include "Terms of service must be accepted"
  end

  it 'via standard form when strategy is not selected - UR11' do
    @d.execute_script('window.sessionStorage.clear()')
    @d.execute_script("window.localStorage.clear()")
    fill_in_waypoint_homepage 'JFK', 'LHR'
    click_upcase_link "let's get started"
    sleep 2
    #click_upcase_link 'Register'
    @wait.until {find_el(:css, ".button.button--register").displayed? }
    find_el(:css, ".button.button--register").click
    @wait.until { find_el(:id, "auth__name").displayed? }
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys(@new_user)
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys(@new_user)
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, ".wallet__secondary-btn.wallet__choice-btn").displayed? }
    expect(find_el(:css, ".wallet__secondary-btn.wallet__choice-btn").text).to include(("Not now. Continue to goal").upcase)
    expect(find_el(:css, ".wallet__primary-btn.wallet__choice-btn").text).to include(("Add your miles and points").upcase)
    go_to_current_goal
    @wait.until { find_el(:css, 'h2.step-card__body-heading').displayed? }
    expect(find_el(:css, 'h2.step-card__body-heading').text).to include 'How much do you spend'
    logout
  end

  it 'via standard form when strategy is not selected - UR12' do
    @d.execute_script('window.sessionStorage.clear()')
    @d.execute_script("window.localStorage.clear()")
    fill_in_waypoint_homepage 'JFK', 'LHR'
    click_upcase_link "let's get started"
    monthly_spending
    choose_strategy_by_name "Executive Club"
    find_el(:id, "auth__name").send_keys(@new_user)
    find_el(:id, "auth__email").send_keys(@new_user)
    find_el(:id, "auth__password").send_keys(@new_user)
    find_el(:id, "auth__password_confirmation").send_keys(@new_user)
    find_el(:class, "auth__form-checkbox-label").click
    find_el(:xpath,"//input[@value='Register now']").click
    @wait.until { find_el(:css, ".wallet__secondary-btn.wallet__choice-btn").displayed? }
    expect(find_el(:css, ".wallet__secondary-btn.wallet__choice-btn").text).to include(("Not now. Continue to goal").upcase)
    expect(find_el(:css, ".wallet__primary-btn.wallet__choice-btn").text).to include(("Add your miles and points").upcase)
    go_to_current_goal
    choose_credit_score 'bad'
    frequent_flying
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    expect(find_el(:css, "h2.strategies__heading.strategies__heading--active").text).to include "Ways to Get There"
    logout
  end

  it 'via social network when strategy is selected - AR2' do
    fill_in_waypoint_homepage 'JFK', 'LHR'
    click_upcase_link "let's get started"
    monthly_spending
    choose_strategy_by_name "Mileage Plan™"
    social_sign_up 'Google+'
    @wait.until { find_el(:id, 'Email').displayed? }
    find_el(:id, "Email").send_keys('teststepswithchosenstrategy@gmail.com')
    find_el(:xpath,"//input[@value='Next']").click
    @wait.until { find_el(:id, 'Passwd').displayed? }
    find_el(:id, "Passwd").send_keys('gmailpa$$word')
    find_el(:xpath,"//input[@value='Sign in']").click
    sleep 5
    @wait.until { find_el(:class, "wallet__secondary-btn").displayed? }
    go_to_current_goal
    choose_credit_score 'good'
    sleep 3
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    expect(find_el(:class, 'select-card__header-program-img')[:alt]).to eq 'Mileage Plan™'
    logout
  end

end
