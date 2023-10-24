class User < ApplicationRecord
    pay_customer

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

    har_person_name

    has_many :tweets
    has_many :comments
end
