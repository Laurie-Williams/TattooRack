class Category < ActiveRecord::Base

  # associations
  has_many :pieces

  def self.get_id_from_name(name)
    case name
      when "tattoo"
        return 1
      when "flash"
        return 2
      when "artwork"
        return 3
      when "inspiration"
        return 4
    end
  end

end
