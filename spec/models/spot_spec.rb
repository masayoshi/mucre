# == Schema Information
#
# Table name: spots
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Spot do
  pending "add some examples to (or delete) #{__FILE__}"
end
