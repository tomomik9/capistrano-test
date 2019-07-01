require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  # Validation Test
  should validate_presence_of :follower_id
  should validate_presence_of :followed_id
end
