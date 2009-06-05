require File.dirname(__FILE__) + '/../../spec_helper'

describe "/comments/new.html.erb" do
  include CommentsHelper
  
  before(:each) do
    @comment = mock_model(Comment)
    @comment.stub!(:new_record?).and_return(true)
    @comment.stub!(:user_id).and_return("1")
    @comment.stub!(:commentable_id).and_return("1")
    @comment.stub!(:commentable_type).and_return("MyString")
    @comment.stub!(:body).and_return("MyText")
    assigns[:comment] = @comment
  end

  it "should render new form" do
    render "/comments/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", comments_path) do
      with_tag("input#comment_commentable_type[name=?]", "comment[commentable_type]")
      with_tag("textarea#comment_body[name=?]", "comment[body]")
    end
  end
end


