module ApplicationHelper
    def next_term
      today = Date.today
      year = today.year

      case today
      when Date.new(year, 1, 1)..Date.new(year, 5, 15)
        "Summer #{year}"
      when Date.new(year, 5, 16)..Date.new(year, 8, 10)
        "Fall #{year}"
      when Date.new(year, 8, 11)..Date.new(year, 12, 31)
        "Spring #{year + 1}"
      else
        "Spring #{year}" # fallback
      end
    end
end
