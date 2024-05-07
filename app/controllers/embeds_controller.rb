class EmbedsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @embed = RicherText::OEmbed.from_url(params[:id])

    if @embed
      render json: {
        sgid: @embed.embeddable_sgid,
        content: "<richer-text-embed sgid=\"#{@embed.embeddable_sgid}\"></richer-text-embed>"
      }
    else
      head :not_found
    end
  end

  def show
    @embed = RicherText::Embed.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render html: "Embed not found", status: :not_found
  end

  def patterns
    render json: RicherText::OEmbed::PATTERNS
  end
end
