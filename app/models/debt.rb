class Debt < ApplicationRecord
  belongs_to :owed, class_name: "User", optional: true
  belongs_to :owing , class_name: "User"
  belongs_to :project

  enum :status, { pending: 0, approved: 1, rejected: 2, paid: 3, canceled: 4 }
end