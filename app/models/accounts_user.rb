class AccountsUser < ActiveRecord::Base
belongs_to :user
belongs_to :account
end
