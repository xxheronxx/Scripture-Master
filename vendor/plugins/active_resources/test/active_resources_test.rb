require File.expand_path(File.dirname(__FILE__) + "/test_helper")
require 'mock_active_record'
require 'action_controller/url_rewriter'

class ActiveResourcesTest < Test::Unit::TestCase
  include MockActiveRecord::Mixin
  public
  def setup
    mock :Book do |book|
      book.column :id, :integer
      book.column :title, :string
      book.has_many :authorships
      book.has_many :authors, :through => :authorships
      book.has_one  :publisher
    end
    
    mock :Author do |author|
      author.column :id, :integer
      author.column :name, :string
      author.has_many :authorships
      author.has_many :books, :through => :authorships
    end
    
    mock :Authorship do |authorship|
      authorship.column :book_id, :integer
      authorship.column :author_id, :integer
      authorship.belongs_to :book
      authorship.belongs_to :author
    end
    
    mock :User do |user|
      user.column :id, :integer
      user.column :login, :string
      user.has_many :books
    end
    
    ActionController::Routing::Routes.draw do |map|
      map.active_resources :authorships
      map.active_resources :authors, :books, :exclude => :authorships
      map.active_resources :users
      map.active_resource  :profile, :active_record_class => User.name, :name_prefix => 'my_',
                              :books => { :controller => 'my_books' }
    end
  end

  def test_route_generation
    url = ActionController::UrlRewriter.new(ActionController::TestRequest.new, {})
    
    assert_routing  "/books",                
                    :controller => "books",           :action => 'index'
    assert_equal "/books", url.rewrite(:use_route => 'books', :only_path => true)
    assert_equal "/books/new", url.rewrite(:use_route => 'new_book', :only_path => true)
    assert_equal "/books/5/authors", url.rewrite(:use_route => "book_authors", :only_path => true, :book_id => 5)
    assert_equal "/profile/books", url.rewrite(:use_route => 'my_profile_books', :only_path => true)
    
    assert_routing  "/books/5/authors/2",    
                    :controller => "book_authors",    :action => "show",  :book_id => '5',  :id => '2'
    assert_routing  "/books/5/authors",      
                    :controller => "book_authors",    :action => "index", :book_id => '5'
    assert_routing  '/books/5/publisher',
                    :controller => 'book_publisher',  :action => 'show',  :book_id => '5'
    assert_routing  '/authors/2/books',      
                    :controller => 'author_books',    :action => 'index', :author_id => '2'
    assert_routing  '/authors/2/books/new',  
                    :controller => 'author_books',    :action => 'new',   :author_id => '2'
    assert_routing  '/authorships/4/book',   
                    :controller => 'authorship_book', :action => 'show',  :authorship_id => '4'
    assert_routing '/users',
                    :controller => 'users',           :action => 'index'
    # assert_routing doesn't allow for passing a method option
    assert_recognizes({:controller => 'user_books',   :action => 'destroy', :user_id => '15', :id => '12'},
                      {:path => '/users/15/books/12', :method => :delete })  
    assert_generates( '/users/15/books/12', 
                      {:controller => 'user_books',   :action => 'destroy', :user_id => '15', :id => '12'})  
    assert_routing '/profile',
                    :controller => 'profile',      :action => 'show'
    assert_routing '/profile/books',
                    :controller => 'my_books',        :action => 'index'
  end
  
  # Make sure that we don't get errors about missing controller classes
  def Object.const_missing(name)
    if name.to_s =~ /Controller$/
      Kernel.module_eval <<-__END__
      class #{name} < ActionController::Base
      end
      __END__
      return Kernel.const_get(name)
    else
      super
    end
  end
end
