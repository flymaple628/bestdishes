class Dish < ActiveRecord::Base

	belongs_to :user
	belongs_to :restaurant

	has_many :comments, :dependent => :destroy
	has_many :dish_tagsships, :dependent => :destroy
	has_many :tags ,:through=>:dish_tagsships

	has_many :user_dishships, :dependent => :destroy
	has_many :faverites ,:through=>:user_dishships

	has_many :dish_likes, :dependent => :destroy
	has_many :likes ,:through=>:dish_likes,:source=>:user


	has_attached_file :realpic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :realpic, :content_type => /\Aimage\/.*\Z/

  def tag_name
  	self.tags.map{|t| t.name}.join(",")
  end

  def tag_name=(str)
  	ids=str.split(",").map do |tag_name|
  		tag_name.strip!
  		tag=Tag.find_by_name( tag_name ) || Tag.create( :name => tag_name )
  		tag.id
  	end
  	self.tag_ids=ids
  end
end
