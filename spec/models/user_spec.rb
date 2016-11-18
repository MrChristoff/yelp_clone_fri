require 'rails_helper'

describe User, type: :model do
  # it 'is expected to have many reviewed restaurants' do
    it { is_expected.to have_many :reviewed_restaurants}
  # end
end
