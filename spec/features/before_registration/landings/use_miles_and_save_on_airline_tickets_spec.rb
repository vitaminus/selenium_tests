describe "Landing Use Miles and Save Big on Airline Tickets", preprod: false do

  before(:all) do
    @d = driver
    window_size
    @wait = wait
    @long_wait = long_wait
  end

  before(:each) do
    @d.navigate.to("#{url}/use-miles-and-save-on-airline-tickets/")
    code_word unless url == 'preprod'
  end

  after(:all) do
    quit
  end

  it 'should prompt user for his destination' do
    sleep 1
    expect(@d.find_element(:css, "h1.intro-section__heading").text).to include("Use Miles and Save Big on Airline Tickets")
    advises = @d.find_element(:class, 'intro-section__advices').find_elements(:class, 'intro-section__advice')
    expect(advises.first.find_element(:css, "h2.intro-section__advice-title").text).to include("SAVE $500 OR MORE")
    expect(advises[1].find_element(:css, "h2.intro-section__advice-title").text).to include("UP TO 50,000 BONUS MILES")
    expect(@d.find_element(:css, "h2.landing-section__heading").text).to include("You can fly for just $11.")
  end

end
