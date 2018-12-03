require 'rails_helper'

RSpec.describe User, type: :model do
  xdescribe ".lazy_find" do
    let!(:user_1) { create(:user) }
    let!(:user_2) { create(:user) }

    it "should lazily load users and not run any SQL queries if no methods are called on the lazy objects" do
      expect(User).to_not receive(:find_by_sql)
      User.lazy_find(user_1.id)
      User.lazy_find(user_2.id)
    end

    it "should lazily load users and run a single SQL query if a method is called on any lazy object" do
      expect(User).to receive(:find_by_sql).and_call_original.once
      lazy_user_1 = User.lazy_find(user_1.id)
      lazy_user_2 = User.lazy_find(user_2.id)

      expect(lazy_user_1.username).to eq(user_1.username)
      expect(lazy_user_2.username).to eq(user_2.username)
    end
  end
end
