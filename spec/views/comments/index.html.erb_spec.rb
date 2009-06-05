require File.dirname(__FILE__) + '/../../spec_helper'

describe "/comments/index.html.erb" do
  include CommentsHelper
  
  before(:each) do
    comment_98 = mock_model(Comment)
    comment_98.should_receive(:user_id).and_return("1")
    comment_98.should_receive(:commentable_id).and_return("1")
    comment_98.should_receive(:commentable_type).and_return("MyString")
    comment_98.should_receive(:body).and_return("MyText")
    comment_99 = mock_model(Comment)
    comment_99.should_receive(:user_id).and_return("1")
    comment_99.should_receive(:commentable_id).and_return("1")
    comment_99.should_receive(:commentable_type).and_return("MyString")
    comment_99.should_receive(:body).and_return("MyText")

    assigns[:comments] = [comment_98, comment_99]
  end

  it "should render list of comments" do
    render "/comments/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

