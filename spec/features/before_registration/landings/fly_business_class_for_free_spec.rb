require 'spec_helper'
require "selenium-webdriver"

describe "Landing Fly business class for free", preprod: false do

  before(:all) do
    @d = driver
    window_size
    @wait = wait
    @long_wait = long_wait
  end

  before(:each) do
    @d.navigate.to("#{ENV["URL"]}/fly-business-class-for-free/")
    # code_word
  end

  after(:all) do
    quit
  end

  it 'should prompt user for his destination' do
    sleep 1
    expect(@d.find_element(:css, "h1.intro-section__heading").text).to include("Yes, You Can Afford Business Class")
    advises = @d.find_element(:class, 'intro-section__advices').find_elements(:class, 'intro-section__advice')
    expect(advises.first.find_element(:css, "h2.intro-section__advice-title").text).to include("FLY IN LUXURY FOR FREE")
    expect(advises.second.find_element(:css, "h2.intro-section__advice-title").text).to include("UP TO 50,000 BONUS MILES")
    expect(@d.find_element(:css, "h2.landing-section__heading").text).to include("The Big Seats Won't Cost Big Bucks")
  end

end
