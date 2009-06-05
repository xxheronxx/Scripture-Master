require File.dirname(__FILE__) + '/../../spec_helper'

describe "/comments/show.html.erb" do
  include CommentsHelper
  
  before(:each) do
    @comment = mock_model(Comment)
    @comment.stub!(:user_id).and_return("1")
    @comment.stub!(:commentable_id).and_return("1")
    @comment.stub!(:commentable_type).and_return("MyString")
    @comment.stub!(:body).and_return("MyText")

    assigns[:comment] = @comment
  end

  it "should render attributes in <p>" do
    render "/comments/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

