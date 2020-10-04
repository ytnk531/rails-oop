class ServiceChargesController < ApplicationController
  def create
    affiliation
      .service_charges
      .create(service_charge_params)
  end

  private

  def affiliation
    Affiliation.find_by(member_id: params[:member_id])
  end

  def service_charge_params
    params.require(:service_charge).permit(:date, :hours)
  end
end
