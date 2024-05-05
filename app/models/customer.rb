class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, presence: true
  validate :cpf_validate

  def description
    "#{name} <#{email}>"
  end

  private

  def cpf_validate
    return if CPF.new(cpf).valid?

    errors.add(:cpf, 'deve ser válido.')
  end
end
