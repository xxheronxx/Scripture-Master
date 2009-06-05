require File.dirname(__FILE__) + '/../../spec_helper'

describe "/links/index.html.erb" do
  include LinksHelper
  
  before(:each) do
    link_98 = mock_model(Link)
    link_98.should_receive(:scripture1_id).and_return("1")
    link_98.should_receive(:scripture2_id).and_return("1")
    link_98.should_receive(:note).and_return("MyText")
    link_99 = mock_model(Link)
    link_99.should_receive(:scripture1_id).and_return("1")
    link_99.should_receive(:scripture2_id).and_return("1")
    link_99.should_receive(:note).and_return("MyText")

    assigns[:links] = [link_98, link_99]
  end

  it "should render list of links" do
    render "/links/index.html.erb"
    response.should have_tag("tr>td", "MyText", 2)
  end
end

