class Honorary < ActiveRecord::Base
  attr_accessible :hon_cantidad, :hon_fecha
  belongs_to :construction
end
