# frozen_string_literal: true

class Mutations::Auth::ForgotPassword < GraphQL::Schema::Mutation
  argument :email, String, required: true do
    description 'The email with forgotten password'
  end

  field :errors, [::Types::Auth::Error], null: false
  field :success, Boolean, null: false
  field :valid, Boolean, null: false

  def resolve(email:)
    user = User.where(locked_at: nil).find_by email: email

    user.send_reset_password_instructions if user.present?

    {
      errors: [],
      success: true,
      valid: true
    }
  end
end
