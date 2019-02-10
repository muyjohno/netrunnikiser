require 'rmagick'
require 'pry'

module Netrunnikers
  class Card
    attr_reader :title, :description, :category, :points, :number
    attr_reader :image

    def initialize(options = {})
      @title = options[:title]
      @description = options[:description] || ""
      @category = options[:category] || ""
      @points = options[:points] || ""
      @number = options[:number] || ""
      @image = Magick::Image.new(670,920)
    end

    def built_image!
      @built_image ||= image.tap do
        add_text_obj(title, :title)
        add_text_obj(description, :description)
        add_text_obj(category, :category)
        add_text_obj(points, :points)
        add_text_obj("POINTS", :points_label)
        add_text_obj(number, :number)
      end
    end

    def self.build!(options = {})
      new(options).built_image!
    end

    private

    GRAVITIES = {
      description: Magick::NorthWestGravity
    }

    FONT_DIR = "#{File.expand_path(File.dirname(__FILE__))}/fonts".freeze
    FONTS = {
      title: "#{FONT_DIR}/MonkirtaPursuitNC.ttf",
      description: "#{FONT_DIR}/GillSans.ttc",
      category: "#{FONT_DIR}/MinionPro-It.otf",
      points: "#{FONT_DIR}/ufonts.com_bank-gothic-medium.ttf",
      points_label: "#{FONT_DIR}/MinionPro-Bold.otf",
      number: "#{FONT_DIR}/MonkirtaPursuitNC.ttf"
    }

    DIMENSIONS = {
      title: { size: 60, width: 503, height: 216, x: 86, y: 86 },
      description: { size: 30, width: 514, height: 308, x: 82, y: 422 },
      category: { size: 40, width: 586, height: 41, x: 42, y: 738 },
      points: { size: 60, width: 46, height: 62, x: 320, y: 783 },
      points_label: { size: 30, width: 114, height: 30, x: 284, y: 847 },
      number: { size: 25, width: 47, height: 28, x: 566, y: 850 }
    }

    WRAPS = {
      title: 18,
      description: 40
    }

    def add_text_obj(text, key)
      Magick::Draw.new.tap do |obj|
        obj.gravity = GRAVITIES[key] || Magick::NorthGravity
        obj.font = FONTS[key]
        obj.pointsize = DIMENSIONS[key][:size]
        obj.annotate(
          image,
          DIMENSIONS[key][:width],
          DIMENSIONS[key][:height],
          DIMENSIONS[key][:x],
          DIMENSIONS[key][:y],
          word_wrap(text.to_s, WRAPS[key] || 999)
        )
      end
    end

    def word_wrap(text, width = 999)
      text.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
    end
  end
end
