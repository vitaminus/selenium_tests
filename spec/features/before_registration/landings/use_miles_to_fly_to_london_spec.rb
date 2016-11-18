describe "Landing Use Miles To Fly To London", preprod: false do

  before(:all) do
    @d = driver
    window_size
    @wait = wait
    @long_wait = long_wait
  end

  before(:each) do
    @d.navigate.to("#{url}/use-miles-to-fly-to-london/")
    code_word unless url == 'preprod'
  end

  after(:all) do
    quit
  end

  it 'should prompt user for his destination' do
    sleep 1
    expect(@d.find_element(:css, "h1.intro-section__heading").text).to include("London Calling. Use Miles to Get There Free.")
    advises = @d.find_element(:class, 'intro-section__advices').find_elements(:class, 'intro-section__advice')
    expect(advises.first.find_element(:css, "h2.intro-section__advice-title").text).to include("SAVE $800 OR MORE")
    expect(advises[1].find_element(:css, "h2.intro-section__advice-title").text).to include("UP TO 50,000 BONUS MILES")
    expect(@d.find_element(:css, "h2.landing-section__heading").text).to include("Save money on airfare. Spend it in London.")
  end

end
