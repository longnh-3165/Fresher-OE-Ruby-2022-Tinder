module UsersHelper
  def cities
    Country.pluck(:name, :id)
  end
end
