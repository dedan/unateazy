module WorksHelper


  def limit_to number, string
    if string.length > number
      return string[0..number] + ".."
    end
      string
  end

end
