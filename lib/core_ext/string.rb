class String
  def nullable_to_f
    self.blank? ? nil : self.to_f
  end
end
