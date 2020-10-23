# frozen_string_literal: true

module Spree
  module Admin
    class BannersController < ResourceController
      respond_to :html

      def index
        respond_with(@collection)
      end

      def show
        redirect_to(action: :edit)
      end

      def edit
        @banner = Spree::Banner.find(params[:id])
      end

      def clone
        @new = @banner.duplicate
        flash.notice = if @new.save
                         I18n.t('notice_messages.banner_cloned')
                       else
                         I18n.t('notice_messages.banner_not_cloned')
                       end

        respond_with(@new) { |format| format.html { redirect_to edit_admin_banner_url(@new) } }
      end

      protected

      def find_resource
        Spree::Banner.find(params[:id])
      end

      def location_after_save
        request.referrer
      end

      def banner_params
        params.require(:banner).permit(:title, :description, :link, :start, :end, :location_type, :location_page, :position, :visible)
      end
    end
  end
end
