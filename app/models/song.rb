class Song < ActiveRecord::Base
  has_attached_file :mp3
  belongs_to :user
  
  validates_attachment_presence :mp3
  validates_attachment_content_type :mp3, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ]
  validates_attachment_size :mp3, :less_than => 10.megabytes  
end
