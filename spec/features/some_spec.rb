describe 'some test' do
  it "should be awesome" do
    foo = ENV['bar'].to_i
    expect(foo).to eq(3)
  end
end
