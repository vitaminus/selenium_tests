describe "Landing American express membership rewards points", preprod: false do

  before(:all) do
    @d = driver
    window_size
    @wait = wait
    @long_wait = long_wait
  end

  before(:each) do
    @d.navigate.to("#{ENV["URL"]}/american-express-membership-rewards-points/")
    # code_word
  end

  after(:all) do
    quit
  end

  it 'should prompt user for his destination' do
    sleep 1
    expect(@d.find_element(:css, "h1.intro-section__heading").text).to include("Fly For Free with Amex Points")
    advises = @d.find_element(:class, 'intro-section__advices').find_elements(:class, 'intro-section__advice')
    expect(advises.first.find_element(:css, "h2.intro-section__advice-title").text).to include("TRANSFER TO 16 AIRLINES")
    expect(advises.second.find_element(:css, "h2.intro-section__advice-title").text).to include("FREE ECONOMY OR BUSINESS CLASS")
    expect(@d.find_element(:css, "h2.landing-section__heading").text).to include("Maximize your Membership Rewards")
  end

end
