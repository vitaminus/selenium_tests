require 'spec_helper'
require "selenium-webdriver"

describe "After registration", integration: true do

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

end
