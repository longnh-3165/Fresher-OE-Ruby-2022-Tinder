module MatchPagesHelper
  extend ActiveSupport::Concern

  class_methods do
    def get_filter_range min, max
      now = Time.now.utc.to_date
      now.years_ago(max)..now.years_ago(min)
    end
  end

  def new_relationship
    current_user.active_relationships.build
  end

  def get_relationship followed_id
    current_user.active_relationships.find_by(followed_id: followed_id)
  end
end
