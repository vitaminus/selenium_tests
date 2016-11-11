describe "Before registration" do

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

  it 'steps' do
    sleep 1
    fill_in_waypoint_homepage 'JFK', 'LHR'
    click_upcase_link "let's get started"
    expect(@d.find_element(:css, "h1.step-card__main-heading").text).to include("Your everyday credit card purchases = miles you'll earn.")
    monthly_spending
    @long_wait.until { @d.find_element(:class, "strategies__list").displayed? }
    expect(@d.find_element(:css, "a.strategies__registration-btn").text).to include('REGISTER TO ADD YOUR PROGRAMS OR CARDS')
  end

end
