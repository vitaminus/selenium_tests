require 'spec_helper'
require "selenium-webdriver"
# Capybara.default_driver = :selenium

describe "Social network sign in" do

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

  it 'with Facebook' do
    social_sign_in 'Facebook'
    @wait.until { find_el(:css, 'span._50f6').displayed? }
    find_el(:id, "email").send_keys('+380503927000')
    find_el(:id, "pass").send_keys('1qaz2wsx1qaz2wsx')
    find_el(:id, "loginbutton").click
    @long_wait.until { find_el(:css, "h2.step-form__heading").displayed? }
    expect(find_el(:css, "h2.step-form__heading").text).to eq 'I want to travel'
    logout
  end

  it 'with Google+' do
    social_sign_in 'Google+'
    @wait.until { find_el(:id, 'Email').displayed? }
    find_el(:id, "Email").send_keys('belief.2012@gmail.com')
    find_el(:xpath,"//input[@value='Next']").click
    @wait.until { find_el(:id, 'Passwd').displayed? }
    find_el(:id, "Passwd").send_keys('gmailpa$$word')
    find_el(:xpath,"//input[@value='Sign in']").click
    unless find_els(:id, 'submit_approve_access').size == 0
      @wait.until { find_el(:id, 'submit_approve_access').displayed? }
      find_el(:id, "submit_approve_access").click
    end
    @long_wait.until { find_el(:css, "h2.step-form__heading").displayed? }
    expect(find_el(:css, "h2.step-form__heading").text).to eq 'I want to travel'
    logout
  end

  it 'with Yahoo' do
    social_sign_in 'Yahoo'
    @wait.until { find_el(:id, 'login-username').displayed? }
    find_el(:id, "login-username").send_keys('ekaterina.kulik@yahoo.com')
    find_el(:id, "login-signin").click
    @wait.until { find_el(:id, 'login-passwd').displayed? }
    find_el(:id, "login-passwd").send_keys('yahoopa$$word')
    find_el(:id, "login-signin").click
    @wait.until { find_el(:id, 'oauth2-agree').displayed? }
    find_el(:id, "oauth2-agree").click
    @long_wait.until { find_el(:css, "h2.step-form__heading").displayed? }
    expect(find_el(:css, "h2.step-form__heading").text).to eq 'I want to travel'
    logout
  end

end
