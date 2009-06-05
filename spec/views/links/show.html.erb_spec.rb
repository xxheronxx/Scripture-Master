require File.dirname(__FILE__) + '/../../spec_helper'

describe "/links/show.html.erb" do
  include LinksHelper
  
  before(:each) do
    @link = mock_model(Link)
    @link.stub!(:scripture1_id).and_return("1")
    @link.stub!(:scripture2_id).and_return("1")
    @link.stub!(:note).and_return("MyText")

    assigns[:link] = @link
  end

  it "should render attributes in <p>" do
    render "/links/show.html.erb"
    response.should have_text(/MyText/)
  end
end

