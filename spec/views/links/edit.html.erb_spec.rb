require File.dirname(__FILE__) + '/../../spec_helper'

describe "/links/edit.html.erb" do
  include LinksHelper
  
  before do
    @link = mock_model(Link)
    @link.stub!(:scripture1_id).and_return("1")
    @link.stub!(:scripture2_id).and_return("1")
    @link.stub!(:note).and_return("MyText")
    assigns[:link] = @link
  end

  it "should render edit form" do
    render "/links/edit.html.erb"
    
    response.should have_tag("form[action=#{link_path(@link)}][method=post]") do
      with_tag('textarea#link_note[name=?]', "link[note]")
    end
  end
end


