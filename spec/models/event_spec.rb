# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  place          :string(255)
#  address        :string(255)
#  latitude       :float
#  longitude      :float
#  description    :text
#  url            :string(255)
#  fee            :integer          default(0), not null
#  start_datetime :datetime
#  end_datetime   :datetime
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end
