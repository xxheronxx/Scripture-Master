require File.dirname(__FILE__) + '/../../spec_helper'

describe "/scriptures/edit.html.erb" do
  include ScripturesHelper
  
  before do
    @scripture = mock_model(Scripture)
    @scripture.stub!(:reference).and_return("MyString")
    @scripture.stub!(:url).and_return("MyString")
    @scripture.stub!(:text).and_return("MyText")
    assigns[:scripture] = @scripture
  end

  it "should render edit form" do
    render "/scriptures/edit.html.erb"
    
    response.should have_tag("form[action=#{scripture_path(@scripture)}][method=post]") do
      with_tag('input#scripture_reference[name=?]', "scripture[reference]")
      with_tag('input#scripture_url[name=?]', "scripture[url]")
      with_tag('textarea#scripture_text[name=?]', "scripture[text]")
    end
  end
end


