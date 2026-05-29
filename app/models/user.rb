class User < ApplicationRecord
  enum :role, { user: 0, admin: 2, ysws_org: 1 }
  has_many :projects, dependent: :destroy
  has_many :debts_owed, class_name: "Debt", foreign_key: "owed_id", dependent: :destroy
  has_many :debts_owing, class_name: "Debt", foreign_key: "owing_id", dependent: :destroy
end