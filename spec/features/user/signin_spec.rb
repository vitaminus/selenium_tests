describe "User" do

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

  it "valid sign in - USL1" do
  	sign_in
    @wait.until { find_el(:class, "step-form__heading").displayed? }
    expect(find_el(:class, "step-form__heading").text).to include("I want to travel")
    logout
  end

  it "not valid email sign in - USL2" do
    @wait.until { find_el(:link, "LOG IN").displayed? }
    find_el(:link, "LOG IN").click
    find_el(:id, "auth__email").send_keys('ver@asd.com')
    find_el(:id, "auth__password").send_keys('123456789')
    find_el(:xpath,"//input[@value='Log in']").click
    @wait.until { find_el(:class, "auth__tooltip-message").displayed? }
    expect(find_el(:class, "auth__tooltip-message").text).to include("Error with your email or password")
  end

  it "not valid password sign in - USL2" do
    @wait.until { find_el(:link, "LOG IN").displayed? }
    find_el(:link, "LOG IN").click
    find_el(:id, "auth__email").send_keys('vitamin@vitamin.com')
    find_el(:id, "auth__password").send_keys('12345678')
    find_el(:xpath,"//input[@value='Log in']").click
    @wait.until { find_el(:class, "auth__tooltip-message").displayed? }
    expect(find_el(:class, "auth__tooltip-message").text).to include("Error with your email or password")
  end

  it 'Log Out option #1 - USL3' do
  end

  it 'Log Out option #2 - USL4' do
  end

  it 'Check Icons in Authorization Fields - USL5' do
  end

  it 'Log In via Social Network After Choosing a Strategy - USL6' do
    fill_in_waypoint_homepage 'JFK', 'LHR'
    click_upcase_link "let's get started"
    monthly_spending
    choose_strategy_by_name "Mileage Plan™"
    find_el(:link, "Log In").click
    sleep 0.5
    @wait.until { find_el(:id, "auth__email").displayed? }
    find_el(:id, "auth__email").send_keys('testinglogin@reward.expert')
    #find_el(:xpath,"//input[@value='Next']").click
    #@wait.until { find_el(:id, 'Passwd').displayed? }
    find_el(:id, "auth__password").send_keys('testinglogin@reward.expert')
    find_el(:class,"auth__form-submit").click
    #unless find_els(:id, 'submit_approve_access').size == 0
     # @wait.until { find_el(:id, 'submit_approve_access').displayed? }
      #find_el(:id, "submit_approve_access").click
    #end
    # @wait.until { find_el(:css, "label.step-card__radio-label.step-card__radio-label--credit-score-good").displayed? }
    # choose_credit_score 'good'
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 1
    expect(find_el(:css, '.aside__current-trip-region span.aside__menu-location').text).to eq 'Amsterdam'
    numbers = find_el(:class, 'select-card__balance').find_elements(:css, 'span.select-card__balance-cell')
    expect(numbers[0].text).to eq '2'
    expect(numbers[1].text).to eq '5'
    expect(numbers[2].text).to eq '0'
    expect(numbers[3].text).to eq '0'
    expect(numbers[4].text).to eq '0'
    expect(find_el(:class, 'select-card__header-program-img')[:alt]).to eq 'Flying Blue'
    logout
    @d.execute_script('window.sessionStorage.clear()')
    @d.execute_script("window.localStorage.clear()")
  end

  it 'Log In via email After Choosing a Strategy - USL7' do
    fill_in_waypoint_homepage 'JFK', 'LHR'
    click_upcase_link "let's get started"
    monthly_spending
    choose_strategy_by_name "Mileage Plan™"
    find_el(:link, 'Log In').click
    @wait.until { find_el(:id, 'auth__email').displayed? }
    find_el(:id, "auth__email").send_keys('testinglogin@reward.expert')
    find_el(:id, "auth__password").send_keys('testinglogin@reward.expert')
    find_el(:xpath,"//input[@value='Log in']").click
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    expect(find_el(:css, '.aside__current-trip-region span.aside__menu-location').text).to eq 'Amsterdam'
    numbers = find_el(:class, 'select-card__balance').find_elements(:css, 'span.select-card__balance-cell')
    expect(numbers[0].text).to eq '2'
    expect(numbers[1].text).to eq '5'
    expect(numbers[2].text).to eq '0'
    expect(numbers[3].text).to eq '0'
    expect(numbers[4].text).to eq '0'
    expect(find_el(:class, 'select-card__header-program-img')[:alt]).to eq 'Flying Blue'
    logout
    @d.execute_script('window.sessionStorage.clear()')
    @d.execute_script("window.localStorage.clear()")
  end

  it 'Log In via Social Network Without Choosing a Strategy - USL8' do
    @wait.until { find_el(:link, "LOG IN").displayed? }
    find_el(:link, "LOG IN").click
    find_el(:link, "LOG IN WITH GOOGLE+").click
    unless find_els(:id, 'Email').size == 0
      @wait.until { find_el(:id, 'Email').displayed? }
      find_el(:id, "Email").send_keys('testrewardexpert@gmail.com')
      find_el(:xpath,"//input[@value='Next']").click
      @wait.until { find_el(:id, 'Passwd').displayed? }
      find_el(:id, "Passwd").send_keys('testr3ward')
      find_el(:xpath,"//input[@value='Sign in']").click
      unless find_els(:id, 'submit_approve_access').size == 0
        @wait.until { find_el(:id, 'submit_approve_access').displayed? }
        find_el(:id, "submit_approve_access").click
      end
    end
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    expect(find_el(:css, '.aside__current-trip-region span.aside__menu-location').text).to eq 'Amsterdam'
    numbers = find_el(:class, 'select-card__balance').find_elements(:css, 'span.select-card__balance-cell')
    expect(numbers[0].text).to eq '2'
    expect(numbers[1].text).to eq '5'
    expect(numbers[2].text).to eq '0'
    expect(numbers[3].text).to eq '0'
    expect(numbers[4].text).to eq '0'
    expect(find_el(:class, 'select-card__header-program-img')[:alt]).to eq 'Flying Blue'
    logout
    @d.execute_script('window.sessionStorage.clear()')
    @d.execute_script("window.localStorage.clear()")
  end

  it 'Log In via email Without Choosing a Strategy - USL9' do
    @wait.until { find_el(:link, "LOG IN").displayed? }
    find_el(:link, "LOG IN").click
    find_el(:id, "auth__email").send_keys('testrewardexpert@gmail.com')
    find_el(:id, "auth__password").send_keys('testr3ward')
    find_el(:xpath,"//input[@value='Log in']").click
    @wait.until { find_el(:css, '.select-card__expand-link.select-card__expand-link--suggested-cards.select-card__expand-link--see-all').displayed? }
    sleep 0.5
    expect(find_el(:css, '.aside__current-trip-region span.aside__menu-location').text).to eq 'Amsterdam'
    numbers = find_el(:class, 'select-card__balance').find_elements(:css, 'span.select-card__balance-cell')
    expect(numbers[0].text).to eq '2'
    expect(numbers[1].text).to eq '5'
    expect(numbers[2].text).to eq '0'
    expect(numbers[3].text).to eq '0'
    expect(numbers[4].text).to eq '0'
    expect(find_el(:class, 'select-card__header-program-img')[:alt]).to eq 'Flying Blue'
    logout
  end

end
