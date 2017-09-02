class RegistrationsController < Devise::RegistrationsController
  def signup
    params.require(:user).permit(:name, :email,
                                 :password,:password_confirmation,
                                :grill, :line, :juice, :cashier,
                                :baking, :coldpress, :status)
  end
end
