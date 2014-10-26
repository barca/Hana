class lesson < ActiveRecord::Base
  attr_accessible :instructor, :max_num, :age_group, :name, :room, :time, :desc
end
