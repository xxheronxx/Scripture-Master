class Link < ActiveRecord::Base
  has_many :comments, :as => :commentabel
  belongs_to :refered_to, :class_name => "Scripture"
  belongs_to :refered_from, :class_name => "Scripture"
end
