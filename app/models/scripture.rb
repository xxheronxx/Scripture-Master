class Scripture < ActiveRecord::Base
  validates_presence_of :text, :book
  has_many :comments, :as => :commentable
  has_many :linked_tos, :foreign_key => 'refered_to_id',
                      :class_name => 'Link',
                      :dependent => :destroy
  has_many :refered_tos, :through => :linked_tos
  has_many :linked_froms,  :foreign_key => 'refered_from_id',
                          :class_name => 'Link',
                          :dependent => :destroy
  has_many :refered_froms, :through => :linked_froms
  
  def standard_works
    [
      "1 Nephi",
      "2 Nephi",
      "Jacob",
      "Enos",
      "Jarom",
      "Omni",
      "Words of Mormon",
      "Mosiah",
      "Alma",
      "Heleman",
      "Third Nephi",
      "Fourth Nephi",
      "Mormon",
      "Ether",
      "Moroni"
    ]
  end
  
  def standard_work? ()
    #need to write a regular expression for this, as well as an array of books of scripture?
    standard_works = 
    [
      "1 Nephi",
      "2 Nephi",
      "Jacob",
      "Enos",
      "Jarom",
      "Omni",
      "Words of Mormon",
      "Mosiah",
      "Alma",
      "Heleman",
      "Third Nephi",
      "Fourth Nephi",
      "Mormon",
      "Ether",
      "Moroni"
    ]
    
    if standard_works.include?(self.book) and self.chapter.to_i > 0 and self.verse.to_i > 0
      true
    else
      false
    end
    
  end
  
  def make_link()
    scripture_abreviations = {
      "1 Nephi" => "1_ne",
      "2 Nephi" => "2_ne",
      "Jacob" => "jacob",
      "Enos" => "enos",
      "Jarom" => "jarom",
      "Omni" => "omni",
      "Words of Mormon" => "w_o_m",
      "Mosiah" => "mosiah",
      "Alma" => "alma",
      "Heleman" => "hel",
      "Third Nephi" => "3_ne",
      "Fourth Nephi" => "4_ne",
      "Mormon" => "morm",
      "Ether" => "ether",
      "Moroni" => "moro"
    }
    if standard_work?()
      link = "http://scriptures.lds.org/en/" + scripture_abreviations[self.book]+'/'+self.chapter+'/'+self.verse
    end
    link
  end
  
  def full_reference
    self.book + " " + self.chapter + ":" + self.verse
  end

end
