require File.dirname(__FILE__) + '/../../spec_helper'

describe "/links/new.html.erb" do
  include LinksHelper
  
  before(:each) do
    @link = mock_model(Link)
    @link.stub!(:new_record?).and_return(true)
    @link.stub!(:scripture1_id).and_return("1")
    @link.stub!(:scripture2_id).and_return("1")
    @link.stub!(:note).and_return("MyText")
    assigns[:link] = @link
  end

  it "should render new form" do
    render "/links/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", links_path) do
      with_tag("textarea#link_note[name=?]", "link[note]")
    end
  end
end


