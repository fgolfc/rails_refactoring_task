module PlayerDecorator
  belongs_to :club
  
  def full_name
    "#{first_name} #{last_name}"
  end
end