module Api
  module V1
    class AirlinesController < ApiController

      before_action :authenticate, only: %i[create update destroy]


      def index
        airlines = Airline.all
        AirlineSerializer.new(airlines).serialized_json
        # render json: AirlineSerializer.new(airlines).serialized_json
      end

      def show
        airline = Airline.find_by(slug: params[:slug])

        render json: AirlineSerializer.new(airline).serialized_json
      end

      def create
        airline = Airline.new(airline_paramas)

        if airline.save
          render json: AirlineSerializer.new(airline).serialized_json
        else
          render json: { erro: airline.error.messages }, status: 422
        end
      end

      def update
        airline = Airline.find_by(slug: params[:slug])

        if airline.update(airline_paramas)
          render json: AirlineSerializer.new(airline).serialized_json
        end
        render json: { erro: airline.error.messages }, status: 422

      end


      def destroy
        airline = Airline.find_by(slug: params[:slug])

        if airline.destroy
          head :no_content
        end
        render json: { erro: airline.error.messages }, status: 422

      end

      private

      def airline_paramas
        params.require(:airline).permit(:name, :image_url)
      end
    end
  end
end
