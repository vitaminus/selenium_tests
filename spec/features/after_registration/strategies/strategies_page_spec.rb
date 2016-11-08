require 'spec_helper'
require "selenium-webdriver"

describe "Strategies page" do

  before(:all) do
    @d = driver
    window_size
    @wait = wait
    @long_wait = long_wait
  end

  before(:each) do
    navigate_to
    code_word
    register
    go_to_current_goal
    fill_in_waypoint('JFK', 'LHR')
    monthly_spending
  end

  after(:all) do
    quit
  end

  it 'qty of ways' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")
    strategies_count = @strategies_list.find_elements(:class, "strategy").count
    expect(find_el(:css, "h2.strategies__heading.strategies__heading--active").text).to include("#{strategies_count} Ways to Get There")
    # sleep 1
    # reset_strategy
    logout
  end

  it 'tell me more' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")
    tell_me_more 'Ultimate Rewards®'
    @wait.until { find_el(:class, "routes").displayed? }
    routes_list = find_el(:class, "routes")
    first_page_routes_count = routes_list.find_elements(:class, "route").count
    expect(first_page_routes_count).to eq 10
    find_el(:link, ('Next').upcase).click
    routes_list = find_el(:class, "routes")
    second_page_routes_count = routes_list.find_elements(:class, "route").count
    expect(second_page_routes_count).to eq 5
    find_el(:link, ('Program').upcase).click
    @wait.until { find_el(:css, 'h3.strategy-info__title').displayed? }
    strategy_info = find_els(:css, 'h3.strategy-info__title')
    expect((strategy_info.first).text).to include("Program Snapshot")
    expect((strategy_info.last).text).to include("Pros & Cons")
    find_el(:link, ('Routes').upcase).click
    routes_list = find_el(:class, "routes")
    second_page_routes_count = routes_list.find_elements(:class, "route").count
    expect(second_page_routes_count).to eq 5
    # sleep 1
    # reset_strategy
    logout
  end

  it 'show me less' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")
       
    tell_me_more 'Ultimate Rewards®'
    @wait.until { find_el(:link_text, ('Hide details').upcase).displayed? }
    find_el(:link_text, ('Hide details').upcase).click
    sleep 1
    show_routes = find_el(:class, "routes").displayed?
    expect(show_routes).to be_falsey
    # sleep 1
    # reset_strategy
    logout
  end

  it 'hide routes' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")
    tell_me_more 'Ultimate Rewards®'
    @wait.until { find_el(:link, ('Hide details').upcase).displayed? }
    find_el(:link, ('Hide details').upcase).click
    sleep 1
    show_routes = find_el(:class, "routes").displayed?
    expect(show_routes).to be_falsey
    # sleep 1
    # reset_strategy
    logout
  end

  it 'sorting by default' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    sleep 0.5
    @strategies_list = find_el(:class, "strategies__list")
    expect_rating 'A', 0
    # expect_rating 'A', 1
    # expect_rating 'A', 2
    # expect_rating 'B', 4
    expect_rating 'B', 6
    # expect_rating 'B', 8
    # expect_rating 'C', 9
    expect_rating 'C', 13
    # expect_rating 'C', 16
    # sleep 1
    # reset_strategy
    logout
  end

  it 'sorting by rate' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")

    find_el(:xpath,"//a[@data-sort='rating']").click
    sleep 1
    expect_rating 'C', 0
    # expect_rating 'C', 3
    # expect_rating 'C', 6
    # expect_rating 'B', 7
    expect_rating 'B', 10
    # expect_rating 'B', 13
    # expect_rating 'A', 14
    expect_rating 'A', 15
    # expect_rating 'A', 16
    find_el(:xpath,"//a[@data-sort='rating']").click
    sleep 1
    expect_rating 'A', 0
    # expect_rating 'A', 1
    # expect_rating 'A', 2
    # expect_rating 'B', 3
    expect_rating 'B', 6
    # expect_rating 'B', 9
    # expect_rating 'C', 10
    # expect_rating 'C', 13
    expect_rating 'C', 13
    # sleep 1
    # reset_strategy
    logout
  end

  it 'sorting by alphabet' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")

    find_el(:xpath,"//a[@data-sort='program']").click
    sleep 1
    expect(@strategies_list.find_elements(:class, "strategy").first.find_element(:css, 'img.strategy__program-logo')[:alt]).to eq 'AAdvantage®'
    expect(@strategies_list.find_elements(:class, "strategy").last.find_element(:css, 'img.strategy__program-logo')[:alt]).to eq 'Venture® Rewards'
    find_el(:xpath,"//a[@data-sort='program']").click
    sleep 1
    expect(@strategies_list.find_elements(:class, "strategy").first.find_element(:css, 'img.strategy__program-logo')[:alt]).to eq 'Venture® Rewards'
    expect(@strategies_list.find_elements(:class, "strategy").last.find_element(:css, 'img.strategy__program-logo')[:alt]).to eq 'AAdvantage®'
    # sleep 1.5
    # reset_strategy
    logout
  end

  it 'sorting by estimated cost' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")

    find_el(:xpath,"//a[@data-sort='miles']").click
    sleep 1
    expect(@strategies_list.find_elements(:class, "strategy").first.find_element(:css, 'span.strategy__cost-value.strategy__miles').text).to eq '26,000'
    expect(@strategies_list.find_elements(:class, "strategy").last.find_element(:css, 'span.strategy__cost-value.strategy__miles').text).to eq '95,000'
    find_el(:xpath,"//a[@data-sort='miles']").click
    sleep 1
    expect(@strategies_list.find_elements(:class, "strategy").first.find_element(:css, 'span.strategy__cost-value.strategy__miles').text).to eq '95,000'
    expect(@strategies_list.find_elements(:class, "strategy").last.find_element(:css, 'span.strategy__cost-value.strategy__miles').text).to eq '26,000'
    # sleep 1.5
    # reset_strategy
    logout
  end

  it 'sorting by fee' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")

    find_el(:xpath,"//a[@data-sort='taxes']").click
    sleep 1
    expect(@strategies_list.find_elements(:class, "strategy").first.find_element(:css, 'span.strategy__cost-value.strategy__fees').text).to eq '+ $0'
    expect(@strategies_list.find_elements(:class, "strategy").last.find_element(:css, 'span.strategy__cost-value.strategy__fees').text).to eq '+ $710'
    find_el(:xpath,"//a[@data-sort='taxes']").click
    sleep 1
    expect(@strategies_list.find_elements(:class, "strategy").first.find_element(:css, 'span.strategy__cost-value.strategy__fees').text).to eq '+ $710'
    expect(@strategies_list.find_elements(:class, "strategy").last.find_element(:css, 'span.strategy__cost-value.strategy__fees').text).to eq '+ $0'
    # sleep 1.5
    # reset_strategy
    logout
  end

  it 'sorting by month Qty' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")

    find_el(:xpath,"//a[@data-sort='months']").click
    sleep 1
    expect(@strategies_list.find_elements(:class, "strategy").first.find_element(:css, '.strategy__earn-time-duration').text).to eq '3 months'
    expect(@strategies_list.find_elements(:class, "strategy").last.find_element(:css, '.strategy__earn-time-duration').text).to eq '3+ years'
    find_el(:xpath,"//a[@data-sort='months']").click
    sleep 1
    expect(@strategies_list.find_elements(:class, "strategy").first.find_element(:css, '.strategy__earn-time-duration').text).to eq '3+ years'
    expect(@strategies_list.find_elements(:class, "strategy").last.find_element(:css, '.strategy__earn-time-duration').text).to eq '3 months'
    # sleep 1.5
    # reset_strategy
    logout
  end

  it 'sorting by fee when not empty wallet' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    go_to_wallet
    wallet_add_new
    add_program_from_wallet 18
    close_learning_popup
    enter_balance '10000'
    go_to_current_goal
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    find_el(:xpath,"//a[@data-sort='taxes']").click
    # sleep 1.5
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    logout
  end

  it 'sorting by estimated cost when not empty wallet' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    go_to_wallet
    wallet_add_new
    add_program_from_wallet 18
    close_learning_popup
    enter_balance '10000'
    go_to_current_goal
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    find_el(:xpath,"//a[@data-sort='miles']").click
    # sleep 1
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    logout
  end

  it 'ready to book' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    go_to_wallet
    wallet_add_new
    add_program_from_wallet 19
    close_learning_popup
    enter_balance '180000'
    go_to_current_goal
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    find_el(:xpath,"//a[@data-sort='miles']").click
    sleep 1
    expect(find_el(:css, 'a.strategies__book-link').text).to eq ('At least one of your programs has enough miles to book').upcase
    @strategies_list = find_el(:class, "strategies__list")
    @strategies_list.find_elements(:class, "strategy").each do |s|
      logo = s.find_element(:class, 'strategy__program-logo')
      if logo[:alt].downcase.include? ('MileagePlus®').downcase
        expect(s.find_element(:css, 'a.strategy__miles-balance').text).to eq '180,000'
        expect(s.find_element(:css, 'a.strategy__earn-time-label.strategy__earn-time-label--ready-to-book').text).to eq 'YOU HAVE ENOUGH MILES TO BOOK'
        break
      end
    end
    # sleep 1
    # reset_strategy
    # go_to_wallet
    # remove_program_from_wallet
    logout
  end

  it 'more then 1 adult' do
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list = find_el(:class, "strategies__list")

    @strategies_list.find_elements(:class, "strategy").each do |s|
      logo = s.find_element(:class, 'strategy__program-logo')
      if logo[:alt].downcase.include? ('MileagePlus®').downcase
        expect(s.find_element(:css, 'span.strategy__cost-value.strategy__miles').text).to eq '60,000'
        expect(s.find_element(:css, 'span.strategy__cost-value.strategy__fees').text).to eq ('+ $200')
        break
      end
    end

    find_els(:class, 'selectize-input')[2].click
    sleep 0.5
    find_el(:xpath,"//div[@data-value='3']").click
    find_el(:id, 'strategies-filter__submit-button').click
    sleep 0.5
    @long_wait.until { find_el(:class, "strategies__list").displayed? }
    @strategies_list_new = find_el(:class, "strategies__list")

    @strategies_list_new.find_elements(:class, "strategy").each do |s|
      logo = s.find_element(:class, 'strategy__program-logo')
      if logo[:alt].downcase.include? ('MileagePlus®').downcase
        expect(s.find_element(:css, 'span.strategy__cost-value.strategy__miles').text).to eq '180,000'
        expect(s.find_element(:css, 'span.strategy__cost-value.strategy__fees').text).to eq ('+ $580')
        break
      end
    end
    # sleep 1.5
    # reset_strategy
    logout
  end

end
