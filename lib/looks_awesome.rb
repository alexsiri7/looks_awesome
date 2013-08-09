require "looks_awesome/version"

module LooksAwesome
  module DSL
    def it_looks_awesome
      it 'looks awesome', :awesome, :js do
        LooksAwesome::Comparer.new(self).compare_screenshot
      end
    end
  end

  class Comparer
    def initialize(test)
      @test = test
      @example = test.example
    end

    def compare_screenshot
      generate_names
      if should_compare 
        take_screenshot @compare_name
        compare_images 
      else
        take_screenshot @base_name
      end
    end

    def should_compare
      File.exists?(@base_name)
    end

    def generate_names
      name = @example.metadata[:full_description]
      @base_name = "tmp/screenshots/#{name}-base.png"
      @compare_name = "tmp/screenshots/#{name}-compare.png"
      @diff_name = "tmp/screenshots/#{name}-diff.png"
    end

    def take_screenshot name
      @test.page.save_screenshot name, :full => true
    end

    def compare_images
      load_images
      run_comparison
      present_results
    end

    def load_images
      @base_image    = ChunkyPNG::Image.from_file(@base_name);
      @current_image = ChunkyPNG::Image.from_file(@compare_name)

      @min_height = [@base_image.height, @current_image.height].min
      @min_width  = [@base_image.width, @current_image.width].min
    end

    def run_comparison
      @output = ChunkyPNG::Image.new(@min_width, @min_height, WHITE)
      @diff = 0

      @min_height.times do |y|
        @min_width.times do |x|
          compare_pixel x,y
        end
      end
    end

    def compare_pixel(x,y)
      base_pixel = @base_image[x, y]
      current_pixel = @current_image[x,y]
      if base_pixel != current_pixel 
        score = Math.sqrt(
          (r(current_pixel) - r(base_pixel)) ** 2 +
          (g(current_pixel) - g(base_pixel)) ** 2 +
          (b(current_pixel) - b(base_pixel)) ** 2
        ) / Math.sqrt(MAX ** 2 * 3)

        @output[x,y] = grayscale(MAX - (score * MAX).round)
        @diff += score
      end
    end

    def present_results
      difference_percent = (@diff / @base_image.pixels.length) * 100
      
      if @base_image.pixels.length != @current_image.pixels.length
        show_error "The images differ in size"
      elsif difference_percent > 0
        show_error "The images were different in #{difference_percent}%"
      else
        File.delete(@compare_name)
      end      
    end

    def show_error(msg)
      @output.save(@diff_name)
      message = "#{msg}, the results are in #{@diff_name}"
      raise message
    end

  end

end
