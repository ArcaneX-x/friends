class PreferencesController < ApplicationController
  before_action :set_preference, only: [:update]

  def update
    if current_user.preference.update(preference_params)
      redirect_to current_user, notice: 'Settings saved'
    else
      flash[:alert] = 'Information incorrect'
      redirect_to current_user, notice: ''
    end
  end

  private

  def set_preference
    @preference = Preference.find(params[:id])
  end

  def preference_params
    params.require(:preference).permit(:theme, :locale)
  end
end
