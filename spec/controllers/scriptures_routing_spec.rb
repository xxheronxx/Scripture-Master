require File.dirname(__FILE__) + '/../spec_helper'

describe ScripturesController do
  describe "route generation" do

    it "should map { :controller => 'scriptures', :action => 'index' } to /scriptures" do
      route_for(:controller => "scriptures", :action => "index").should == "/scriptures"
    end
  
    it "should map { :controller => 'scriptures', :action => 'new' } to /scriptures/new" do
      route_for(:controller => "scriptures", :action => "new").should == "/scriptures/new"
    end
  
    it "should map { :controller => 'scriptures', :action => 'show', :id => 1 } to /scriptures/1" do
      route_for(:controller => "scriptures", :action => "show", :id => 1).should == "/scriptures/1"
    end
  
    it "should map { :controller => 'scriptures', :action => 'edit', :id => 1 } to /scriptures/1/edit" do
      route_for(:controller => "scriptures", :action => "edit", :id => 1).should == "/scriptures/1/edit"
    end
  
    it "should map { :controller => 'scriptures', :action => 'update', :id => 1} to /scriptures/1" do
      route_for(:controller => "scriptures", :action => "update", :id => 1).should == "/scriptures/1"
    end
  
    it "should map { :controller => 'scriptures', :action => 'destroy', :id => 1} to /scriptures/1" do
      route_for(:controller => "scriptures", :action => "destroy", :id => 1).should == "/scriptures/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'scriptures', action => 'index' } from GET /scriptures" do
      params_from(:get, "/scriptures").should == {:controller => "scriptures", :action => "index"}
    end
  
    it "should generate params { :controller => 'scriptures', action => 'new' } from GET /scriptures/new" do
      params_from(:get, "/scriptures/new").should == {:controller => "scriptures", :action => "new"}
    end
  
    it "should generate params { :controller => 'scriptures', action => 'create' } from POST /scriptures" do
      params_from(:post, "/scriptures").should == {:controller => "scriptures", :action => "create"}
    end
  
    it "should generate params { :controller => 'scriptures', action => 'show', id => '1' } from GET /scriptures/1" do
      params_from(:get, "/scriptures/1").should == {:controller => "scriptures", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'scriptures', action => 'edit', id => '1' } from GET /scriptures/1;edit" do
      params_from(:get, "/scriptures/1/edit").should == {:controller => "scriptures", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'scriptures', action => 'update', id => '1' } from PUT /scriptures/1" do
      params_from(:put, "/scriptures/1").should == {:controller => "scriptures", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'scriptures', action => 'destroy', id => '1' } from DELETE /scriptures/1" do
      params_from(:delete, "/scriptures/1").should == {:controller => "scriptures", :action => "destroy", :id => "1"}
    end
  end
end