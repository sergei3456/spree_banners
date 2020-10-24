# frozen_string_literal: true

module Spree
  class Banner < Spree::Base
    has_one_attached :image, dependent: :destroy
    enum types: {
      front_slider: 'front_slider',
      front_right: 'front_right',
      front_left: 'front_left',
      left_sidebar: 'left_sidebar',
      right_sidebar: 'right_sidebar',
      menu: 'menu',
      top: 'top',
      bottom: 'bottom'
    }

    enum pages: {
      front: 'front',
      category: 'category',
      page: 'page'
    }

    validates :title, presence: true
    validate :image, :acceptable_image
    validates :link, presence: true
    validates :start, presence: true
    validates :location_type, presence: true
    validates :location_page, presence: true

    scope :banner_front_slider_published, lambda {
      where(location_type: 'front_slider').where(visible: true).order('position ASC').first(3)
    }

    scope :banner_front_left_published, lambda {
      where(location_page: 'front').where(location_type: 'front_left').where(visible: true).order(position: :asc).first
    }

    scope :banner_front_all, lambda {
      where.not(location_type: 'front_slider').where(location_page: 'front').where(visible: true).order(position: :asc)
    }

    def self.types_select
      types.map do |k, v|
        [human_enum_name(:types, k), v]
      end
    end

    def self.pages_select
      pages.map do |k, v|
        [human_enum_name(:pages, k), v]
      end
    end

    def self.human_enum_name(enum_name, enum_value)
      enum_i18n_key = enum_name.to_s.pluralize
      I18n.t("#{enum_i18n_key}.#{enum_value}")
    end

    def acceptable_image
      return unless image.attached?

      errors.add(:image, 'Максимальный размер картинки 2 МВ') unless image.byte_size <= 2.megabyte

      acceptable_types = %w[image/jpeg image/jpg image/png image/gif]
      errors.add(:main_image, 'Формат должен быть jpg, png, gif') unless acceptable_types.include?(image.content_type)
    end

    def model_class
      Spree::Banner
    end
  end
end
