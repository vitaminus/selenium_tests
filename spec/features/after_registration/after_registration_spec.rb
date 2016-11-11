describe 'After registration' do

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

  it 'Chars limit in field Name' do
    register
    go_to_profile_settings
    profile_change_name
    sleep 0.5
    expect(find_el(:class, "settings-field-group__tooltip-message").text).to include('Username should be 40 chars maximum')
    exit_profile_settings
    logout
  end

end
