class << ActiveRecord::Base  
  @field_error_procs = Hash.new
  class << self; attr_accessor :field_error_procs; end;
  
  def custom_field_error(html, name = self.name.downcase)
    self.class.field_error_procs.include?(name) ? nil : self.class.field_error_procs[name] = html
    
    ActionView::Base.field_error_proc = Proc.new do |html, info|
      if self.class.field_error_procs['default'].blank? && !self.class.field_error_procs[info.object_name].blank?
          current_proc = self.class.field_error_procs[info.object_name]        
          current_proc.blank? ? '<div class="fieldWithErrors">' + html + '</div>' : current_proc.sub(/\?/, html).to_s
      else
        self.class.field_error_procs['default'].sub(/\?/, html).to_s
      end
    end
  end
end