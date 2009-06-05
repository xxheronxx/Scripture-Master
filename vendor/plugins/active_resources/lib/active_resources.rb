require 'action_controller'
module ActionController #:nodoc:
  # Creates RESTful, nested resources based on an ActiveRecord model's associations
  # 
  # Example:
  #   class Book < ActiveRecord::Base
  #     has_many :authorships
  #     has_many :authors, :through => :authorships
  #     has_one  :publisher
  #   end
  #
  #   class User < ActiveRecord::Base
  #     has_many :books
  #   end
  #
  #   map.active_resources :books, :exclude => :authorships 
  #   map.active_resource  :my_profile, :active_record_class => User.name, :books => { :controller => 'my_books' }
  #
  # is equivalent to:
  #
  #   map.resources :books do |books|
  #     books.resources :authors, :controller => 'book_authors'
  #     books.resource  :publisher, :controller => 'book_publisher'
  #   end
  #   map.resource :my_profile do |my_profile|
  #     my_profile.resources :books, :controller => 'my_books'
  #   end
  #
  # Any options valid for ActionController::Resources are valid to active_resource and active_resources, as well
  # * options[association.name] will be passed to the appropriate nested resource call
  # * if the association type is has_one or belongs_to, a singleton nested resource is created.
  #
  module ActiveResources 
    class ActiveResource < ActionController::Resources::Resource #:nodoc:
      attr_reader :active_record_class
      attr_reader :exclude_associations
      def initialize(entities, options)
        super(entities, options)
        @active_record_class = Kernel.const_get(options.delete(:active_record_class) || @singular.camelize)
        @exclude_associations = [options.delete(:exclude)].flatten
      end
      
      # Returns all the associations for the model class which are not on the exclusion list
      def associations
        active_record_class.reflect_on_all_associations.reject{|assoc| @exclude_associations.include?(assoc.name)}
      end
      
      # Generates a default name_prefix for naming the nested resource routes
      def nesting_name_prefix
        np = name_prefix.nil? ? nil : name_prefix.sub(/_$/, '')
        [np, singular].reject{|i|i.nil?}.join('_')
      end
    end
    
    # Create an active resource. By default, the model class is the singular, camelized form of the resource name, but
    # can be overridden with the :active_record_class option. Any associations you do not want nested should be listed
    # in the :exclude option. Provide options to nested resource calls by providing an option named for the association
    # with the options hash as its value (i.e. :books => { :controller => 'my_books' }). All other options are passed 
    # through to the resources call
    def active_resources(*entities, &block) # :yields: map
      options = entities.last.is_a?(Hash) ? entities.pop : { }
      entities.each do |entity| 
        map_resource(entity, options.dup) do |map|
          block(map) if block_given?
          map_associations(map, ActiveResource.new(entity, options.dup), options)
        end
      end
    end
    
    # Create a singleton active resource. By default, the model class is the camelized form of the resource name, but
    # can be overridden with the :active_record_class option. Any associations you do not want nested should be listed
    # in the :exclude option. Provide options to nested resource calls by providing an option named for the association
    # with the options hash as its value (i.e. :books => { :controller => 'my_books' }). All other options are passed 
    # through to the resource call
    def active_resource(*entities, &block) # :yields: map
      options = entities.last.is_a?(Hash) ? entities.pop : { }
      entities.each do |entity| 
        map_singleton_resource(entity, options.dup) do |map|
          block(map) if block_given?
          map_associations(map, ActiveResource.new(entity, options.dup), options)
        end
      end
    end

    private
      # Creates the nested resources based on associations
      def map_associations(map, resource, options={}) # :doc:
        resource.associations.each do |assoc|
          map.with_options( :name_prefix => resource.nesting_name_prefix + "_",
                            :controller => [resource.nesting_name_prefix, assoc.name.to_s].join("_")) do |newmap|
            if [:has_one, :belongs_to].include?(assoc.macro)
              newmap.resource(assoc.name, options[assoc.name] || {})
            else
              newmap.resources(assoc.name, options[assoc.name] || {})
            end
          end
        end
      end
  end
end

ActionController::Routing::RouteSet::Mapper.send :include, ActionController::ActiveResources