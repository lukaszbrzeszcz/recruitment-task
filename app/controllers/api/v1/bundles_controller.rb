class Api::V1::BundlesController < ApplicationController
  def create
    resp = Bundles::Create.call(topics: bundle_params.to_h)

    render json: resp.quotes, status: :ok
  end

  private

  def bundle_params
    params.require(:topics).permit!
  end
end
