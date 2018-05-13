class String
  def nullable_to_f
    self.blank? ? nil : self.to_f
  end

  def nullable_to_boolean
    return nil if self.blank?
    
    ['1', 'true', 'yes', 't', 'y'].include?(self.downcase.squish)
  end
end
