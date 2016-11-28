describe "Homepage" do

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

  it "should prompt user for his destination" do
    expect(find_el(:css, "span.home__map-heading--newline").text).to include("Just plan it.")
    expect(find_el(:css, "h2.home__map-heading2").text).to include("Here are some award ticket strategies")
    expect(find_el(:css, "h2.home__section-heading").text).to include("We will change the way you look at miles and award tickets")
  	expect(find_el(:css, "span.home__target-heading-text").text).to include("Popular places to go in")
  end

  it "pick up destination" do
    fill_in_waypoint_homepage 'JFK', 'LHR'
    click_upcase_link 'let\'s get started'
    expect(find_el(:css, "h1.step-card__main-heading").text).to include("Your everyday credit card purchases = miles you'll earn.")
  end

  it 'link About Us' do
    click_upcase_link 'About Us'
    expect(find_el(:css, "h1.about__content-heading").text).to include('About Our Company')
  end

  it 'link Contact Us' do
    click_upcase_link 'Contact Us'
    expect(find_el(:css, "h1.contacts__heading").text).to include('Have questions? Contact us!')
  end

  # it 'link Blog' do
  #   click_upcase_link 'Blog'
  #   @wait.until { find_el(:class, 'aside-box-title').displayed? }
  #   expect(find_el(:class, "aside-box-title").text).to include('FEATURED POSTS')
  # end

  it 'link Terms of use' do
    find_el(:link, 'Terms of use').click
    expect(find_el(:css, "h1.terms-card__main-heading").text).to include('Terms and conditions of use')
  end

  it 'link Privacy Policy' do
    find_el(:link, 'Privacy Policy').click
    expect(find_el(:css, "h1.terms-card__main-heading").text).to include('Privacy Policy')
  end

  it 'link Site Map' do
    find_el(:link, 'Site Map').click
    expect(find_el(:css, "h1.terms-card__main-heading").text).to include('Sitemap')
  end

it 'press page' do
  find_el(:link, 'Press').click
  all_windows = @d.window_handles
  @d.switch_to.window(all_windows.last)
  wait.until { find_el(:css, 'a.press-panel__info-link').displayed? }
  expect(find_el(:css, 'a.press-panel__info-link').text).to include('kaja@rewardexpert.com')
  titles = find_els(:class, 'press-panel__title')
  expect(titles[0].text).to eq 'Media'
  expect(titles[1].text).to eq 'Press Releases'
  expect(titles[2].text).to eq 'In The News'
  links = find_els(:class, 'press-panel__info-link')
  expect(links.size).to be >= 18
end

  it 'interactive map' do
    all_map_cities = find_el(:class, 'home__map-container')
    all_map_cities.find_elements(:class, 'home__map-city').each do |city|
      if city.find_element(:css, "span.home__map-city-name").text == 'London'
        city.find_element(:css, "span.home__map-city-name").location_once_scrolled_into_view
        city.find_element(:css, "span.home__map-city-name").click
      end
    end
    find_el(:class, 'city-popup__content-footer').click
    wait.until { find_el(:css, "h2.step-form__heading").displayed? }
    expect(find_el(:css, "h2.step-form__heading").text).to include('I want to travel')
    expect(find_el(:class, "location-field__input--to")["value"]).to eq("London, LON")
  end

  # scenario 'screens list', broken: true do
  #   visit root_path

  #   find('a.home__screens-link.home__screens-link--big').click
  #   expect(page).to have_css('.home__screens.home__carousel--open', text: 'Your Dashboard')

  #   sleep 1
  #   find('.home__carousel-close').click
  #   find('a.home__screens-link.home__screens-link--small', match: :first).click
  #   expect(page).to have_css('.home__screens.home__carousel--open', text: 'Your Strategy')

  #   sleep 1
  #   find('.home__carousel-close').click
  #   find("img[alt='Your Reward Wallet']").click
  #   expect(page).to have_css('.home__screens.home__carousel--open', text: 'Your Reward Wallet')
  # end

  # scenario 'target carusel select' do
  #   visit root_path

  #   find('.home-dropdown__current').click
  #   click_link 'US'

  #   expect(page).to have_css('.home__target-carousel-city', text: %r{Miami}i)
  #   expect(page).to have_css('.home__target-carousel-city', text: %r{San Francisco}i)

  #   find('.home-dropdown__current').click
  #   click_link 'Asia'
  #   expect(page).to have_css('.home__target-carousel-city', text: %r{Seoul}i)
  #   expect(page).to have_css('.home__target-carousel-city', text: %r{Hong Kong}i)

  #   find('.owl-next').click
  #   expect(page).to have_css('.home__target-carousel-city', text: %r{Manila}i)
  #   find('.owl-next').click
  #   expect(page).to have_css('.home__target-carousel-city', text: %r{Tokyo}i)
  # end

end
