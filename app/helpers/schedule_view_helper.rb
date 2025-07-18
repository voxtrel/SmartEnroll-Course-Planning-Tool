module ScheduleViewHelper
    def next_term
      today = Date.today
      year = today.year

      case today
      when Date.new(year, 1, 1)..Date.new(year, 5, 15)
        "Summer #{year}"
      when Date.new(year, 5, 16)..Date.new(year, 8, 10)
        "Fall #{year}"
      else
        "Spring #{year + 1}"
      end
    end

    def build_term_dropdown
      current_year = Date.today.year
      seasons = [ "Spring", "Summer", "Fall" ]

      terms = []

      # Generate terms for the next two years and the previous terms
      (current_year - 1..current_year + 1).each do |year|
        seasons.each do |season|
          terms << "#{season} #{year}"
        end
      end

      # Sort terms by year and season order (Spring, Summer, Fall)
      terms.sort_by { |term| [ term.split.last.to_i, seasons.index(term.split.first) ] }
    end
end
