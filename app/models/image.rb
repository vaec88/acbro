class Image < ActiveRecord::Base
  attr_accessible :img_path, :construction_id
  belongs_to :construction

  has_attached_file :img_path,
#    :default_url => ":rails_root/app/assets/images/constructions/no_image_construction.png",
#    :path => ":rails_root/app/assets/images/constructions/:construction_id/:basename_:style.:extension",
#    :url => ":rails_root/app/assets/images/constructions/:construction_id/:basename_:style.:extension",


    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    
    :default_url => "https://dl.dropboxusercontent.com/u/246482361/local/constructions/no_image_construction.png",
    :path => "local/constructions/:construction_id/:basename_:style.:extension",
    :url => "local/constructions/:construction_id/:basename_:style.:extension",
  
    #:default_url => "/images/usuarios/perfil.jpg",
    #:path => ":rails_root/public/images/usuarios/:id/:basename_:style.:extension",
    #:url => "/images/usuarios/:id/:basename_:style.:extension",
    :default_style => :small,
    #:path => ':rails_root/public:url',
	    :styles => {
        #:thumb=> "100x100#",
	      #:small  => "150x150>",
	      :thumb=> "200x200#",
	      :small=> "250x250>"}
	  # Validaciones de Paperclip
	  validates_attachment_size :img_path, :less_than => 2.megabytes
	  validates_attachment_content_type :img_path, :content_type => ['image/jpeg', 'image/png']
end
