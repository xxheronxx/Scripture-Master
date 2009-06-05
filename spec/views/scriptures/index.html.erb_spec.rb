require File.dirname(__FILE__) + '/../../spec_helper'

describe "/scriptures/index.html.erb" do
  include ScripturesHelper
  
  before(:each) do
    scripture_98 = mock_model(Scripture)
    scripture_98.should_receive(:reference).and_return("MyString")
    scripture_98.should_receive(:url).and_return("MyString")
    scripture_98.should_receive(:text).and_return("MyText")
    scripture_99 = mock_model(Scripture)
    scripture_99.should_receive(:reference).and_return("MyString")
    scripture_99.should_receive(:url).and_return("MyString")
    scripture_99.should_receive(:text).and_return("MyText")

    assigns[:scriptures] = [scripture_98, scripture_99]
  end

  it "should render list of scriptures" do
    render "/scriptures/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

