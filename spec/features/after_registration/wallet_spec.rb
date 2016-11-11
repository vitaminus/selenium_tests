describe "Wallet" do

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

  it "add FF program (manual update) with balance = 0 - WL01" do
    register
    wallet_add_new
    add_only_program 6
    close_learning_popup
    switch_to_manual
    enter_balance 0
    sleep 1
    @wait.until { find_el(:class, 'wallet-program__balance').displayed? }
    expect(find_el(:class, 'wallet-program__balance').text).to include '0 miles'
    expect(find_el(:class, 'wallet-program__credit-cards-msg').text).to include 'You have no credit cards'
    logout
  end

  it "add Bank program (manual update) with balance = 0 - WL02" do
    register
    wallet_add_new
    add_only_program 3
    close_learning_popup
    @wait.until { find_el(:class, 'add-program__add-card-link').displayed? }
    sleep 0.5
    find_el(:class, 'add-program__add-card-link').click
    add_card_by_name 'Chase Sapphire Preferred® Card'
    sleep 0.5
    switch_to_manual
    enter_balance 0
    sleep 1
    @wait.until { find_el(:class, 'wallet-program__balance').displayed? }
    expect(find_el(:class, 'wallet-program__balance').text).to include '0 points'
    expect(find_el(:class, 'wallet-program__credit-card-img')['alt']).to include 'Chase Sapphire Preferred® Card'
    # remove_program_from_wallet
    logout
  end

  it "add Bank program (manual update) with balance = 2500 - WL03" do
    register
    wallet_add_new
    add_only_program 3
    close_learning_popup
    @wait.until { find_el(:class, 'add-program__add-card-link').displayed? }
    sleep 0.5
    find_el(:class, 'add-program__add-card-link').click
    add_card_by_name 'Chase Sapphire Preferred® Card'
    sleep 0.5
    switch_to_manual
    enter_balance 0
    sleep 1
    @wait.until { find_el(:class, 'wallet-program__balance').displayed? }
    expect(find_el(:class, 'wallet-program__balance').text).to include '0 points'
    expect(find_el(:class, 'wallet-program__credit-card-img')['alt']).to include 'Chase Sapphire Preferred® Card'
    edit_program_on_wallet
    enter_balance 2500
    sleep 1
    @wait.until { find_el(:class, 'wallet-program__balance').displayed? }
    expect(find_el(:class, 'wallet-program__balance').text).to include '2,500 points'
    expect(find_el(:class, 'wallet-program__credit-card-img')['alt']).to include 'Chase Sapphire Preferred® Card'
    # remove_program_from_wallet
    logout
  end

  it "delete program - WL04" do
    register
    wallet_add_new
    add_only_program 3
    close_learning_popup
    @wait.until { find_el(:class, 'add-program__add-card-link').displayed? }
    sleep 0.5
    find_el(:class, 'add-program__add-card-link').click
    add_card_by_name 'Chase Sapphire Preferred® Card'
    sleep 0.5
    switch_to_manual
    enter_balance 0
    sleep 1
    @wait.until { find_el(:class, 'wallet-program__balance').displayed? }
    expect(find_el(:class, 'wallet-program__balance').text).to include '0 points'
    expect(find_el(:class, 'wallet-program__credit-card-img')['alt']).to include 'Chase Sapphire Preferred® Card'
    remove_program_from_wallet
    @wait.until { find_el(:css, 'h2.wallet__sub-heading').displayed? }
    expect(find_el(:css, 'h2.wallet__sub-heading').text).to include "We'll show you the best way to use them."
    logout
  end

  it "delete card from program - WL04/01" do
    register
    wallet_add_new
    add_only_program 6
    close_learning_popup
    @wait.until { find_el(:class, 'add-program__add-card-link').displayed? }
    sleep 0.5
    find_el(:class, 'add-program__add-card-link').click
    add_card_by_name 'Alaska Airlines Visa® Business Card'
    sleep 0.5
    switch_to_manual
    enter_balance 0
    sleep 1
    @wait.until { find_el(:class, 'wallet-program__balance').displayed? }
    expect(find_el(:class, 'wallet-program__balance').text).to include '0 miles'
    expect(find_el(:class, 'wallet-program__credit-card-img')['alt']).to include 'Alaska Airlines Visa® Business Card'
    edit_program_on_wallet
    remove_card_from_program
    sleep 0.5
    expect(find_el(:class, 'add-program__add-card-link').text).to include 'Add them now'
    find_el(:class, 'add-program__save-btn').click
    sleep 1
    @wait.until { find_el(:class, 'wallet-program__balance').displayed? }
    expect(find_el(:class, 'wallet-program__balance').text).to include '0 miles'
    expect(find_el(:class, 'wallet-program__credit-cards-msg').text).to include 'You have no credit cards'
    # remove_program_from_wallet
    logout
  end

  it 'add FF program (auto update) with correct login/password. One step authentication. - WL05' do
    register
    wallet_add_new
    add_only_program 6
    close_learning_popup
    autoupdate_credentials alaska_mileage_plan_user
    autoupdate_answer
    close_flash_message
    sleep 2
    wallet_cancel_button
    # sleep 2
    # remove_program_from_wallet
    logout
  end

  it 'Add FF program (auto update) with correct login/password. Two steps authentication. - WL06', broken: true do
    register
    wallet_add_new
    add_only_program 0
    close_learning_popup
    autoupdate_credentials starwood_user
    starwood_question
    autoupdate_answer
    # autoupdate_error 'Iberia Plus'
    # close_flash_message
    # autoupdate_credentials iberia_user
    # autoupdate_answer
    # close_flash_message
    sleep 1
    wallet_save_account_btn
    # sleep 2
    # remove_program_from_wallet
    logout
  end

end
